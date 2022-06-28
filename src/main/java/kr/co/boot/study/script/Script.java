package kr.co.boot.study.script;

import java.io.Serializable;

public class Script implements Serializable {
    private int no;
    private String name;
    private String uploadPoint;

    public Script() {
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

    public String getUploadPoint() {
        return uploadPoint;
    }

    public void setUploadPoint(String uploadPoint) {
        this.uploadPoint = uploadPoint;
    }

    @Override
    public String toString() {
        return "Script{" +
                "no=" + no +
                ", name='" + name + '\'' +
                ", uploadPoint='" + uploadPoint + '\'' +
                '}';
    }
}
