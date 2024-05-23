import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jumunseo/core/logger.dart';
import 'package:jumunseo/core/login_status.dart';
import 'package:jumunseo/features/auth/data/repository/auth_repository.dart';
import 'package:jumunseo/features/auth/model/image_response_model.dart';
import 'package:jumunseo/features/auth/model/logout_model.dart';
import 'package:jumunseo/features/auth/model/profile_edit_model.dart';
import 'package:jumunseo/features/auth/model/reissue_model.dart';
import 'package:jumunseo/features/auth/model/sign_in_model.dart';
import 'package:jumunseo/features/auth/model/sign_in_response_model.dart';
import 'package:jumunseo/features/auth/model/sign_up_model.dart';
import 'package:jumunseo/features/auth/model/user_delete_model.dart';
import 'package:jumunseo/features/auth/model/user_edit_response_model.dart';
import 'package:jumunseo/features/auth/model/user_info_response_model.dart';
import 'package:jumunseo/features/auth/view/delete_user_ask_dialog.dart';
import 'package:jumunseo/features/auth/view/login_ask_dialog.dart';
import 'package:jumunseo/features/auth/view/logout_ask_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jumunseo/features/auth/view/not_network_dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
            name: '', 
            accessToken: '', 
            email: '', 
            password: '', 
            error: '', 
            isLogin: LoginStatus.isLogin, 
            cookJar: CookieJar(),
            profileImageUrl: '',));

  bool checkLogin() {
    return state.isLogin;
  }

  String getName() {
    return state.name;
  }

  String getAcessToken() {
    return state.accessToken;
  }

  String getEmail() {
    return state.email;
  }

  void setAccessToken(String accessToken_) {
    emit(state.copyWith(accessToken: accessToken_));
  }

  CookieJar getCookie() {
    return state.cookJar;
  }

  Future<void> getInfo(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return;
    }

    final baseOptions = BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
      contentType: Headers.jsonContentType,
      validateStatus: (int? status) {
        return status != null;
      },
    );

    Dio dio = Dio(baseOptions);
    dio.interceptors.addAll(
      [
        const Interceptor(),
        CookieManager(state.cookJar),
      ]
    );

    AuthRepository repo = AuthRepository(dio);
    UserInfoResponseModel userInfo;

    while(true){
      userInfo = await repo.getUserInfo(state.accessToken);

      if(userInfo.code == "FAIL" && userInfo.message == "토큰이 유효하지 않습니다.") {
        ReIssueModel reissue = await repo.getReIssue(state.accessToken);
        emit(state.copyWith(accessToken: reissue.data.accessToken));
      }
      else {
        break;
      }
    }

    if(userInfo.code == 'SUCCESS') {
      final data = userInfo.data;

      if(data != null){
        LoginStatus.name.value = data.name;
        LoginStatus.imageUrl.value = data.profileImageUrl ?? '';
        emit(state.copyWith(profileImageUrl: LoginStatus.imageUrl.value, name: LoginStatus.name.value));
      }
    }
  }

  Future<void> postImage(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return;
    }

    logger.d("이미지 클릭");
    final baseOptions = BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
      validateStatus: (int? status) {
        return status != null;
      },
    );

    Dio dio = Dio(baseOptions);
    dio.options.headers["Content-Type"] = "image/jpeg";
    dio.interceptors.addAll(
      [
        const Interceptor(),
        CookieManager(state.cookJar),
      ]
    );

    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    
    if (file != null) {
      AuthRepository repo = AuthRepository(dio);
      ImageResponseModel userInfo;
      
      while(true){
        userInfo = await repo.uploadImage(state.accessToken, File(file.path));

        if(userInfo.code == "FAIL" && userInfo.message == "토큰이 유효하지 않습니다.") {
          ReIssueModel reissue = await repo.getReIssue(state.accessToken);
          emit(state.copyWith(accessToken: reissue.data.accessToken));
        }
        else {
          break;
        }
      }

      if(userInfo.code == 'SUCCESS') {
        LoginStatus.imageUrl.value = userInfo.data ?? '';
        emit(state.copyWith(profileImageUrl: LoginStatus.imageUrl.value));
      }
    }
  }

  Future<void> deleteImage(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return;
    }

    final baseOptions = BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
      validateStatus: (int? status) {
        return status != null;
      },
    );

    Dio dio = Dio(baseOptions);
    dio.options.headers["Content-Type"] = "image/jpeg";
    dio.interceptors.addAll(
      [
        const Interceptor(),
        CookieManager(state.cookJar),
      ]
    );

    AuthRepository repo = AuthRepository(dio);
    ImageResponseModel userInfo;
    
    while(true){
      userInfo = await repo.deleteImage(state.accessToken);

      if(userInfo.code == "FAIL" && userInfo.message == "토큰이 유효하지 않습니다.") {
        ReIssueModel reissue = await repo.getReIssue(state.accessToken);
        emit(state.copyWith(accessToken: reissue.data.accessToken));
      }
      else {
        break;
      }
    }

    if(userInfo.code == 'SUCCESS') {
      LoginStatus.imageUrl.value = userInfo.data ?? '';
      emit(state.copyWith(profileImageUrl: LoginStatus.imageUrl.value));
    }
  }

  Future<bool?> duplicateEmail(String email, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return null;
    }

    final baseOptions = BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
      contentType: Headers.jsonContentType,
      validateStatus: (int? status) {
        return status != null;
      },
    );

    Dio dio = Dio(baseOptions);
    dio.interceptors.addAll(
      [
        const Interceptor(),
      ]
    );

    AuthRepository repo = AuthRepository(dio);
    final response = await repo.getEmailDuplicate(email);

    if(response.code == 'SUCCESS') {
      return response.data;
    }

    return true;
  }

  Future<int?> editProfile(BuildContext context, String name, String password, String repassword) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return null;
    }

    if(password == repassword && name != '') {
      final baseOptions = BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        contentType: Headers.jsonContentType,
        validateStatus: (int? status) {
          return status != null;
        },
      );

      Dio dio = Dio(baseOptions);

      dio.interceptors.addAll(
        [
          const Interceptor(),
          CookieManager(state.cookJar),
        ]
      );

      AuthRepository repo = AuthRepository(dio);
      ProfileEditModel editModel = ProfileEditModel(password: password, name: name);


      UserEditResponseModel response;
      
      while(true){
        response = await repo.profileEdit(state.accessToken, editModel);

        if(response.code == "FAIL" && response.message == "토큰이 유효하지 않습니다.") {
          logger.d('엑세스 토큰 재발급');
          ReIssueModel reissue = await repo.getReIssue(state.accessToken);
          emit(state.copyWith(accessToken: reissue.data.accessToken));
        }
        else {
          break;
        }
      }

      logger.d('엑세스 토큰 재발급 성공');

      if(response.code == 'SUCCESS') {
        final data = response.data;

        if(data != null){
          LoginStatus.name.value = data.name;
          emit(state.copyWith(accessToken: data.accessToken, password: password, name: LoginStatus.name.value));
          context.pop();
        return 0;
        }
      }

      return -1;
    }
    else if(password == repassword){
      return 1;
    }
    else {
      return 2;
    }
  }

  Future<int?> signUp(BuildContext context, String name, String email, String password, String repassword) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return null;
    }

    if(password == repassword && name != '') {
      final baseOptions = BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        contentType: Headers.jsonContentType,
        validateStatus: (int? status) {
          return status != null;
        },
      );

      Dio dio = Dio(baseOptions);
      dio.interceptors.addAll(
        [
          const Interceptor(),
        ]
      );

      AuthRepository repo = AuthRepository(dio);
      SignUpModel signup = SignUpModel(email: email, password: password, name: name);
      final response = await repo.postSignUp(signup);

      if(response.code == 'SUCCESS') {
        context.pop();
        return 0;
      }

      return -1;
    }
    else if(password == repassword){
      return 1;
    }
    else {
      return 2;
    }
  }

  Future<bool?> login(BuildContext context, String email, String password) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return null;
    }

    final baseOptions = BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        contentType: Headers.jsonContentType,
        validateStatus: (int? status) {
          return status != null;
        },
      );

      Dio dio = Dio(baseOptions);

      dio.interceptors.addAll(
        [
          const Interceptor(),
          CookieManager(state.cookJar),
        ]
      );

    late SignInResponseModel response;

    try{
      AuthRepository repo = AuthRepository(dio);
      SignInModel signin = SignInModel(email: email, password: password);
      response = await repo.getLogin(signin);
    }
    on Exception catch (_, ex) {
      logger.d(ex);
      return false;
    }

    if(response.code == 'SUCCESS') {
      LoginStatus.signining = false;
      LoginStatus.isLogin = true;
      emit(state.copyWith(email: email, password: password, accessToken: response.data?.accessToken, isLogin: LoginStatus.isLogin));
      context.go('/');
      return true;
    }

    return false;
  }

  void logoutMethod(BuildContext context) {
    if(LoginStatus.isGeust){
      LoginStatus.isGeust = false;
      context.go('/auth');
    }
    else {
      showDialog(context: context, builder: (context) => logoutAskDialog(context));
    }
  }

  void deleteUserMethod(BuildContext context) {
    if(LoginStatus.isGeust){
      LoginStatus.isGeust = false;
      context.go('/auth');
    }
    else {
      showDialog(context: context, builder: (context) => deleteUserAskDialog(context));
    }
  }

  Future<void> logout(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return;
    }

    if(!LoginStatus.isGeust){
      final baseOptions = BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        contentType: Headers.jsonContentType,
        validateStatus: (int? status) {
          return status != null;
        },
      );

      Dio dio = Dio(baseOptions);
      dio.interceptors.addAll(
        [
          const Interceptor(),
          CookieManager(state.cookJar),
        ]
      );

      AuthRepository repo = AuthRepository(dio);
      LogoutModel response;

      response = await repo.logout(state.accessToken);

      if(response.code == 'SUCCESS') {
        LoginStatus.isLogin = false;
        emit(state.copyWith(name: "", email: "", password: "", accessToken: "", isLogin: LoginStatus.isLogin));
        LoginStatus.isGeust = false;
        context.go('/auth');
      }
      else if(response.code == 'FAIL' && response.message == '토큰이 유효하지 않습니다.') {
        LoginStatus.isLogin = false;
        emit(state.copyWith(name: "", email: "", password: "", accessToken: "", isLogin: LoginStatus.isLogin));
        LoginStatus.isGeust = false;
        context.go('/auth');
      }
    }
    else {
      LoginStatus.isGeust = false;
      context.go('/auth');
    }
  }

  Future<void> deleteUser(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showDialog(context: context, builder: (context) => notNetworkDialog(context));
      return;
    }

    if(!LoginStatus.isGeust){
      final baseOptions = BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        contentType: Headers.jsonContentType,
        validateStatus: (int? status) {
          return status != null;
        },
      );

      Dio dio = Dio(baseOptions);
      dio.interceptors.addAll(
        [
          const Interceptor(),
          CookieManager(state.cookJar),
        ]
      );

      AuthRepository repo = AuthRepository(dio);
      UserDeleteModel response = await repo.deleteUser(state.accessToken);

      if(response.code == 'SUCCESS') {
        LoginStatus.isLogin = false;
        emit(state.copyWith(name: "", email: "", password: "", accessToken: "", isLogin: LoginStatus.isLogin));
        LoginStatus.isGeust = false;
        context.go('/auth');
      }
      else if(response.code == 'FAIL' && response.message == '토큰이 유효하지 않습니다.') {
        LoginStatus.isLogin = false;
        emit(state.copyWith(name: "", email: "", password: "", accessToken: "", isLogin: LoginStatus.isLogin));
        LoginStatus.isGeust = false;
        context.go('/auth');
      }
    }
    else {
      LoginStatus.isGeust = false;
      context.go('/auth');
    }
  }

  void guestLogin() {
    LoginStatus.isGeust = true;
  }

  void askToLogin(BuildContext context) {
    //show dialog if you want to login
    showDialog(context: context, builder: (context) => loginAskDialog(context));
  }

  void goToHome(BuildContext context) {
    context.go('/');
  }

  void goTologin(BuildContext context) {
    context.pop();
    context.push('/auth');
  }

  void goToJoin(BuildContext context) {
    LoginStatus.joining = true;
    context.push('/auth/signUp');
  }

  void goToSignIn(BuildContext context) {
    LoginStatus.signining = true;
    context.push('/auth/signIn');
  }

  void disposeJoin() {
    LoginStatus.joining = false;
  }

  void disposeSignIn() {
    LoginStatus.signining = false;
  }
  
  // void loginWithCredentials() async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //   try {
  //     await _authRepository.loginWithEmailAndPassword(
  //       email: state.email,
  //       password: state.password,
  //     );
  //     emit(state.copyWith(status: FormStatus.success));
  //   } on Exception catch (e) {
  //     emit(state.copyWith(status: FormStatus.error, error: e.toString()));
  //   }
  // }
}
