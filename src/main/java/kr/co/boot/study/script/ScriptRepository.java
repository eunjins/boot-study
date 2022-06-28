package kr.co.boot.study.script;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ScriptRepository {
    public List<Script> selectAll(Map<String, String> condition);

    public Script select(Script script);

    public void insert(Script script);
}
