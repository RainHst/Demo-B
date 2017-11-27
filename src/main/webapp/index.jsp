<%@ page import="cn.unitid.spark.demo.User" %>

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
    <title>Demo-B</title>
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
    <script>
        function bindPageLoad() {

            ajaxLoad("<%=request.getContextPath()%>/account?action=bind", {}, function (data) {
                $("#OpenID").attr("value", data.user.openid);
                if (data.user.name != "null")
                    $("#name").attr("value", data.user.name);
                $("#sn").attr("value", data.sn);
                $("#date").attr("value", data.date);
                $("#subject").val(data.subject);
                $("#account").val(data.user.account);
                $("#password").val(data.user.password);
                $("#cert").val(data.user.certificate);
                var content = "";
                for (var i = 0; i < data.user.oidList.length; i++) {
                    content = content + "<tr><td>" + data.user.oidList[i].name + "</td><td>" + data.user.oidList[i].value + "</td></tr>";
                }

                $("#oidList").append(content);
            });
        }
    </script>
</head>
<body onload="bindPageLoad();">
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <h1>Demo-B</h1>

                <p class="lead">Demo-B 是一个演示程序，演示了一个应用接入到Spark的整个流程</p>
            </div>
        </div>
    </div>


    <%
        if (request.getSession().getAttribute("user") != null) {
            User user = (User) request.getSession().getAttribute("user");
            String username = "匿名用户";
            if (user.getAccount() != null && !"".equals(user.getAccount())) {
                username = user.getAccount();
            } else {

            }
    %>
    <div class="alert alert-success">
        <strong>登录成功！</strong>欢迎回来，<% if ("匿名用户".equals(username)) {%><a href="<%=request.getContextPath()%>/bind.jsp">完善信息</a> <%} else {%> <%=username%>  <%}%>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">通过API获取用户信息如下</h3>
                </div>
                <div class="panel-body">
                    <form id="" class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-md-2 col-sm-2 ">OpenID</label>

                            <div class="col-md-8 col-sm-8 ">
                                <input type="text" class="form-control" id="OpenID" name="OpenID" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label">昵称</label>

                            <div class="col-md-8 col-sm-8 ">
                                <input type="text" class="form-control" id="name" name="name" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label">扩展信息</label>

                            <div class="col-md-8 col-sm-8">
                                <table id="oidList" class="table  table-striped">
                                    <thead>
                                    <tr>
                                        <th>OID名称</th>
                                        <th>OID值</th>
                                    </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label">证书信息</label>

                            <div class="col-md-8 col-sm-8">
                                <table class="table table-striped">
                                    <tbody>
                                    <tr>
                                        <td width="80px">证书项</td>
                                        <td>
                                            <textarea class="form-control" id="subject" name="subject" cols="60"
                                                      rows="4" readonly></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>序列号</td>
                                        <td>
                                            <input type="text" class="form-control" id="sn" name="sn" readonly>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>有效期</td>

                                        <td><input type="text" class="form-control" id="date" name="date" readonly>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>证书值</td>
                                        <td>
                                            <textarea class="form-control" id="cert" name="cert" cols="60"
                                                      rows="8" readonly></textarea>
                                            <p class="help-block">Base64编码</p>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel-footer"></div>
            </div>


        </div>

    </div>

    <% } else { %>
    <div class="alert alert-danger">
        <strong>警告：</strong>您还没有登录，或者Session已过期，请重新登录&nbsp;&nbsp;
        <a class="btn btn-primary" href="javascript:void(0)" onclick="showLoginModal();">&nbsp;登 录&nbsp;&gt;&gt;</a>
    </div>
    <% } %>


    <div class="row">
        <div class="col-lg-12">
            <h3>应用接入Spark流程</h3>

            <p><strong>(1)</strong>
                在Spark平台注册一个应用，上传LOGO、填写应用回掉地址等信息，保存该应用的APP_ID和APP_KEY
            </p>

            <p>
                <strong>(2)</strong>
                根据应用开发语言，下载相应版本的【spark-app-sdk】，修改spark-connect-config配置文件，将二者集成到项目工程中
            </p>

            <p>
                <strong>(3)</strong>
                修改原登录页面，可根据需要选择去除或保留原有登录方式，添加统一认证登录链接
            </p>

            <p>
                <strong>(4)</strong>
                实现回调函数，与Spark交互获取用户登录的Token和OpenID，通过OpenAPI获取其他信息，完成身份认证和信息获取后，进入到正常登录逻辑
            </p>

        </div>
    </div>
</div>
<hr>
<jsp:include page="footer.jsp"/>
</body>
</html>
