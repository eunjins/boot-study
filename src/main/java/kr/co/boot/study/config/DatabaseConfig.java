package kr.co.boot.study.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
public abstract class DatabaseConfig {

    @Configuration
    public class DataSourceConfig {
        @ConfigurationProperties(prefix = "spring.datasource")
        @Bean
        public DataSource dataSource() {
            return DataSourceBuilder.create().build();
        }
    }

    @Configuration
    @MapperScan("kr.co.boot.study")
    public class MySQLConfig {
        @Bean
        public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
            final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
            sessionFactory.setDataSource(dataSource);

            PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
            sessionFactory.setMapperLocations(resolver.getResources("classpath:mappers/*.xml"));

            Resource myBatisConfig = new PathMatchingResourcePatternResolver().getResource("classpath:mybatis-config.xml");
            sessionFactory.setConfigLocation(myBatisConfig);

            return sessionFactory.getObject();
        }
    }

}
