package cn.unitid.spark.qrsign.sdk;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/7/29
 * @since 1.0
 */
public class QRCodeSignatureResponse {

    public static QRCodeSignatureResponseEntity getResponse(HttpServletRequest request) {

        String state = request.getParameter("qrcs");
        String qrc_uuid = request.getParameter("qrc_uuid");

        String signature = request.getParameter("sparkSignature");
        String certificate = request.getParameter("sparkCertificate");
        String data = request.getParameter("sparkData");


        System.out.println("qrc_uuid=" + qrc_uuid);
        System.out.println("state=" + state);
        System.out.println("data=" + data);
        System.out.println("certificate=" + certificate);
        System.out.println("signature=" + signature);

        return new QRCodeSignatureResponseEntity(data, certificate, signature);
    }
}
