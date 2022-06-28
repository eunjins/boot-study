package kr.co.boot.study.access;

import org.springframework.stereotype.Service;

@Service
public interface AccessService {
    public User getManager() throws Exception ;
}
