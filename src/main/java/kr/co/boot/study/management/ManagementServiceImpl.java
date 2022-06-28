package kr.co.boot.study.management;

import kr.co.boot.study.device.Device;
import kr.co.boot.study.measure.Measure;
import kr.co.boot.study.measure.MeasureRepository;
import kr.co.boot.study.script.ScriptController;
import kr.co.boot.study.script.ScriptFileRepository;
import kr.co.boot.study.util.DistributeUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Service
public class  ManagementServiceImpl implements ManagementService {
    private static final Logger logger = LogManager.getLogger(ManagementServiceImpl.class);

    @Value("${scriptPath}")
    private String path;

    @Autowired
    private MeasureRepository measureRepository;

    @Autowired
    private ScriptFileRepository scriptFileRepository;

    @Override
    public boolean distributeScript(List<Device> devices, MultipartFile classFile, Measure measure) throws Exception {
        File directory = new File(path);
        if (!directory.isDirectory()) {
            directory.mkdir();
        }

        File convertFile = new File(path + File.separator + classFile.getOriginalFilename());

        FileOutputStream fileOutputStream = new FileOutputStream(convertFile);
        fileOutputStream.write(classFile.getBytes());
        fileOutputStream.close();

        ExecutorService executorService = Executors.newCachedThreadPool();
        for (Device device : devices) {
            if (device.getStatus().equals("Y")) {
                DistributeUtil distributeUtil = new DistributeUtil();
                distributeUtil.setDevice(device);
                distributeUtil.setClassFile(convertFile);
                distributeUtil.setScriptFileRepository(scriptFileRepository);
                distributeUtil.setMeasureRepository(measureRepository);
                distributeUtil.setMeasure(measure);

                executorService.submit(distributeUtil);
            }
        }

        Thread.sleep(4000);
        convertFile.delete();

        if (ScriptController.distributeCount == 0) {
            logger.info("                      CONNECTED DEVICE IS NULL                         ");
            return false;
        } else {
            return true;
        }
    }
}
