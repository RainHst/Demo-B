package cn.unitid.spark.qrsign.sdk;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.List;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author lyb
 * @version $Revision 16/7/27
 * @since 1.0
 */
public class QRCodeSignatureRequestEntity {

    private Integer ret = 0;

    private String openid = null;

    private String appid = null;

    private String uuid;

    private String callBackUrl;

    private String signMode;

    private String appName = "";

    private String attach;

    private List<Item> toBeSignedData;

    private String message = "";

    public Integer getRet() {
        return ret;
    }

    public void setRet(Integer ret) {
        this.ret = ret;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getSignMode() {
        return signMode;
    }

    public void setSignMode(String signMode) {
        this.signMode = signMode;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getAttach() {
        return attach;
    }

    public void setAttach(String attach) {
        this.attach = attach;
    }

    public List<Item> getToBeSignedData() {
        return toBeSignedData;
    }

    public String getToBeSignedDataString() {
        return new GsonBuilder().disableHtmlEscaping().create().toJson(this.toBeSignedData);
    }

    public void setToBeSignedData(List<Item> toBeSignedData) {
        this.toBeSignedData = toBeSignedData;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getCallBackUrl() {
        return callBackUrl;
    }

    public void setCallBackUrl(String callBackUrl) {
        this.callBackUrl = callBackUrl;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String toString() {
        Gson gson = new GsonBuilder().disableHtmlEscaping().create();
        return gson.toJson(this);
    }
}
