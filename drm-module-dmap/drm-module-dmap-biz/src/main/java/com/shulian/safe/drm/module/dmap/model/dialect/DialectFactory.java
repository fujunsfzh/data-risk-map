package com.shulian.safe.drm.module.dmap.model.dialect;


import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.toolkit.ExceptionUtils;

import java.util.EnumMap;
import java.util.Map;

/**
 * 分页方言工厂类
 */
public class DialectFactory {

    private static final Map<DbType, IDialect> DIALECT_ENUM_MAP = new EnumMap<>(DbType.class);

    public static IDialect getDialect(DbType dbType) {
        IDialect dialect = DIALECT_ENUM_MAP.get(dbType);
        if (null == dialect) {
            if (dbType == DbType.OTHER) {
                throw ExceptionUtils.mpe("%s database not supported.", dbType.getDb());
            }
            // mysql same type
            else if (dbType.mysqlSameType()) {
                dialect = new MySqlDialect();
            }
            // oracle same type
            else if (dbType.oracleSameType()) {
                dialect = new OracleDialect();
            }
            // postgresql same type
            else if (dbType.postgresqlSameType()) {
                dialect = new PostgreDialect();
            } else if (dbType == DbType.DM) {
                dialect = new DMDialect();
            } else if (dbType == DbType.DB2) {
                dialect = new DB2Dialect();
            } else if (dbType == DbType.SQL_SERVER2005) {
                dialect = new SQLServer2005Dialect();
            } else if (dbType == DbType.SYBASE) {
                dialect = new SybaseDialect();
            } else if (dbType == DbType.XCloud) {
                dialect = new XCloudDialect();
            } else if (dbType == DbType.GBASE_8S
                    || dbType == DbType.GBASEDBT
                    || dbType == DbType.GBASE_INFORMIX
                    || dbType == DbType.SINODB
            ) {
                dialect = new GBase8sDialect();
            } else if (dbType == DbType.INFORMIX) {
                dialect = new InformixDialect();
            } else if (dbType == DbType.TRINO
                    || dbType == DbType.PRESTO
            ) {
                dialect = new TrinoDialect();
            } // other types
            else if (dbType == DbType.ORACLE_12C
                    || dbType == DbType.FIREBIRD
                    || dbType == DbType.SQL_SERVER
                // || dbType == DbType.DERBY
            ) {
                dialect = new Oracle12cDialect();
            }
            DIALECT_ENUM_MAP.put(dbType, dialect);
        }
        return dialect;
    }
}
