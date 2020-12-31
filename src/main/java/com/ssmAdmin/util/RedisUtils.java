package com.ssmAdmin.util;

import com.ssmAdmin.common.Constants;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/***
 * redis客户端
 * 
 * @author xuhb
 *
 */
@SuppressWarnings("all")
@Component
public class RedisUtils {

	private static final  int DEFAULT=1;
	private static final  int SECOND=2;
	private String host= Constants.SPRING_REDIS_HOST;
	private static JedisPool jedisPool = null;// 非切片连接池
	private RedisUtils() {
	}
	/***
	 * 获取redis连接池
	 * 
	 * @return
	 */
	public JedisPool getJedisPool() {
		// 池基本配置
		String host = this.host;
		String[] split = host.split(":");
		if (jedisPool == null) {
			synchronized (RedisUtils.class) {
				JedisPoolConfig config = new JedisPoolConfig();
				// config.setMaxActive(100);
				config.setMaxTotal(100);
				config.setMaxIdle(5);
				// config.setMaxWait(-1);
				config.setMaxWaitMillis(-1);
				config.setTestOnBorrow(false);
				jedisPool = new JedisPool(config, split[0], 6379);
				System.err.println(">>>>>>>>>>>>>>>>>>>>>>连接的Redis 地址: "+  split[0]);
			}
		}
		return jedisPool;
	}

	public static int selectDb(String key) {
		int db = 0;
		if (key != null) {
			try {
				char a = key.toLowerCase().charAt(0);
				if ("1qaz".indexOf(a) != -1) {
					db = 1;
				} else if ("2wsx".indexOf(a) != -1) {
					db = 2;
				} else if ("3edc".indexOf(a) != -1) {
					db = 3;
				} else if ("4rfv".indexOf(a) != -1) {
					db = 4;
				} else if ("t".indexOf(a) != -1) {
					db = 5;
				} else if ("5gb".indexOf(a) != -1) {
					db = 10;
				} else if ("6yhn".indexOf(a) != -1) {
					db = 6;
				} else if ("7ujm".indexOf(a) != -1) {
					db = 7;
				} else if ("8iko".indexOf(a) != -1) {
					db = 8;
				} else if ("90lp".indexOf(a) != -1) {
					db = 9;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return db;
	}

	public  void deleteKey(String key) {
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			jedis.select(selectDb(key));
			jedis.expireAt(key, 1);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
	}

	public  void setex(String key, String value, int seconds) {
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			jedis.select(selectDb(key));
			jedis.setex(key, seconds, value);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
	}

	public  void set(String key, String value) {
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			jedis.select(DEFAULT);
			jedis.set(key, value);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
	}


	public  void setEXFixedDB(String key, String value,int seconds,int DB) {
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			jedis.select(DB);
			jedis.setex(key, seconds, value);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
	}

	public  String getFixedDB(String key,int DB) {
		String v = null;
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			jedis.select(DB);
			v = jedis.get(key);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
		return v;
	}

	public  Set<String> getVagueKeysDB(String key,int DB) {
		Set<String> keys = null;
		Jedis jedis = null;
		try {
			 jedis = getJedisPool().getResource();
			 jedis.select(DB);
			 key=key+"*";
			 keys = jedis.keys(key);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
		return keys;
	}



	/***
	 * 保存值 并设置有效时间
	 * @param key
	 * @param value
	 * @param seconds
	 */
	public void setRbEx(String key,String value,int seconds){
		Jedis jedis = null;
		if(value!=null && seconds>0){
			jedis = getJedisPool().getResource();
			try{
				if(jedis!=null){
					selectDb(key);
					jedis.setex(key, seconds, value);
				}
			}catch(Exception e){
				e.printStackTrace();
				getJedisPool().returnBrokenResource(jedis);
			}finally{
				getJedisPool().returnResource(jedis);
			}
		}
	}

	public  String getRbEx(String key) {
		String v = null;
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			if(jedis!=null){
				selectDb(key);
				v = jedis.get(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
		return v;
	}
	public  String get(String key) {
		String v = null;
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			jedis.select(DEFAULT);
			v = jedis.get(key);
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
		return v;
	}




	/***
	 * 向名称为key的hash中添加元素field
	 * @param key
	 * @param filed
	 * @param value
	 */
	public void hset(String key,String filed,String value){
		Jedis jedis = getJedisPool().getResource();
		try{
			if(jedis!=null){
				jedis.hset(key,filed,value);
			}
		}catch(Exception e){
			e.printStackTrace();
			getJedisPool().returnBrokenResource(jedis);
		}finally{
			getJedisPool().returnResource(jedis);
		}

	}

	/**
	 * 返回名称为key的hash中field对应的value
	 * @param key
	 * @param filed
	 */
	public String hget(String key,String filed){

		Jedis jedis =   getJedisPool().getResource();
		String o=null;
		try{
			if(jedis!=null){
				o=jedis.hget(key,filed);
			}
		}catch(Exception e){
			e.printStackTrace();
			getJedisPool().returnBrokenResource(jedis);
		}finally{
			getJedisPool().returnResource(jedis);
		}

		return o;
	}

	/***
	 * 根据key返回相应length的数据集合
	 * 
	 * @param key
	 * @param length
	 * @return
	 */
	public  List<String> lrange(String key, Integer length) {
		// 获取jedis连接
		Jedis jedis = null;
		List<String> list = new ArrayList<String>();
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			jedis.select(selectDb(key));
			// 获取length长度数据
			list.addAll(jedis.zrevrange(key, 0, length));
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
		return list;
	}

	/***
	 * 保存数据
	 * 
	 * @param key
	 * @param value
	 */
	public  void lpush(String key, String value) {
		// 获取jedis连接
		Jedis jedis = null;
		try {
			jedis = getJedisPool().getResource();
			// 选择第一个库
			jedis.select(selectDb(key));
			// 根据key存value 如果value重复 就覆盖 并且位置排在最前
			if (key != null && value != null) {
				jedis.zadd(key, jedis.zcard(key), value);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 释放连接
			getJedisPool().returnBrokenResource(jedis);
		} finally {
			// 返回连接到池
			getJedisPool().returnResource(jedis);
		}
	}

	/***
	 * 序列化
	 * 
	 * @param object
	 * @return
	 */
	public static byte[] serialize(Object object) {
		ByteArrayOutputStream baos = null;
		ObjectOutputStream oos = null;
		try {
			// 序列化
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(object);
			byte[] bytes = baos.toByteArray();
			return bytes;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (oos != null) {
				try {
					oos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	/***
	 * 反序列化
	 * 
	 * @param bytes
	 * @return
	 */
	public static Object unserialize(byte[] bytes) {
		ByteArrayInputStream bais = null;
		ObjectInputStream ois = null;
		try {
			// 反序列化
			bais = new ByteArrayInputStream(bytes);
			ois = new ObjectInputStream(bais);
			return ois.readObject();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ois != null) {
				try {
					ois.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

}
