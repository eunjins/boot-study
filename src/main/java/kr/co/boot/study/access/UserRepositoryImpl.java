package kr.co.boot.study.access;

import org.apache.ibatis.io.Resources;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@Repository
public class UserRepositoryImpl implements UserRepository {
    @Value("${accessPath}")
    private String filePath;

    @Override
    public User select() throws IOException {
        Properties properties = new Properties();
        InputStream inputStream = Resources.getResourceAsStream(filePath);
        properties.load(inputStream);

        User user = new User();
        user.setId(properties.getProperty("id"));
        user.setPassword(properties.getProperty("password"));

        return user;
    }
}
