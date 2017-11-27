<%@ page import="cn.unitid.spark.qrsign.sdk.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.unitid.spark.qrsign.sdk.ValueText" %>
<%@ page import="cn.unitid.spark.qrsign.sdk.QRCodeSignatureResponseEntity" %>
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
</head>
<body>
<jsp:include page="/header.jsp"/>

<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>二维码扫码签名示例</h1>

                <p class="lead">Step 2）显示数字证书签名结果，包括签名证书Base64编码值，Base64签名值</p>
            </div>
        </div>
        <jsp:include page="/netonex.jsp"/>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">显示数字证书签名结果</h3>
                </div>
                <div class="panel-body">

                    <form id="signForm" name="frm" class="form-horizontal"
                          action="" method="POST">
                        <%QRCodeSignatureResponseEntity resp = (QRCodeSignatureResponseEntity) request.getAttribute("signedBusinessData");%>
                        <div class="form-group">
                            <label for="id_certificate" class="col-md-2 col-sm-2 control-label">签名证书(Base64编码)</label>

                            <div class="col-md-8 col-sm-8">
                                <textarea rows="16" cols="64"
                                          id="id_certificate"><%=resp.getSparkCertificate()%></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="id_signature" class="col-md-2 col-sm-2 control-label">签名值(Base64编码)</label>

                            <div class="col-md-8 col-sm-8">
                                <textarea rows="10" cols="64" id="id_signature"><%=resp.getSparkSignature()%></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="id_data" class="col-md-2 col-sm-2 control-label">签名原文</label>

                            <div class="col-md-8 col-sm-8">
                                <textarea rows="10" cols="64" id="id_data"><%=resp.getSparkData()%></textarea>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel-footer"></div>
            </div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="/footer.jsp"/>
</body>
</html>
