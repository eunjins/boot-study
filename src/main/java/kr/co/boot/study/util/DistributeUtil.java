package kr.co.boot.study.util;

import kr.co.boot.study.device.Device;
import kr.co.boot.study.measure.Measure;
import kr.co.boot.study.measure.MeasureRepository;
import kr.co.boot.study.script.ScriptController;
import kr.co.boot.study.script.ScriptFileRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;

public class DistributeUtil implements Runnable {
    private static final Logger logger = LogManager.getLogger(DistributeUtil.class);

    private Device device;
    private File classFile;
    private ScriptFileRepository scriptFileRepository;
    private MeasureRepository measureRepository;
    private Measure measure;

    public Device getDevice() {
        return device;
    }

    public void setDevice(Device device) {
        this.device = device;
    }

    public File getClassFile() {
        return classFile;
    }

    public void setClassFile(File classFile) {
        this.classFile = classFile;
    }

    public void setScriptFileRepository(ScriptFileRepository scriptFileRepository) {
        this.scriptFileRepository = scriptFileRepository;
    }

    public void setMeasureRepository(MeasureRepository measureRepository) {
        this.measureRepository = measureRepository;
    }

    public void setMeasure(Measure measure) {
        this.measure = measure;
    }

    @Override
    public void run() {
        try {
            Cryptogram cryptogram = new Cryptogram(device.getId());
            String encryptResult = cryptogram.encryption(device.getId());

            if (scriptFileRepository.distribute(classFile, encryptResult, device.getIpAddress())) {
                synchronized (this) {
                    ScriptController.distributeCount ++;
                }
            }
        } catch (Exception e) {
            logger.error("                        DISTRIBUTE FAIL : " + e.getMessage());

            Measure measure = new Measure();
            if (this.measure.getScriptNo() == -1) {
                try {
                    Thread.sleep(4000);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }
            }

            measure.setScriptNo(this.measure.getScriptNo());
            measure.setName(this.measure.getName());
            measure.setDistributeStatus("N");
            measure.setStatus("N");
            measure.setExecTime(0);
            measure.setDeviceId(device.getId());
            measure.setDeviceName(device.getName());

            measureRepository.insert(measure);
        }
    }

}
