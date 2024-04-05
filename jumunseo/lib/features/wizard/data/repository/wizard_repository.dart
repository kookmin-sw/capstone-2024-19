import 'package:dio/dio.dart';
import 'package:jumunseo/features/wizard/model/chat_model.dart';
import 'package:retrofit/retrofit.dart';

part 'wizard_repository.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:8000')
abstract class WizardRepository {
  factory WizardRepository(Dio dio, {String baseUrl}) = _WizardRepository;

  @GET('/chat/list/{userId}')
  Future<ChatModel> getRooms(@Path() String userId);
}