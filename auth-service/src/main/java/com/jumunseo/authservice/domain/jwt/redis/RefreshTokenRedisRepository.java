package com.jumunseo.authservice.domain.jwt.redis;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

// 리프래시 토큰을 레디스에서 관리하게 해주는 레포지토리
@Repository
public interface RefreshTokenRedisRepository extends CrudRepository<RefreshToken,String>{
}
