/*
 * Project: android-base sdk
 * 
 * @(#) PropertiesUtil.java   
  * Created on  202015-10-12 15:36 
 * @author  lyb
 */
package cn.unitid.spark.demo;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * <p>
 * This class provides...
 * </p>
 * User: lyb
 * Date: 2015-10-12 15:36
 */
public class DemoBSparkConfig {
    private static String OAUTH_BASE_URL="oauth_base_URL";
    private static String OPENAPI_BASE_URL="openapi_base_URL";
    private static String APP_ID="app_ID";
    private static String APP_KEY="app_KEY";
    private static String REDIRECT_URI="redirect_URI";
    private static String LOGIN_MODE="login_mode";

    private static PropertiesUtil spark_config_props = new PropertiesUtil();
    static {
        try {
            spark_config_props.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("spark_connect_config.properties"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        if(spark_config_props.get("authorize_URL")==null){
            spark_config_props.put("VERSION","1.0.0.1");
            spark_config_props.put("DEBUG","true");
            spark_config_props.put("scope","user");
            spark_config_props.put("authorize_URL","/oauth/authorize");
            spark_config_props.put("access_token_URL","/oauth/token");
            spark_config_props.put("get_openID_URL","/oauth/me");
            spark_config_props.put("get_user_info_URL","/user/get_user_info");
            spark_config_props.put("get_user_extension","/user/get_user_extension");
            spark_config_props.put("direct_get_user_extension_URL","/user/direct_get_user_extension");
            spark_config_props.put("direct_bind_user_extension_URL","/user/direct_bind_user_extension");
            spark_config_props.put("bind_user_extension_request_URL","/user/direct_bind_user_extension");
            spark_config_props.put("parse_user_cert_URL","/user/parse_user_cert");

        }
    }

    public static String getValue(String key) {
        return spark_config_props.getProperty(key);
    }

    /**
     * 设置AppId
     * @param appId
     * @throws IOException
     */
    public static void  setAppId(String appId) throws IOException {
        spark_config_props.put(APP_ID,appId);

    }

    public static String getAppId(){
        return (String) spark_config_props.get(APP_ID);
    }

    public static String getAppKey(){
        return (String) spark_config_props.get(APP_KEY);
    }

    public static String getOauthBaseUrl(){
        return (String) spark_config_props.get(OAUTH_BASE_URL);
    }

    /**
     * 设置APPKEY
     * @param appKey
     */
    public static void setAppKey(String appKey){
        spark_config_props.put(APP_KEY,appKey);

    }

    /**
     *  设置 url  https://192.168.10.117:8443
     * @param url
     */
   public static void setOauthBaseUrl(String url){
       spark_config_props.put(OAUTH_BASE_URL,url+"/oauth2");
       spark_config_props.put(OPENAPI_BASE_URL,url+"/openapi");

   }

    /**
     * 设置 url
     * @param url
     */
    public static void setCallBackUrl(String url){
        spark_config_props.put(REDIRECT_URI,url);

    }

    /**
     *  保存配置
     * @throws IOException
     */
    public static void  store() throws IOException {
        String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
        OutputStream fos = new FileOutputStream(path+"/spark_connect_config.properties");
        spark_config_props.store(fos, "");
        fos.close();

    }

    /**
     * 清除数据
     * @throws IOException
     */
    public static void clear() throws IOException {
        String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
        OutputStream fos = new FileOutputStream(path+"/spark_connect_config.properties");
        spark_config_props.put(APP_ID,"");
        spark_config_props.put(APP_KEY,"");
        spark_config_props.store(fos, "");
        fos.close();
    }

    /**
     *  登录模式
     * @param mode
     */
    public static void setLoginMode(String mode){
        spark_config_props.put(LOGIN_MODE,mode);
    }

    /**
     * 登录模式
     */
    public static String getLoginMode(){
        return (String)spark_config_props.get(LOGIN_MODE);
    }
}
