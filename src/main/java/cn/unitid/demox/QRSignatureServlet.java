package cn.unitid.demox;

import cn.unitid.spark.demo.BusinessDataModel;
import cn.unitid.spark.demo.BusinessProgressService;
import cn.unitid.spark.qrsign.sdk.*;
import com.google.gson.Gson;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/7/27
 * @since 1.0
 */
public class QRSignatureServlet extends HttpServlet {
    Logger logger = Logger.getLogger(QRSignatureServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

        System.err.println("GET=" + request.getQueryString());

        BusinessProgressService businessProgressService = BusinessProgressService.getInstance();
        String action = request.getParameter("action");
        String state = request.getParameter("qrcs");
        String attrState = (String) request.getAttribute("QRC_STATE");

        logger.debug("action=" + action);
        logger.debug("state=" + state);
        logger.debug("attrState=" + attrState);

        String responseGson = "";

        if ("sign".equals(action)) {
            QRCodeSignatureRequestEntity qrcsEntity = null;

            String uuid = request.getParameter("qrc_uuid");
            Object businessDataObj = businessProgressService.get(uuid);
            if (businessDataObj == null) {

                qrcsEntity = new QRCodeSignatureRequestEntity();
                qrcsEntity.setRet(-1);
                qrcsEntity.setMessage("未发现UUID对应的业务数据");
                responseGson = qrcsEntity.toString();
            } else {
                BusinessDataModel businessDataModel = (BusinessDataModel) businessDataObj;
                if (businessDataModel.getStatus() == 0) {
                    qrcsEntity = businessDataModel.getQrcsRequestEntity();
                    responseGson = qrcsEntity.toString();
                } else {
                    System.err.println("UUID对应的业务数据状态为[已签名],uuid:" + uuid);
                }
            }

            logger.debug("action=sign&method=GET&gson=" + responseGson);
            PrintWriter writer = resp.getWriter();
            writer.write(responseGson);
            writer.flush();
            writer.close();
        } else if ("".equals(action)) {

        }


    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

        System.err.println("POST=" + request.getQueryString());

        BusinessProgressService businessProgressService = BusinessProgressService.getInstance();

        String action = request.getParameter("action");

        if ("apply".equals(action)) {//step1:正常业务申请流程，组织业务数据，展示给用户，以让用户签名确认

            String businessName = request.getParameter("businessName");
            String fee = request.getParameter("fee");
            String department = request.getParameter("department");
            String[] feeUsage = request.getParameterValues("feeUsage");
            String signatureMode = request.getParameter("signatureMode");

            QRCodeSignatureRequestEntity qrcsRequestEntity = this.buildQRCodeSignatureRequestEntity(businessName, fee, department, feeUsage, signatureMode);

            //业务系统生成该笔业务的唯一ID，将业务数据模型存储
            String uuid = UUID.randomUUID().toString();
            qrcsRequestEntity.setUuid(uuid);
            String qrcQueryUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/qrsign.do?action=sign&qrc_uuid=" + uuid;
            String callBackUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/qrsign.do?action=sign&qrc_uuid=" + uuid;

            QRCodeSignature qrCodeSignature = null;
            try {
                qrCodeSignature = new QRCodeSignature(qrcQueryUrl, "GET");
                qrCodeSignature.buildQRCode2SCAN(request, qrcsRequestEntity);
                qrCodeSignature.setCallBackUrl(callBackUrl, "POST");
                qrcsRequestEntity = qrCodeSignature.getRebuildQRCodeSignatureRequestEntity();
            } catch (QRCodeSignatureException e) {
                e.printStackTrace();
            }

            BusinessDataModel businessDataModel = new BusinessDataModel();
            businessDataModel.setUuid(uuid);
            businessDataModel.setQrcsRequestEntity(qrcsRequestEntity);
            businessProgressService.put(uuid, businessDataModel);

            request.setAttribute("toBeSignedBusinessData", qrcsRequestEntity.getToBeSignedData());
            request.setAttribute("signatureMode", signatureMode);

            RequestDispatcher rd = request.getRequestDispatcher("/qrcsign/step2.jsp");
            rd.forward(request, resp);
        } else if ("sign".equals(action)) {
            String uuid = request.getParameter("qrc_uuid");
            Object businessDataObj = businessProgressService.get(uuid);

            if (businessDataObj == null) {
                logger.debug("action=sign " + "no business data found with uuid:" + uuid + " from " + request.getRemoteAddr());
            } else {
                BusinessDataModel businessDataModel = (BusinessDataModel) businessDataObj;
                if (businessDataModel.getStatus() == 1) {
                    request.setAttribute("signedBusinessData", businessDataModel.getQrcsResponseEntity());
                } else {
                    QRCodeSignatureResponseEntity qrcsResponseEntity = QRCodeSignatureResponse.getResponse(request);

                    businessDataModel = (BusinessDataModel) businessProgressService.get(uuid);
                    businessDataModel.setQrcrResponseEntity(qrcsResponseEntity);
                    businessDataModel.setStatus(1);
                    businessProgressService.put(uuid, businessDataModel);

                    request.setAttribute("signedBusinessData", qrcsResponseEntity);

                    String clientType = request.getParameter("clientType");
                    if (clientType != null && clientType.equals("app")) {
                        Map<String, Object> respMap = new HashMap<String, Object>();
                        respMap.put("ret", 0);

                        PrintWriter writer = resp.getWriter();
                        writer.write(new Gson().toJson(respMap));
                        writer.flush();

                        return;
                    }
                }
            }

            RequestDispatcher rd = request.getRequestDispatcher("/qrcsign/step3.jsp");
            rd.forward(request, resp);
        } else if ("issigned".equals(action)) {
            String uuid = request.getParameter("qrc_uuid");
            Object businessDataObj = businessProgressService.get(uuid);
            Map<String, Object> respMap = new HashMap<String, Object>();

            if (businessDataObj == null) {
                logger.debug("action=issigned " + "no business data found with uuid:" + uuid + " from " + request.getRemoteAddr());
                respMap.put("ret", -2);
            } else {
                BusinessDataModel businessDataModel = (BusinessDataModel) businessDataObj;
                if (businessDataModel.getStatus() == 1) {
                    respMap.put("ret", 0);
                } else {
                    respMap.put("ret", -1);
                }

                PrintWriter writer = resp.getWriter();
                writer.write(new Gson().toJson(respMap));
                writer.flush();
                writer.close();
            }
        }

    }


    private QRCodeSignatureRequestEntity buildQRCodeSignatureRequestEntity(String businessName, String fee, String department, String[] feeUsage, String signatureMode) {
        List<Item> toBeSignedBusinessData = this.organizeBusinessDataFlow(businessName, fee, department, feeUsage);

        QRCodeSignatureRequestEntity qrcEntity = new QRCodeSignatureRequestEntity();
        qrcEntity.setAppName("Demo-B");
        qrcEntity.setOpenid("");
        qrcEntity.setSignMode(signatureMode);
        qrcEntity.setToBeSignedData(toBeSignedBusinessData);

        return qrcEntity;
    }

    private List<Item> organizeBusinessDataFlow(String businessName, String fee, String department, String[] feeUsage) {
        Map<String, String> departmentMap = new HashMap<String, String>();
        departmentMap.put("A001", "研发部");
        departmentMap.put("A002", "管理部");
        departmentMap.put("A003", "销售部");

        Map<String, String> feeUsageMap = new HashMap<String, String>();
        departmentMap.put("1", "会务");
        departmentMap.put("2", "活动");
        departmentMap.put("3", "餐饮");

        List<Item> attrList = new ArrayList<Item>();
        Item item = new Item();
        item.setType("text");
        item.setLabel("业务名称");
        item.setValue(businessName);
        item.setName("businessName");
        attrList.add(item);

        item = new Item();
        item.setType("text");
        item.setLabel("费用金额");
        item.setValue(fee);
        item.setName("fee");
        attrList.add(item);

        item = new Item();
        item.setType("singleSelect");
        item.setLabel("部门");
        item.setValue(department);
        item.setName("department");
        item.setText(departmentMap.get(department));
        attrList.add(item);

        item = new Item();
        item.setType("multiSelect");
        item.setLabel("费用用途");
        item.setName("feeUsage");
        List<ValueText> valueTextList = new ArrayList<ValueText>();

        ValueText vt;
        if (feeUsage.length > 0) {
            for (int i = 0; i < feeUsage.length; i++) {
                vt = new ValueText();
                vt.setValue("" + feeUsage[i]);
                vt.setText(departmentMap.get(feeUsage[i]));
                valueTextList.add(vt);
            }
        }
        item.setOptions(valueTextList);
        attrList.add(item);

        return attrList;
    }
}
