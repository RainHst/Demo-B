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
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>初始化设置</h1>

                <p class="lead">初始化Demo-B，可以设置APP_ID和APP_KEY，以演示DemoX接入到Spark的整个流程</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">APP_ID和APP_KEY设置</h3>
                </div>
                <div class="panel-body">

                    <form id="app_form" class="form-horizontal" action="<%=request.getContextPath()%>/account"
                          method="post">
                        <input type="hidden" name="action" value="config"/>
                        <div class="form-group">
                            <label for="appID" class="col-md-2 col-sm-2 control-label">APP ID</label>

                            <div class="col-md-8 col-sm-8">
                                <input type="text" class="form-control" id="appID"
                                       name="appID"   value="<%=DemoBSparkConfig.getAppId()==null?"":DemoBSparkConfig.getAppId()%>"
                                       placeholder="APP ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="appKey" class="col-md-2 col-sm-2 control-label">APP KEY</label>

                            <div class="col-md-8 col-sm-8">
                                <input type="text" class="form-control" id="appKey"
                                       name="appKey"  value="<%=DemoBSparkConfig.getAppKey()==null?"":DemoBSparkConfig.getAppKey()%>"
                                       placeholder="APP KEY">

                                <p class="help-block"><strong>注意：</strong>APP KEY是Spark校验APP的凭证，请妥善保存，切勿外泄</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="appKey" class="col-md-2 col-sm-2 control-label">认证地址</label>

                            <div class="col-md-8 col-sm-8">
                                <%
                                    String url = DemoBSparkConfig.getOauthBaseUrl();
                                    if (url != null) {
                                        url = url.substring(0, url.lastIndexOf("/"));
                                    } else {
                                        url = "";
                                    }
                                %>
                                <input type="text" class="form-control" id="url"
                                       placeholder="https://192.168.10.117:443" name="url"  value="<%=url%>">

                                <p class="help-block">请输入认证URL</p>
                            </div>
                        </div>

                        <div class="form-group">

                            <!-- Text input-->
                            <label class="col-md-2 col-sm-2 control-label">回调地址</label>
                            <div class="col-md-8 col-sm-8">
                                <%
                                    String callback = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/account?action=callback";
                                %>
                                <input class="form-control input-large" type="text"  name="callback"  value="<%=callback%>">
                                <p class="help-block">默认应用回调地址，可直接使用。如果端口或者地址变更，请修改这里</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label"></label>

                            <div class="col-md-7 col-sm-7">
                                <button type="submit" class="btn btn-primary">保存设置</button>
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
<jsp:include page="footer.jsp"/>
</body>
</html>
