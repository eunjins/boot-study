package kr.co.boot.study.device;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface DeviceService {
    public List<Device> getDevices(Map<String, String> condition);

    public Device getDevice(Device device);

    public void registerDevice(Device device);

    public void editDevice(Device device);
}
