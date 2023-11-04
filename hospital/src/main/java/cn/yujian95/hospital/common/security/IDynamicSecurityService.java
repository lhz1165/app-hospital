package cn.yujian95.hospital.common.security;

import org.springframework.security.access.ConfigAttribute;

import java.util.Map;

/**
 * @author docker-compose
 * @date 2023/11/1
 */

public interface IDynamicSecurityService {
    /**
     * 加载 资源 ANT 通配符和 资源对应MAP
     *
     * @return 资源 ANT 通配符和 资源
     */
    Map<String, ConfigAttribute> loadDataSource();
}
