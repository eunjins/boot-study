package kr.co.boot.study.script;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface ScriptService {
    public List<Script> getScripts(Map<String, String> condition);

    public Script getScript(Script script);

    public void registerScript(Script script);
}
