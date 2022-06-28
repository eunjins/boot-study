package kr.co.boot.study.access;

import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository {
    public User select() throws Exception;
}
