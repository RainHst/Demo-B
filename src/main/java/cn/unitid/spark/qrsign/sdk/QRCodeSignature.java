package cn.unitid.spark.qrsign.sdk;

import com.google.gson.GsonBuilder;
import org.apache.log4j.Logger;
import org.spongycastle.util.encoders.Base64;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/7/29
 * @since 1.0
 */
public class QRCodeSignature {

    private String qrcQueryUrl;

    private String state = null;

    private QRCodeSignatureRequestEntity qrcsrEntity;


    private final String QRC_UUID = "QRC_UUID";
    private final String QRC_CODE2SCAN = "QRC_CODE2SCAN";
    private final String QRC_2BESIGNED_DATA = "QRC_2BESIGNED_DATA";

    private final int QRC_OPERATION_TYPE = 3;

    private Logger logger = Logger.getLogger(QRCodeSignature.class);

    private QRCodeSignature() {

    }

    public QRCodeSignature(String qrcQueryUrl, String httpMethod) throws QRCodeSignatureException {
        this.setQRCQueryUrl(qrcQueryUrl, httpMethod);
    }

    public void buildQRCode2SCAN(HttpServletRequest request, QRCodeSignatureRequestEntity qrcsRequestEntity) {

        String qrcContent = this.buildQRCodeContentForMobileScan();
        request.setAttribute(QRC_UUID, qrcsRequestEntity.getUuid());
        request.setAttribute(QRC_CODE2SCAN, qrcContent);

        String toBeSignedValue = qrcsRequestEntity.getToBeSignedDataString();
        request.setAttribute(QRC_2BESIGNED_DATA, toBeSignedValue);

        this.qrcsrEntity = qrcsRequestEntity;
        logger.debug("raw data=" + toBeSignedValue);
        logger.debug("raw base64 data=" + new String(Base64.encode(toBeSignedValue.getBytes())));
    }

    public QRCodeSignatureRequestEntity getRebuildQRCodeSignatureRequestEntity() {
        return this.qrcsrEntity;
    }

    /**
     * 设置开放待签名数据查询的URL，默认HTTP请求方法为GET 。如http://192.168.10.100:8080/demo/qrsign.do?action=sign
     *
     * @param queryUrl
     * @throws QRCodeSignatureException
     */
    public void setQRCQueryUrl(String queryUrl) throws QRCodeSignatureException {
        this.setQRCQueryUrl(queryUrl, "GET");
    }

    /**
     * 设置开放待签名数据查询的URL，如http://192.168.10.100:8080/demo/qrsign.do?action=sign
     *
     * @param queryUrl          开放待签名数据查询的URL
     * @param httpRequestMethod GET或者POST
     * @throws QRCodeSignatureException 如果httpRequestMethod值错误
     */
    public void setQRCQueryUrl(String queryUrl, String httpRequestMethod) throws QRCodeSignatureException {
        this.setHttpRequestUrl(0, queryUrl, httpRequestMethod);
    }

    /**
     * 设置签名数据回调的URL，默认HTTP请求方法为GET 。如http://192.168.10.100:8080/demo/qrsign.do?action=sign
     *
     * @param callBackUrl 签名数据回调的URL
     * @throws QRCodeSignatureException
     */
    public void setCallBackUrl(String callBackUrl) throws QRCodeSignatureException {
        this.setCallBackUrl(callBackUrl, "GET");
    }

    /**
     * 设置开放待签名数据查询的URL，默认HTTP请求方法为GET 。如http://192.168.10.100:8080/demo/qrsign.do?action=sign
     *
     * @param callBackUrl       签名数据回调的URL
     * @param httpRequestMethod GET或者POST
     * @throws QRCodeSignatureException
     */
    public void setCallBackUrl(String callBackUrl, String httpRequestMethod) throws QRCodeSignatureException {
        this.setHttpRequestUrl(1, callBackUrl, httpRequestMethod);
    }

    public String getState() {
        return this.state;
    }


    private void setHttpRequestUrl(int type, String queryUrl, String httpRequestMethod) throws QRCodeSignatureException {
        String httpMethod;
        if (httpRequestMethod == null) {
            httpMethod = "&qrcm=GET";
        } else {
            if (httpRequestMethod.equalsIgnoreCase("GET")) {
                httpMethod = "&qrcm=GET";
            } else if (httpRequestMethod.equalsIgnoreCase("POST")) {
                httpMethod = "&qrcm=POST";
            } else {
                throw new QRCodeSignatureException("invalid http request method: " + httpRequestMethod);
            }
        }

        this.state = RandomStatusGenerator.getRandomNumber();
        if (type == 0) {
            this.qrcQueryUrl = queryUrl + httpMethod + "&qrcs=" + state;
        } else {
            String qrcCallBackUrl = queryUrl + httpMethod + "&qrcs=" + state;
            this.qrcsrEntity.setCallBackUrl(qrcCallBackUrl);
        }
    }

    private String buildQRCodeContentForMobileScan() {
        Map<String, Object> requestMap = new HashMap<String, Object>();
        requestMap.put("url", this.qrcQueryUrl);
        requestMap.put("type", QRC_OPERATION_TYPE);

        String qrcContent = new GsonBuilder().disableHtmlEscaping().create().toJson(requestMap);
        logger.debug("action=apply&qrcode2Sign=" + qrcContent);
        return qrcContent;
    }
}
