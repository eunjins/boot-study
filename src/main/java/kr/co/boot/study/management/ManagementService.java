package kr.co.boot.study.management;

import kr.co.boot.study.device.Device;
import kr.co.boot.study.measure.Measure;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public interface ManagementService {
    public boolean distributeScript(List<Device> devices, MultipartFile classFile, Measure measure) throws Exception;
}
