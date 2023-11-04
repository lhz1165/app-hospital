package cn.yujian95.hospital.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * Mybatis 配置类
 *
 * @author docker-compose
 * @date 2023/11/1
 */

@MapperScan("cn.yujian95.hospital.mapper")
@Configuration
public class MybatisConfig {
}
