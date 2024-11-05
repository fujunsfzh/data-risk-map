package com.shulian.safe.drm.framework.redis.core;

import com.shulian.safe.drm.framework.common.util.json.JsonUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.redisson.client.RedisException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.data.redis.core.script.RedisScript;

import java.util.*;
import java.util.concurrent.TimeUnit;


public class RedisUtils {
    private static Logger log = LoggerFactory.getLogger(RedisUtils.class);

    private StringRedisTemplate stringRedisTemplate;

    public RedisUtils(StringRedisTemplate stringRedisTemplate) {
        this.stringRedisTemplate = stringRedisTemplate;
    }

    //////////////////////////// Redis string类型元素的操作 ///////////////////////////

    public Integer append(final String key, final String value) {
        return stringRedisTemplate.opsForValue().append(key, value);
    }

    /**
     * 设置key对应的值为string类型的value，并指定此键值对应的有效期。
     *
     * @param key
     * @param expire
     * @param value
     */
    public void setex(String key, int expire, String value) throws RedisException {
        try {
            stringRedisTemplate.opsForValue().set(key, value, expire, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error("execute 'setex " + key + "' fail!", e);
            throw new RedisException("execute 'setex " + key + "' fail!", e);
        }
    }

    public void setex(String key, Object value, int expire) throws RedisException {
        try {
            stringRedisTemplate.opsForValue().set(key, JsonUtils.toJsonString(value), expire, TimeUnit.SECONDS);
        } catch (Exception e) {
            throw new RedisException("execute 'setex " + key + "' fail!", e);
        }
    }

    /**
     * 不设置有效期，长期有效
     *
     * @param key
     * @param value
     * @throws RedisException
     */
    public void set(String key, String value) throws RedisException {
        try {
            stringRedisTemplate.opsForValue().set(key, value);
        } catch (Exception e) {
            log.error("execute 'setex " + key + "' fail!", e);
            throw new RedisException("execute 'setex " + key + "' fail!", e);
        }
    }

    public boolean setnx(String key, String value) throws RedisException {
        try {
            return stringRedisTemplate.opsForValue().setIfAbsent(key, value);
        } catch (Exception e) {
            log.error("execute 'setnx " + key + "' fail!", e);
            throw new RedisException("execute 'setnx " + key + "' fail!", e);
        }
    }

    public String getAndSet(String key, String value) throws RedisException {
        try {
            return stringRedisTemplate.opsForValue().getAndSet(key, value);
        } catch (Exception e) {
            log.error("execute 'getAndSet " + key + "' fail!", e);
            throw new RedisException("execute 'getAndSet " + key + "' fail!", e);
        }
    }

    /**
     * key对应的value值加1并返回加1后的值
     *
     * @param key 为String类型
     * @return Long  返回加1后的值
     */
    public Long incr(String key) throws RedisException {
        try {
            return stringRedisTemplate.opsForValue().increment(key, 1L);
        } catch (Exception e) {
            log.error("execute 'incr " + key + "' fail!", e);
            throw new RedisException("execute 'incr " + key + "' fail!", e);
        }
    }

    /**
     * key对应的value减1并返回减1后的值
     *
     * @param key 为String类型
     * @return Long  返回减1后的值
     */
    public Long decr(String key) throws RedisException {
        try {
            return stringRedisTemplate.opsForValue().increment(key, -1L);
        } catch (Exception e) {
            log.error("execute 'decr " + key + "' fail!", e);
            throw new RedisException("execute 'decr " + key + "' fail!", e);
        }
    }

    /**
     * key对应的value值加指定值
     *
     * @param key 为String类型
     * @return Long  返回加1后的值
     */
    public Long incrBy(String key, long delta) throws RedisException {
        try {
            return stringRedisTemplate.opsForValue().increment(key, delta);
        } catch (Exception e) {
            log.error("execute 'incr " + key + "' fail!", e);
            throw new RedisException("execute 'incr " + key + "' fail!", e);
        }
    }

    /**
     * @param key
     * @return
     */
    public String get(String key) throws RedisException {
        try {
            return stringRedisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            log.error("execute 'get " + key + "' fail!", e);
            throw new RedisException("execute 'get " + key + "' fail!", e);
        }
    }

    //////////////////////////// Redis set类型元素的操作 ///////////////////////////

    /**
     * Redis set类型添加元素，等价于Redis中的'sadd key member'命令
     *
     * @param key    set的key值
     * @param member 待添加的元素
     * @return Long  返回成功标识，1为成功，0为失败
     */
    public Long sadd(String key, String member) throws RedisException {
        try {
            return stringRedisTemplate.opsForSet().add(key, member);
        } catch (Exception e) {
            log.error("execute 'sadd " + key + "' fail!", e);
            throw new RedisException("execute 'sadd " + key + "' fail!", e);
        }
    }

    /**
     * Redis set类型添加元素，等价于Redis中的'sadd key member'命令
     *
     * @param key     set的key值
     * @param members 待添加的元素
     * @return Long  返回成功标识，1为成功，0为失败
     */
    public Long sadd(String key, String[] members) throws RedisException {
        try {
            return stringRedisTemplate.opsForSet().add(key, members);
        } catch (Exception e) {
            log.error("execute 'sadd " + key + "' fail!", e);
            throw new RedisException("execute 'sadd " + key + "' fail!", e);
        }
    }

    /**
     * Redis set类型获取set中的所有元素，等价于Redis中的'smembers key'命令
     *
     * @param key set的key值
     * @return Set<String>
     */
    public Set<String> smembers(String key) throws RedisException {
        try {
            return stringRedisTemplate.opsForSet().members(key);
        } catch (Exception e) {
            log.error("execute 'smembers " + key + "' fail!", e);
            throw new RedisException("execute 'smembers " + key + "'fail!", e);
        }
    }

    /**
     * @param key
     * @param count
     * @return
     * @throws RedisException
     */
    public Set<String> sscan(String key, Integer count) throws RedisException {
        try {
            ScanOptions options = ScanOptions.scanOptions().count(count).build();
            Cursor<String> cursor = stringRedisTemplate.opsForSet().scan(key, options);
            if (cursor == null) {
                return Collections.emptySet();
            }
            Set<String> set = new HashSet<>();
            while (cursor.hasNext()) {
                set.add(cursor.next());
            }
            return set;
        } catch (Exception e) {
            log.error("execute 'smembers " + key + "' fail!", e);
            throw new RedisException("execute 'smembers " + key + "'fail!", e);
        }
    }

    /**
     * Redis set类型判断 member 元素是否是集合 key 的成员
     *
     * @param key set的key值
     * @return Set<String>
     */
    public Boolean sismember(String key, String value) throws RedisException {
        try {
            return stringRedisTemplate.opsForSet().isMember(key, value);
        } catch (Exception e) {
            log.error("execute 'sismember " + key + "' fail!", e);
            throw new RedisException("execute 'sismember " + key + "'fail!", e);
        }
    }

    /**
     * Redis set类型移除set中一个或多个元素，等价于Redis中的'srem key field1 field2 field3'命令
     *
     * @param key    set的key值
     * @param fields 调用者可以传入一个String[]类型的变量，也可以传入多个String类型的变量
     * @return Long 删除元素的个数
     */
    public Long srem(String key, String... fields) throws RedisException {
        try {
            return stringRedisTemplate.opsForSet().remove(key, fields);
        } catch (Exception e) {
            log.error("execute 'srem " + key + " " + fields + "' fail!", e);
            throw new RedisException("execute 'srem " + key + " " + fields + "' fail!", e);
        }
    }

    //////////////////////////// 对key的操作 ///////////////////////////

    /**
     * 设置Redis中元素的过期时间，可以为Redis任意类型的元素设置过期时间
     *
     * @param key         redis元素的key
     * @param expiredTime 过期时间，单位：秒
     * @return Boolean  返回成功标识
     */
    public Boolean expire(String key, int expiredTime) throws RedisException {
        try {
            return stringRedisTemplate.expire(key, expiredTime, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error("execute 'expire " + key + "' fail!", e);
            throw new RedisException("execute 'expire " + key + "' fail!", e);
        }
    }

    public Boolean expireAt(final String key, Date expiredTime) {
        try {
            return stringRedisTemplate.expireAt(key, expiredTime);
        } catch (Exception e) {
            log.error("execute 'expire " + key + "' fail!", e);
            throw new RedisException("execute 'expire " + key + "' fail!", e);
        }
    }

    /**
     * 设置Redis中元素的过期时间，可以为Redis任意类型的元素设置过期时间
     *
     * @param key         redis元素的key
     * @param expiredTime 过期时间，单位: 毫秒
     * @return Boolean  返回成功标识
     * @throws RedisException
     */
    public Boolean expireMilliseconds(String key, int expiredTime) throws RedisException {
        try {
            return stringRedisTemplate.expire(key, expiredTime, TimeUnit.MILLISECONDS);
        } catch (Exception e) {
            log.error("execute 'expire " + key + "' fail!", e);
            throw new RedisException("execute 'expire " + key + "' fail!", e);
        }
    }

    /**
     * 对应redis的'exists'命令
     *
     * @param key
     * @return
     */
    public Boolean exists(String key) throws RedisException {
        try {
            return stringRedisTemplate.hasKey(key);
        } catch (Exception e) {
            log.error("execute 'exists " + key + "' fail!", e);
            throw new RedisException("execute 'exists " + key + "'fail!", e);
        }
    }

    ///////////////////////////// 对Hash类型的操作 ///////////////////////////////

    /**
     * 对应Redis中的"hset key field value"命令
     *
     * @param key   Redis中hash的key值
     * @param field
     * @param value
     * @return boolean  返回成功标识，true为成功，false为失败
     */
    public boolean hset(String key, String field, String value) throws RedisException {
        try {
            // 如果key存在并且更新了此值，则返回0，否则，创建一个新的key返回1
            stringRedisTemplate.opsForHash().put(key, field, value);
        } catch (Exception e) {
            log.error("execute 'hset " + key + " " + field + " " + value + "' fail!", e);
            throw new RedisException("execute 'hset " + key + " " + field + " " + value + "' fail!", e);
        }
        return true;
    }

    /**
     * 对应Redis中的"hget key field"命令
     *
     * @param key
     * @param field
     * @return String 返回field对应的value值
     */
    public String hget(String key, String field) throws RedisException {
        String value = null;
        try {
            value = (String) stringRedisTemplate.opsForHash().get(key, field);
        } catch (Exception e) {
            log.error("execute 'hget " + key + " " + field + "' fail!", e);
            throw new RedisException("execute 'hget " + key + " " + field + "' fail!", e);
        }
        return value;
    }

    /**
     * 得到该key所对应的所有map
     *
     * @param key
     * @return
     */
    public Map<String, String> hgetAll(String key) {
        return stringRedisTemplate.<String, String>opsForHash().entries(key);
    }

    /**
     * 对应Redis中的"hmset key field1 value1 field2 value2 field3 value3"命令
     *
     * @param key  Redis中hash的key值
     * @param hash 多个field、value值对
     * @return String 返回成功标识
     */
    public void hmset(String key, Map<String, String> hash) throws RedisException {
        try {
            stringRedisTemplate.opsForHash().putAll(key, hash);
        } catch (Exception e) {
            log.error("execute 'hmset " + key + " " + hash + "' fail!", e);
            throw new RedisException("execute 'hmset " + key + " " + hash + "' fail!", e);
        }
    }

    /**
     * 对应Redis中的"hmget key field1 field2 field3"命令
     * 如果key对应的hash表在Redis中不存在，则返回的List<String>size等于field个数，所有结果均为null
     *
     * @param key    Redis中hash的key值
     * @param fields 调用者可以传入一个String[]类型的变量，也可以传入多个String类型的变量
     * @return List<String> 按照field顺序返回多个field的value值
     */
    public List<String> hmget(String key, String... fields) throws RedisException {
        List<String> valueList = null;
        if (ArrayUtils.isNotEmpty(fields)) {
            List<String> fieldList = new ArrayList<>(fields.length);
            for (String field : fields) {
                fieldList.add(field);
            }
            try {
                valueList = stringRedisTemplate.<String, String>opsForHash().multiGet(key, fieldList);
            } catch (Exception e) {
                log.error("execute 'hget " + key + " " + fields + "' fail!", e);
                throw new RedisException("execute 'hget " + key + " " + fields + "' fail!", e);
            }
        }
        return valueList;
    }

    /**
     * 根据key的样式拿到所有key
     *
     * @param pattern
     * @return
     * @throws RedisException
     */
    public Set<String> keys(final String pattern) throws RedisException {
        Set<String> result = new HashSet<String>();
        try {
            result = stringRedisTemplate.keys(pattern);
        } catch (Exception e) {
            log.error("execute redisClient.nativeExecute method error!", e);
        }
        return result;
    }

    /**
     * 根据key删除所有key对应的field
     *
     * @param key
     * @return
     * @throws RedisException
     */
    public Long del(final String key) throws RedisException {
        Long count = 1L;
        try {
            stringRedisTemplate.delete(key);
        } catch (Exception e) {
            log.error("execute del command error!", e);
            count = 0L;
        }
        return count;
    }

    /**
     * 删除key对应的某一个具体的filed
     *
     * @param key
     * @param filed
     * @return
     * @throws RedisException
     */
    public Long hdel(final String key, final String filed) throws RedisException {
        return stringRedisTemplate.opsForHash().delete(key, filed);
    }

    ///////////////////////////// 对List类型的操作 ///////////////////////////////

    /**
     * 在列表尾部追加一个元素
     *
     * @param key
     * @param value
     * @return
     * @throws RedisException
     */
    public Long rpush(final String key, final String value) throws RedisException {
        return stringRedisTemplate.opsForList().rightPush(key, value);
    }

    /**
     * 在列表尾部追加一些元素
     *
     * @param key
     * @param values
     * @return
     * @throws RedisException
     */
    public Long rpush(final String key, final Collection<String> values) throws RedisException {
        return stringRedisTemplate.opsForList().rightPushAll(key, values);
    }

    /**
     * 从列表头部取出一个元素并将其从列表中删除
     *
     * @param key
     * @return
     * @throws RedisException
     */
    public String lpop(final String key) throws RedisException {
        return stringRedisTemplate.opsForList().leftPop(key);
    }

    /**
     * 获取从start到end之间的元素
     *
     * @param key
     * @param start
     * @param end
     * @return
     */
    public List<String> range(final String key, final int start, final int end) {
        return stringRedisTemplate.opsForList().range(key, start, end);
    }


    /**
     * 获取从list 长度
     *
     * @param key
     * @return
     */
    public Long llen(final String key) {
        return stringRedisTemplate.opsForList().size(key);
    }


    /**
     * 尝试获取分布式锁
     *
     * @param lockKey    锁
     * @param lockTime   加锁时间,单位ms
     * @param expireTime 超期时间,必须大于业务所需处理时长,单位ms
     * @return 是否获取成功
     */
    public boolean tryGetDistributedLock(String lockKey, String lockTime, int expireTime) {
        Boolean result = false;
        try {
            synchronized (this) {
                result = stringRedisTemplate.opsForValue().setIfAbsent(lockKey, lockTime);
            }
            if (result) {
                stringRedisTemplate.expire(lockKey, expireTime, TimeUnit.MILLISECONDS);
            } else {
                // 允许服务器有2秒时间误差
                long expireAt = Long.parseLong(stringRedisTemplate.opsForValue().get(lockKey)) + expireTime + 2 * 1000;
                // 如果锁已经过期，可重入
                if (expireAt < System.currentTimeMillis()) {
                    stringRedisTemplate.opsForValue().set(lockKey, lockTime);
                    // 重新设置过期时间
                    stringRedisTemplate.expire(lockKey, expireTime, TimeUnit.MILLISECONDS);
                    return true;
                }
            }
        } catch (Exception e) {
            log.error("execute 'tryGetDistributedLock " + lockKey + "' fail!", e);
            del(lockKey);
            throw new RedisException("execute 'tryGetDistributedLock " + lockKey + "' fail!", e);
        }
        return result;
    }

    /**
     * 释放分布式锁
     *
     * @param lockKey  锁
     * @param lockTime 加锁时间
     * @return 是否释放成功
     */
    public boolean releaseDistributedLock(String lockKey, String lockTime) {
        Boolean result = false;
        try {
            if (lockTime.equalsIgnoreCase(stringRedisTemplate.opsForValue().get(lockKey))) {
                del(lockKey);
                result = true;
            }
        } catch (Exception e) {
            log.error("execute 'releaseDistributedLock " + lockKey + "' fail!", e);
            throw new RedisException("execute 'releaseDistributedLock " + lockKey + "' fail!", e);
        }
        return result;
    }

    /**
     * @param key   key
     * @param value value
     * @param score score
     * @return
     */
    public boolean zadd(String key, String value, double score) {
        try {
            return stringRedisTemplate.opsForZSet().add(key, value, score);
        } catch (Exception e) {
            throw new RedisException("execute 'zadd " + key + "' fail!", e);
        }
    }

    /**
     * @param key key
     * @param min min
     * @param max max
     * @return Set
     */
    public Set<ZSetOperations.TypedTuple<String>> rangeByScoreWithScores(String key, double min, double max) {
        try {
            return stringRedisTemplate.opsForZSet().rangeByScoreWithScores(key, min, max);
        } catch (Exception e) {
            throw new RedisException("execute 'rangeByScoreWithScores " + key + "' fail!", e);
        }
    }

    /**
     * @param key key
     * @param min min
     * @param max max
     * @return Long
     */
    public Long removeRangeByScore(String key, double min, double max) {
        try {
            return stringRedisTemplate.opsForZSet().removeRangeByScore(key, min, max);
        } catch (Exception e) {
            throw new RedisException("execute 'removeRangeByScore " + key + "' fail!", e);
        }
    }


    /**
     * 执行 Lua 脚本
     *
     * @param redisScript Lua脚本
     * @param keys        脚本中用到的key列表
     * @param args        脚本的参数
     * @return 脚本执行结果
     */
    public Object executeScript(RedisScript redisScript, List<String> keys, Object... args) {
        return stringRedisTemplate.execute(redisScript, keys, args);
    }

}