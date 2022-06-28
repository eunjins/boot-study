package kr.co.boot.study.measure;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MeasureRepository {
    public List<Measure> selectAll(Measure measure);

    public Measure select(Measure measure);

    public void insert(Measure measure);
}
