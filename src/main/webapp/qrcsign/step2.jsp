<%@ page import="cn.unitid.spark.qrsign.sdk.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.unitid.spark.qrsign.sdk.ValueText" %>
<%--
  Created by IntelliJ IDEA.
  User: Iceberg
  Date: 2015/10/15
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo-B-二维码扫码签名示例</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.min.css">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="<%=request.getContextPath()%>/js/html5shiv.js"></script>
    <script src="<%=request.getContextPath()%>/js/respond.min.js"></script>
    <![endif]-->

    <script src="<%=request.getContextPath()%>/js/jquery-1.10.2.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/demox.js"></script>
    <script src="<%=request.getContextPath()%>/qrcsign/qrcode.js"></script>
</head>
<body>
<jsp:include page="/header.jsp"/>

<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>二维码扫码签名示例</h1>

                <p class="lead">Step 2）将用户提交的业务数据显示出来，引导用户确认无误后签名</p>
            </div>
        </div>
        <jsp:include page="/netonex.jsp"/>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">应用系统业务数据确认签名</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-striped" id="toBeSignedTable">

                        <thead>
                        <tr>
                            <th>项目</th>
                            <th>内容</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Item> toBeSignedDataItems = (ArrayList<Item>) request.getAttribute("toBeSignedBusinessData");
                            for (Item item : toBeSignedDataItems) {
                        %>
                        <tr>
                        <tr>
                            <td><%=item.getLabel()%>
                            </td>
                            <%
                                if ("multiSelect".equals(item.getType())) {
                            %>
                            <td>
                                <%
                                    List<ValueText> valueTextList = item.getOptions();
                                    for (ValueText vt : valueTextList) {
                                %>
                                <%=vt.getText()%>
                                <%}%>
                            </td>
                            <%
                            } else if ("singleSelect".equals(item.getType())) {
                            %>
                            <td><%=item.getText()%>
                            </td>
                            <%
                            } else {
                            %>
                            <td><%=item.getValue()%>
                            </td>
                            <%}%>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-lg-2 ">&nbsp;</div>
                            <div class="col-lg-8">
                                <form id="ntxSignForm" name="frm" class="form-horizontal"
                                      action="<%=request.getContextPath() %>/qrsign.do?action=sign" method="POST">
                                    <div class="form-group">
                                        <input type="hidden" name="qrc_uuid"
                                               value="<%=request.getAttribute("QRC_UUID")%>">
                                        <input type="hidden" name="signatureMode" id="signatureMode"
                                               value="<%=request.getAttribute("signatureMode")%>">
                                        <input type="hidden" name="sparkData" id="sparkData"
                                               value='<%=request.getAttribute("QRC_2BESIGNED_DATA")%>'>
                                        <input type="hidden" name="sparkCertificate" id="sparkCertificate" value="">
                                        <input type="hidden" name="sparkSignature" id="sparkSignature" value="">
                                    </div>
                                </form>
                                <button type="button" class="btn btn-primary" onclick="usbKeySign()">
                                    数字证书(控件)签名
                                </button>
                                &nbsp;
                                <button type="button" class="btn btn-success" onclick="showQrcode()">
                                    <span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span> 扫码签名
                                </button>

                                <div class="hidden" id="id_qrcode">
                                    <br>
                                    <div class="img-thumbnail" id="qrcode">
                                    </div>
                                    <p class="help-block"><span class="label label-success">提示&nbsp;</span>
                                        请打开移动客户端APP,扫码签名</p>
                                </div>
                            </div>
                            <div class="col-lg-2 ">&nbsp;</div>
                        </div>
                    </div>
                </div>

                <div class="panel-footer"></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var qrcode = new QRCode(document.getElementById("qrcode"));

    function usbKeySign() {
        $('#id_qrcode').addClass('hidden');
        var ntxData = $("#sparkData").val();
        var signMode = $("#signatureMode").val();

        var netonex = new NetONEX();
        netonex.setupObject();
        var b64x = netonex.getBase64X();
        var colx = netonex.getCertificateCollectionX();
        colx.Load();
        var crtx = colx.SelectCertificateDialog();
        crtx.Quiet = 1;
        var crt_value = crtx.Content;

        var b64data = b64x.EncodeUtf8String(ntxData);
        var pkcs1 = (signMode == 'p1') ? crtx.PKCS1Base64(b64data) : crtx.PKCS7Base64(b64data, 0);

        $('#sparkCertificate').val(crt_value);
        $('#sparkSignature').val(pkcs1);
        $("#ntxSignForm").submit();
    }

    function showQrcode() {
        $('#id_qrcode').attr("class", "");
        qrcode.makeCode('<%=request.getAttribute("QRC_CODE2SCAN")%>');
        Polling();
    }

    var clockID;
    var queryResult = -127;
    var count = 0;
    function synchronous() {
        count++;
        if (count >= 12) {
            $('#qrcode').empty();
            var img = document.createElement("img");
            img.src = "<%=request.getContextPath() %>/img/qrc_invalid.png";
            $('#qrcode').append(img);
            queryResult=-2;
            window.clearInterval(clockID);
        }
        if (queryResult != -2) {
            $.ajax({
                url: '<%=request.getContextPath() %>/qrsign.do?action=issigned',
                type: 'POST',
                async: true,
                data: {qrc_uuid: '<%=request.getAttribute("QRC_UUID")%>'},
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务端返回数据异常，HTTP状态码:" + XMLHttpRequest.status);
                    window.clearInterval(clockID);
                },
                success: function (result) {
                    hasSigned(result);
                }
            });
        }
    }

    function hasSigned(data) {
        if (!data) {
            window.clearInterval(clockID);
        } else {
            if (data.ret == 0) {
                window.clearInterval(clockID);
                $("#ntxSignForm").submit();
            } else if (data.ret == -2) {
                window.clearInterval(clockID);
                queryResult = -2;
            }
        }
    }

    function Polling() {
        synchronous();
        clockID = self.setInterval("synchronous()", 5000);
    }
</script>
<hr>
<jsp:include page="/footer.jsp"/>
</body>
</html>
