<%@ page import="cn.unitid.spark.demo.DemoBSparkConfig" %>
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
    <title>Demo-B-消息推送示例</title>
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
    <script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/demox.js"></script>
</head>
<body>
<jsp:include page="/header.jsp"/>

<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>应用消息推送示例</h1>
                <p class="lead">用户的统一认证平台中，查看消息统计，点击“直达处理”，进入到应用消息处理页面</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">应用消息推送通知</h3>
                </div>
                <div class="panel-body">
                    <div class="well-lg">
                        当前页面，由统一认证平台中，查看消息通知时，点击“直达处理”而跳转进入。在实际系统中，用户处理过消息通知中的事务之后，应该由应用系统发送相应的消息撤销请求给统一认证平台，表示该条消息通知的业务已经处理完毕。消息撤销后，用户在统一认证平台中将不再会看到该条消息通知
                    </div>
                </div>

                <div class="panel-footer"></div>
            </div>
        </div>
    </div>
    <hr>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
