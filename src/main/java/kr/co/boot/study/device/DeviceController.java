package kr.co.boot.study.device;

import kr.co.boot.study.util.Navigator;
import kr.co.boot.study.util.StatusCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/devices")
public class DeviceController {
    @Autowired
    private StatusCode statusCode;

    @Autowired
    private DeviceService deviceService;

    @Autowired
    private Navigator navigator;

    @GetMapping
    public ModelAndView getDevices() {
        ModelAndView mav = new ModelAndView("device/list");

        return mav;
    }

    @PostMapping
    public Map<String, Object> getDevices(@RequestBody Map<String, String> inputCondition) {
        Map<String, String> condition = new HashMap<>();
        Map<String, Object> result = new HashMap<>();

        condition.put("name", inputCondition.get("name"));
        condition.put("insertDate", inputCondition.get("insertDate"));
        condition.put("status", inputCondition.get("status"));

        int deviceCount = deviceService.getDevices(condition).size();

        Integer pageNo = Integer.valueOf(inputCondition.get("pageNo"));
        condition.put("pageNo", String.valueOf(pageNo * 10));

        List<Device> devices = deviceService.getDevices(condition);
        result.put("devices", devices);

        String navigatorHtml = navigator.getNavigator(deviceCount, pageNo);
        result.put("navigator", navigatorHtml);

        return result;
    }

    @GetMapping("/{id}")
    public ModelAndView getDevice(Device device) {
        ModelAndView mav = new ModelAndView("device/view");
        mav.addObject("device", deviceService.getDevice(device));

        return mav;
    }

    @GetMapping("/{id}/form")
    public ModelAndView editDeviceForm(Device device) {
        ModelAndView mav = new ModelAndView("device/edit");
        mav.addObject("device", deviceService.getDevice(device));

        return mav;
    }

    @PutMapping("/{id}")
    public ModelAndView editDevice(Device device) {
        ModelAndView mav = null;

        if (deviceService.getDevice(device) == null) {
            mav = new ModelAndView(new RedirectView("/devices"));

            return mav;
        }

        device.setName((device.getName()).trim());
        try {
            deviceService.editDevice(device);
        } catch (Exception e) {
            log.error("                   OVERLAP NAME ERROR : " + e.getMessage());
        }

        mav = new ModelAndView(new RedirectView("/devices/" + device.getId()));

        return mav;
    }

    @PostMapping("/data")
    public Map<String, String> receiveDevice(
            @RequestBody Device device, HttpServletResponse httpServletResponse) {
        log.info("                   SUCCESSFUL RECEIVE DEVICE INFORMATION");
        log.info("      Device ID   :   " + device.getId());
        log.info("      Host Name   :   " + device.getHostName());
        log.info("      IP Address  :   " + device.getIpAddress());
        log.info("      JDK Version :   " + device.getJdkVersion());

        int code = httpServletResponse.getStatus();
        String message = statusCode.getStatusRepository().get(code);

        Map<String, String> responseData = new HashMap<>();
        responseData.put("code", String.valueOf(code));
        if (message != null) {
            responseData.put("message", message);
        } else {
            responseData.put("message", null);
        }

        if (device.getId() != null
                && device.getHostName() != null
                && device.getIpAddress() != null
                && device.getJdkVersion() != null) {
            if (deviceService.getDevice(device) != null) {
                deviceService.editDevice(device);
            } else {
                deviceService.registerDevice(device);
            }
        } else {
            responseData.put("message", "수신 데이터가 존재하지 않습니다.");
        }

        return responseData;
    }
}