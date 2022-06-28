package kr.co.boot.study.config;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConfigTest {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://us-cdbr-east-05.cleardb.net:3306/heroku_a46b6c2ff7d6166?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&reconnect=true";
    private static final String USER = "b3a2e5f13ce42e";
    private static final String PASSWORD = "8a0aeec6";
    
    @DisplayName(value = "DB Connection 테스트")
    @Test
    public void connection() throws Exception {
        Class.forName(DRIVER);
        try {
            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println(connection);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
