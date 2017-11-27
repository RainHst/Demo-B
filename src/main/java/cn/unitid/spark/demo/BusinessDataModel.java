package cn.unitid.spark.demo;

import cn.unitid.spark.qrsign.sdk.QRCodeSignatureRequestEntity;
import cn.unitid.spark.qrsign.sdk.QRCodeSignatureResponseEntity;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/7/28
 * @since 1.0
 */
public class BusinessDataModel {

    private int status = 0;//-1,0,1

    private String uuid;

    private QRCodeSignatureRequestEntity qrcsRequestEntity;

    private QRCodeSignatureResponseEntity qrcsResponseEntity;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public QRCodeSignatureRequestEntity getQrcsRequestEntity() {
        return qrcsRequestEntity;
    }

    public void setQrcsRequestEntity(QRCodeSignatureRequestEntity qrcsRequestEntity) {
        this.qrcsRequestEntity = qrcsRequestEntity;
    }

    public QRCodeSignatureResponseEntity getQrcsResponseEntity() {
        return qrcsResponseEntity;
    }

    public void setQrcrResponseEntity(QRCodeSignatureResponseEntity qrcsResponseEntity) {
        this.qrcsResponseEntity = qrcsResponseEntity;
    }
}
