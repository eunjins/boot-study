package kr.co.boot.study.measure;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MeasureService {
    public List<Measure> getMeasures(Measure measure);

    public Measure getMeasure(Measure measure);

    public void registerMeasure(Measure measure);
}
