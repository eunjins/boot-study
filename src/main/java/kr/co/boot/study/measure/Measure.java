package kr.co.boot.study.measure;

import java.io.Serializable;

public class Measure implements Serializable {
    private int no;
    private String name;
    private String deviceId;
    private String deviceName;
    private int scriptNo;
    private int execTime;
    private String status;
    private String distributeStatus;

    public Measure() {
    }

    public Measure(int scriptNo) {
        this.scriptNo = scriptNo;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public int getScriptNo() {
        return scriptNo;
    }

    public void setScriptNo(int scriptNo) {
        this.scriptNo = scriptNo;
    }

    public int getExecTime() {
        return execTime;
    }

    public void setExecTime(int execTime) {
        this.execTime = execTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDistributeStatus() {
        return distributeStatus;
    }

    public void setDistributeStatus(String distributeStatus) {
        this.distributeStatus = distributeStatus;
    }

    @Override
    public String toString() {
        return "Measure{" +
                "no=" + no +
                ", name='" + name + '\'' +
                ", deviceId='" + deviceId + '\'' +
                ", deviceName='" + deviceName + '\'' +
                ", scriptNo=" + scriptNo +
                ", execTime=" + execTime +
                ", status='" + status + '\'' +
                ", distributeStatus='" + distributeStatus + '\'' +
                '}';
    }
}
