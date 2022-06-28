package kr.co.boot.study.script;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Service
public class ScriptServiceImpl implements ScriptService {
    @Autowired
    private ScriptRepository scriptRepository;

    @Override
    public List<Script> getScripts(Map<String, String> condition) {
        return scriptRepository.selectAll(condition);
    }

    @Override
    public Script getScript(Script script) {
        return scriptRepository.select(script);
    }

    @Override
    public void registerScript(Script script) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTime = format.format(System.currentTimeMillis());

        script.setUploadPoint(dateTime);

        scriptRepository.insert(script);
    }
}
