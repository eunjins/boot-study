package kr.co.boot.study.script;

import java.io.Serializable;

public class Attach implements Serializable {
    private int no;
    private String division;
    private String name;
    private String physicName;
    private int scriptNo;

    public Attach() {
    }

    public Attach(int scriptNo) {
        this.scriptNo = scriptNo;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhysicName() {
        return physicName;
    }

    public void setPhysicName(String physicName) {
        this.physicName = physicName;
    }

    public int getScriptNo() {
        return scriptNo;
    }

    public void setScriptNo(int scriptNo) {
        this.scriptNo = scriptNo;
    }
}
