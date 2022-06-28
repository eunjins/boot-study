package kr.co.boot.study.script;

import org.springframework.stereotype.Repository;

import java.io.File;

@Repository
public interface ScriptFileRepository {
    public boolean distribute(File classFile, String encryptResult, String url) throws Exception;
}
