/*
 * Project: android-base sdk
 * 
 * @(#) PropertiesUtil.java   
  * Created on  202015-10-12 15:36 
 * @author  lyb
 */
package cn.unitid.spark.demo;

import com.google.gson.Gson;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

/**
 * <p>
 * This class provides...
 * </p>
 * User: lyb
 * Date: 2015-10-12 15:36
 */
public class DataUtil {
    private static Properties  account_bind_props = new Properties();

    static {

        try {
            account_bind_props.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("account_bind.properties"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public  static User  getUserByOpenId(String openId){
        Gson  gson=new Gson();
        Enumeration enumeration=account_bind_props.keys();
        while(enumeration.hasMoreElements()){
            String key=enumeration.nextElement().toString();
            String item=account_bind_props.getProperty(key);
            User u=gson.fromJson(item,User.class);
          if(openId.equals(u.getOpenid()))   return u;
        }

        return null;
    }

    public  static User  getUserByAccount(String account){
        Gson  gson=new Gson();
        Enumeration enumeration=account_bind_props.keys();
        while(enumeration.hasMoreElements()){
            String key=enumeration.nextElement().toString();
            String item=account_bind_props.getProperty(key);
            User u=gson.fromJson(item,User.class);
            if(account.equals(u.getAccount()))   return u;
        }

        return null;
    }

    public static List<User> getUserList(){
       List<User> userList=new ArrayList<User>();
        Gson  gson=new Gson();
        Enumeration enumeration=account_bind_props.keys();
        while(enumeration.hasMoreElements()){
            String key=enumeration.nextElement().toString();
            String item=account_bind_props.getProperty(key);
            User u=gson.fromJson(item,User.class);
            if(u!=null)  userList.add(u);
        }
        return userList;
    }


    public static String getValue(String key) {
        return account_bind_props.getProperty(key);
    }


    public static void  put(String key,String value) throws IOException {
        account_bind_props.put(key,value);
        String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
        OutputStream fos = new FileOutputStream(path+"/account_bind.properties");
        account_bind_props.store(fos, "");
        fos.close();
    }

    /**
     * 清除数据
     * @throws IOException
     */
    public static void clear() throws IOException {
        account_bind_props.clear();
        Properties  user_props = new Properties();
        String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
        OutputStream fos = new FileOutputStream(path+"/account_bind.properties");
        user_props.store(fos, "");
        fos.close();
    }

}
