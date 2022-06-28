package kr.co.boot.study.measure;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MeasureServiceImpl implements MeasureService {
    @Autowired
    private MeasureRepository measureRepository;

    @Override
    public List<Measure> getMeasures(Measure measure) {
        return measureRepository.selectAll(measure);
    }

    @Override
    public Measure getMeasure(Measure measure) {
        return measureRepository.select(measure);
    }

    @Override
    public void registerMeasure(Measure measure) {
        measureRepository.insert(measure);
    }
}
