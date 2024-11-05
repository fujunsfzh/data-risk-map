package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * IBM Informix
 */
public class InformixDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        StringBuilder ret = new StringBuilder();
        ret.append(String.format("select skip %s first %s ", offset + "", limit + ""));
        ret.append(originalSql.replaceFirst("(?i)select", ""));
        return ret.toString();
    }
}
