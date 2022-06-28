package kr.co.boot.study.script;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AttachRepository {
    public List<Attach> selectAll(Attach attach);

    public Attach select(Attach attach);

    public void insert(Attach attach);
}
