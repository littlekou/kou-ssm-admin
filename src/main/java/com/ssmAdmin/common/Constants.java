package com.ssmAdmin.common;


public class Constants {
	
	/**
	 * 上传文件总目录
	 */
	public static String UPLOAD = "/tomcat/images/";
	public static String img_pre = "/images/";
	public static String IMAGE_PRE = "/uploadFiles/";

	public static String certPath ="/tomcat/cert/";
	public static String cert_pre = "/cert/";

	public static final String toForm = "toForm";
	public static String submitForm = "submitForm";
	public static String stoken = "stoken";
	public static final String formMsg = "请不要重复提交！";

	public static final int FIXED_DB =7;

	public static final String DEFAULT_LISTENER="[{\"appName\":\"支付宝\",\"orderNumberPattern\":\"\",\"orderAmountPattern\":\"([d.]+)元\",\"packageName\":\"com.eg.android.AlipayGphone\",\"PlayType\":4},{\"appName\":\"微信\",\"orderNumberPattern\":\"\",\"orderAmountPattern\":\"([d.]+)元\",\"packageName\":\"com.tencent.mm\",\"PlayType\":5},{\"appName\":\"eCardPlay\",\"orderNumberPattern\":\"订单:([d.]+)\",\"orderAmountPattern\":\"([d.]+)元\",\"packageName\":\"com.buybal.buybalpay.nxy.fkepay\",\"PlayType\":6}]";

	/**
	 * 支付的费率
	 */
	public static final int PAY_THOUSAND=1000;

	public interface ROLE_ID{
		Integer MEMBER_AGENT=2; //代理商
		Integer MEMBER_CODE=5; //码商
		Integer MEMBER_SUPPER=1; //超级管理员
		Integer MEMBER_NORMAL=4; //商户
		Integer MEMBER_OPERATOR =7; //操作员
		Integer MEMBER_DATA_AGENT =10; //数据代理商
	}
	/**
	 * 提现手续费
	 **/
	public interface LOG_TYPE{
		Integer REPLACE =3; //商户打款
		Integer REPLACE_FAIL=9; //代付失败
		Integer REPLACE_PROCESS=10; //代付手续费
		Integer REPLACE_PROCESS_FAIL=11; //代付手续费
	}
	//conf配置文件
	public static int WITHDRAW;// =Integer.valueOf(ProperManager.getString("paymentFee"));
	public static String STATIC_URL;// =ProperManager.getString("static.url");
	public static String SPRING_REDIS_HOST = "127.0.0.1:6379";
	public static String PAY_URL;
	public static String AUTO;

	public static String SYSNAME;
	public static String SYSLOGO;
	public static String LOGOBACKGROUND;

	public static String TRANSFER_URL;
	public static String BANKINFOR_URL;
	public static String LOGIN_STATUS;

	/**
	 * 码商佣金
	 */
	public   interface  SK_COMMISSION{
		float  LEVEL_ONE=2/10000;
		float  LEVEL_TWO=1/10000;
	}
	public interface STATUS{
		 int PASS=2; //通过
		 int DELETE=32; //删除
		 int FORBIDDEN=256; //禁用
	}

	public static String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCTCz2TiofLGQLBzZc2u022kbRZmaKKRZdGeEwH8StyaanKgY6K07UREQgsYb3uNJ+Umf6umuuGLWfarekcFgF1y8ItY2KaMtTConfyD+5XIsMZVFgwMxzACF1Xph0q4Zs8q2cMGTeNOC0SCV7RNS0KdW8JWpGwEMBJELtTqdVIxwIDAQAB";
	public static String privateKey = "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJMLPZOKh8sZAsHNlza7TbaRtFmZoopFl0Z4TAfxK3JpqcqBjorTtRERCCxhve40n5SZ/q6a64YtZ9qt6RwWAXXLwi1jYpoy1MKid/IP7lciwxlUWDAzHMAIXVemHSrhmzyrZwwZN404LRIJXtE1LQp1bwlakbAQwEkQu1Op1UjHAgMBAAECgYB4UA8vBH89b5Zw6n4ae0EH68oMMgfraStwrodPTEZHVCtoFX+DGdwiPbRZVBQqroYP+byIMxwY6lf6dqewolTIRPlzJWS9ucXZzzf7fbxfODBsATH3XLUdBP8Mz2AvUu8eVtVvkdL7H+8VkKir+ftFkDAWRi0lxGXTmo/LEZuPSQJBANgeN394+Eea9F0eLSdTqD2C2zxEnvQAt82kpYcgJKDvig1Mi1sArW47l5jepVVyAQGsBsrFj0+XiVpyBkZlu3MCQQCuLdg6z5DEl11+ITKkWGBXHAaJBYO+Avb9XCkwaewjTGpfLq5UUqUrHlVD1o4fB2GabIGkNZPw0hcF716/8xBdAkBIqeg5COBZmwT8ZhACgAM6I0w5OE1FdxRVpT0ucKVAIyoEjK7yOwkU3h57fKiUUQ97k255MPGdbjL1YQ8xDjV3AkBlXOKYHxEVhyzuaO1qvM+cAgA/n0jyvBD2krqZpRq51A+XQrhK9CmQtT9Tkjn1DrubPYgYguGMZQbm+k1+kTo1AkAWHDhBLpacmJnDwq0NLlwZosktsA6AtHccYAWPfmsoxReWTjNSnz4PxoaRNkYzvP663S6vy8uEaTZ0SfVRKl7w";

}
