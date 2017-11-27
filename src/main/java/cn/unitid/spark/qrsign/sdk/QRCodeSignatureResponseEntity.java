package cn.unitid.spark.qrsign.sdk;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/7/28
 * @since 1.0
 */
public class QRCodeSignatureResponseEntity {

    private String sparkSignature;

    private String sparkCertificate;

    private String sparkData;


    public QRCodeSignatureResponseEntity(String data, String certificate, String signature) {
        this.sparkData = data;
        this.sparkCertificate = certificate;
        this.sparkSignature = signature;
    }

    public String getSparkSignature() {
        return sparkSignature;
    }

    public void setSparkSignature(String sparkSignature) {
        this.sparkSignature = sparkSignature;
    }

    public String getSparkCertificate() {
        return sparkCertificate;
    }

    public void setSparkCertificate(String sparkCertificate) {
        this.sparkCertificate = sparkCertificate;
    }

    public String getSparkData() {
        return sparkData;
    }

    public void setSparkData(String sparkData) {
        this.sparkData = sparkData;
    }
}
