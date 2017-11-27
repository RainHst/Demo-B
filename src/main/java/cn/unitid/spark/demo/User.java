/*
 * Project: android-base sdk
 * 
 * @(#) User.java   
  * Created on  202015-10-12 15:35 
 * @author  lyb
 */
package cn.unitid.spark.demo;

import cn.unitid.spark.app.sdk.connect.javabeans.auth.ExtensionOIDBean;
import org.ietf.jgss.Oid;

import java.util.List;

/**
 * <p>
 * This class provides...
 * </p>
 * User: lyb
 * Date: 2015-10-12 15:35
 */
public class User {
    private String id;
    private String account;
    private String openid;
    private String password;

    private String certificate;
    private String name;

    private List<ExtensionOIDBean> oidList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCertificate() {
        return certificate;
    }

    public void setCertificate(String certificate) {
        this.certificate = certificate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<ExtensionOIDBean> getOidList() {
        return oidList;
    }

    public void setOidList(List<ExtensionOIDBean> oidList) {
        this.oidList = oidList;
    }
}
