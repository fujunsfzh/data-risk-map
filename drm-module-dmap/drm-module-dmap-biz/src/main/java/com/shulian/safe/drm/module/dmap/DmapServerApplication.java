package com.shulian.safe.drm.module.dmap;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.shulian.safe.drm.module.dmap.mapper")
@SpringBootApplication(scanBasePackages = {"com.shulian.safe.drm"})
public class DmapServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(DmapServerApplication.class, args);
    }

}
