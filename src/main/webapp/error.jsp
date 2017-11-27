<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo-B-初始化设置</title>
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
<jsp:include page="header.jsp"/>



<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <h1>提示信息</h1>
                <p class="lead">未能获取到访问令牌，请联系管理员检查应用配置、认证服务及网络是否正常</p>
            </div>
        </div>
    </div>
</div>
<!-- Footer
================================================== -->
<jsp:include page="footer.jsp"/>
<hr>

<hr>


</body>
</html>
