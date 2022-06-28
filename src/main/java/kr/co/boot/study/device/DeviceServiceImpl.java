package kr.co.boot.study.device;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class DeviceServiceImpl implements DeviceService {
    @Autowired
    private DeviceRepository deviceRepository;

    @Override
    public List<Device> getDevices(Map<String, String> condition) {
        return deviceRepository.selectAll(condition);
    }

    @Override
    public Device getDevice(Device device) {
        return deviceRepository.select(device);
    }

    @Override
    public void registerDevice(Device device) {
        String nowDate = String.valueOf(LocalDate.now());
        device.setName(device.getId());
        device.setInsertDate(nowDate);

        deviceRepository.insert(device);
    }

    @Override
    public void editDevice(Device device) {
        deviceRepository.update(device);
    }
}
