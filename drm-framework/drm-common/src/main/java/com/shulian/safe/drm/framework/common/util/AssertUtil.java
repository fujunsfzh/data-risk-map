package com.shulian.safe.drm.framework.common.util;

import com.shulian.safe.drm.framework.common.exception.ErrorCode;
import com.shulian.safe.drm.framework.common.exception.ServiceException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.lang.Nullable;
import org.springframework.util.Assert;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/13 12:29
 * @version: V1.0
 */
public class AssertUtil extends Assert {

    public static void isTrue(boolean expression, ErrorCode errorCode) {
        if (!expression) {
            throw new ServiceException(errorCode);
        }
    }

    public static void isFalse(boolean expression, String message) {
        if (expression) {
            throw new IllegalArgumentException(message);
        }
    }

    public static void notBlank(@Nullable String str, String message) {
        if (StringUtils.isBlank(str)) {
            throw new IllegalArgumentException(message);
        }
    }

    public static void notNull(@Nullable Object object, ErrorCode errorCode) {
        if (object == null) {
            throw new ServiceException(errorCode);
        }
    }

}
