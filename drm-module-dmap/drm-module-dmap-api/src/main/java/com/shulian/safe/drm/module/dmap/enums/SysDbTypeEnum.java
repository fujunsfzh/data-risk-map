/*
 * Copyright (c) 2011-2024, baomidou (jobob@qq.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.shulian.safe.drm.module.dmap.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * MybatisPlus 支持的数据库类型,主要用于分页方言
 *
 * DbType
 */
@Getter
@AllArgsConstructor
public enum SysDbTypeEnum {

    /**
     * MYSQL
     */
    MYSQL("mysql", "MySql数据库"),
    /**
     * MARIADB
     */
    MARIADB("mariadb", "MariaDB数据库"),
    /**
     * ORACLE
     */
    ORACLE("oracle", "Oracle11g及以下数据库(高版本推荐使用ORACLE_NEW)"),
    /**
     * oracle12c new pagination
     */
    // ORACLE_12C("oracle12c", "Oracle12c+数据库"),
    /**
     * DB2
     */
    DB2("db2", "DB2数据库"),
    // /**
    //  * H2
    //  */
    // H2("h2", "H2数据库"),
    // /**
    //  * HSQL
    //  */
    // HSQL("hsql", "HSQL数据库"),
    // /**
    //  * SQLITE
    //  */
    // SQLITE("sqlite", "SQLite数据库"),
    /**
     * POSTGRE
     */
    POSTGRE_SQL("postgresql", "Postgre数据库"),
    /**
    //  * SQLSERVER2005
    //  */
    // SQL_SERVER2005("sqlserver2005", "SQLServer2005数据库"),
    /**
     * SQLSERVER
     */
    SQL_SERVER("sqlserver", "SQLServer数据库"),
    /**
     * DM
     */
    DM("dm", "达梦数据库"),
    // /**
    //  * xugu
    //  */
    // XU_GU("xugu", "虚谷数据库"),
    // /**
    //  * Kingbase
    //  */
    // KINGBASE_ES("kingbasees", "人大金仓数据库"),
    // /**
    //  * Phoenix
    //  */
    // PHOENIX("phoenix", "Phoenix HBase数据库"),
    // /**
    //  * Gauss
    //  */
    // GAUSS("zenith", "Gauss 数据库"),
    // /**
    //  * ClickHouse
    //  */
    // CLICK_HOUSE("clickhouse", "clickhouse 数据库"),
    // /**
    //  * GBase
    //  */
    // GBASE("gbase", "南大通用(华库)数据库"),
    // /**
    //  * GBase-8s
    //  */
    // GBASE_8S("gbase-8s", "南大通用数据库 GBase 8s"),
    // /**
    //  * use {@link  #GBASE_8S}
    //  *
    //  * @deprecated 2022-05-30
    //  */
    // @Deprecated
    // GBASEDBT("gbasedbt", "南大通用数据库"),
    // /**
    //  * use {@link  #GBASE_8S}
    //  *
    //  * @deprecated 2022-05-30
    //  */
    // @Deprecated
    // GBASE_INFORMIX("gbase 8s", "南大通用数据库 GBase 8s"),
    // /**
    //  * GBase8sPG
    //  */
    // GBASE8S_PG("gbase8s-pg", "南大通用数据库 GBase 8s兼容pg"),
    // /**
    //  * GBase8c
    //  */
    // GBASE_8C("gbase8c", "南大通用数据库 GBase 8c"),
    // /**
    //  * Sinodb
    //  */
    // SINODB("sinodb", "星瑞格数据库"),
    // /**
    //  * Oscar
    //  */
    // OSCAR("oscar", "神通数据库"),
    // /**
    //  * Sybase
    //  */
    // SYBASE("sybase", "Sybase ASE 数据库"),
    // /**
    //  * OceanBase
    //  */
    // OCEAN_BASE("oceanbase", "OceanBase 数据库"),
    // /**
    //  * Firebird
    //  */
    // FIREBIRD("Firebird", "Firebird 数据库"),
    // /**
    //  * HighGo
    //  */
    // HIGH_GO("highgo", "瀚高数据库"),
    // /**
    //  * CUBRID
    //  */
    // CUBRID("cubrid", "CUBRID数据库"),
    // /**
    //  * SUNDB
    //  */
    // SUNDB("sundb", "SUNDB数据库"),
    // /**
    //  * Hana
    //  */
    // SAP_HANA("hana", "SAP_HANA数据库"),
    // /**
    //  * Impala
    //  */
    // IMPALA("impala", "impala数据库"),
    // /**
    //  * Vertica
    //  */
    // VERTICA("vertica", "vertica数据库"),
    // /**
    //  * xcloud
    //  */
    // XCloud("xcloud", "行云数据库"),
    // /**
    //  * redshift
    //  */
    // REDSHIFT("redshift", "亚马逊redshift数据库"),
    // /**
    //  * openGauss
    //  */
    // OPENGAUSS("openGauss", "华为 opengauss 数据库"),
    // /**
    //  * TDengine
    //  */
    // TDENGINE("TDengine", "TDengine数据库"),
    // /**
    //  * Informix
    //  */
    // INFORMIX("informix", "Informix数据库"),
    // /**
    //  * uxdb
    //  */
    // UXDB("uxdb", "优炫数据库"),
    // /**
    //  * lealone
    //  */
    // LEALONE("lealone", "Lealone数据库"),
    // /**
    //  * trino
    //  */
    // TRINO("trino", "Trino数据库"),
    // /**
    //  * presto
    //  */
    // PRESTO("presto", "Presto数据库"),
    /**
     * UNKNOWN DB
     */
    OTHER("other", "其他数据库");

    /**
     * 数据库名称
     */
    private final String db;
    /**
     * 描述
     */
    private final String desc;

    /**
     * 获取数据库类型
     *
     * @param db 数据库类型字符串
     */
    public static SysDbTypeEnum getSysDbTypeEnum(String db) {
        for (SysDbTypeEnum type : SysDbTypeEnum.values()) {
            if (type.db.equalsIgnoreCase(db)) {
                return type;
            }
        }
        // return OTHER;
        return null;
    }

    public boolean mysqlSameType() {
        return this == SysDbTypeEnum.MYSQL
                || this == SysDbTypeEnum.MARIADB
                // || this == SysDbTypeEnum.GBASE
                // || this == SysDbTypeEnum.OSCAR
                // || this == SysDbTypeEnum.XU_GU
                // || this == SysDbTypeEnum.CLICK_HOUSE
                // || this == SysDbTypeEnum.OCEAN_BASE
                // || this == SysDbTypeEnum.CUBRID
                // || this == SysDbTypeEnum.SUNDB
                ;
    }

    public boolean oracleSameType() {
        return this == SysDbTypeEnum.ORACLE
                || this == SysDbTypeEnum.DM
                // || this == SysDbTypeEnum.GAUSS
                ;
    }

    public boolean postgresqlSameType() {
        return this == SysDbTypeEnum.POSTGRE_SQL
                // || this == SysDbTypeEnum.H2
                // || this == SysDbTypeEnum.LEALONE
                // || this == SysDbTypeEnum.SQLITE
                // || this == SysDbTypeEnum.HSQL
                // || this == SysDbTypeEnum.KINGBASE_ES
                // || this == SysDbTypeEnum.PHOENIX
                // || this == SysDbTypeEnum.SAP_HANA
                // || this == SysDbTypeEnum.IMPALA
                // || this == SysDbTypeEnum.HIGH_GO
                // || this == SysDbTypeEnum.VERTICA
                // || this == SysDbTypeEnum.REDSHIFT
                // || this == SysDbTypeEnum.OPENGAUSS
                // || this == SysDbTypeEnum.TDENGINE
                // || this == SysDbTypeEnum.UXDB
                // || this == SysDbTypeEnum.GBASE8S_PG
                // || this == SysDbTypeEnum.GBASE_8C
                ;
    }



    // public List<String> mysqlIgnoreSys() {
    //     return Lists.newArrayList("information_schema"
    //             ,"performance_schema"
    //             ,"mysql"
    //             ,"sys"
    //             ,"test"
    //     );
    // }
    // public List<String> postgresqlIgnoreSys() {
    //     return Lists.newArrayList("mysql"
    //             ,"template0"
    //             ,"template1"
    //     );
    // }
    // public List<String> oracleIgnoreSys() {
    //     return Lists.newArrayList("information_schema"
    //             ,"performance_schema"
    //             ,"mysql"
    //             ,"sys"
    //             ,"test"
    //     );
    // }
    // public List<String> dmIgnoreSys() {
    //     return Lists.newArrayList("CTISYS"
    //             ,"DATA_STATIC_MASK"
    //             ,"SYSAUDITOR"
    //             ,"SYS"
    //             ,"SYSDBA"
    //             ,"SYSSSO"
    //     );
    // }
    // public List<String> sqlserverIgnoreSys() {
    //     return Lists.newArrayList("master"
    //             ,"model"
    //             ,"tempdb"
    //             ,"msdb"
    //     );
    // }
}
