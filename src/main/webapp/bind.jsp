<!DOCTYPE html>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

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
    <title>Demo-B-完善账号信息</title>
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
        function saveAccount() {
            var params = {account: $("#account").val(), password: $("#password").val()};
            ajaxLoad("<%=request.getContextPath()%>/account?action=saveAccount", params, function (data) {
                alert(data.msg);
            });
        }

        function bindPageLoad() {

            ajaxLoad("<%=request.getContextPath()%>/account?action=bind", {}, function (data) {

                $("#account").val(data.user.account);
                $("#password").val(data.user.password);

            });
        }

    </script>
</head>
<body onload="bindPageLoad();">
<jsp:include page="header.jsp"/>


<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>完善账号信息</h1>

                <p class="lead">完善账号信息</p>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">用户账号信息</h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" id="bind" name="bind" action="<%=request.getContextPath() %>/bind.jsp"
                          method="post">

                        <div class="alert alert-success">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <strong>提示：</strong>使openid与应用系统账号名关联
                        </div>

                        <div class="form-group" id="control-group-password">
                            <label class="col-md-2 col-sm-2  control-label" for="password">账号名称</label>

                            <div class="col-md-8 col-sm-8">
                                <input type="text" class="form-control" id="account" name="account"
                                       placeholder=" 电子邮箱 / 用户名 "
                                />

                                <p id="span_account" class=" help-inline">账号只能包含英文、下划线、数字</p>

                                <p class="text-warning">推荐使用电子邮箱注册</p>
                            </div>
                        </div>

                        <div class="form-group" id="control-group-confirm_password">
                            <label class="col-md-2 col-sm-2  control-label" for="password">登录口令</label>

                            <div class="col-md-8 col-sm-8">
                                <input type="password" class="form-control" id="password" name="password"/>

                                <p id="span_password" class="help-inline"></p>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-md-2 col-sm-2  control-label" for="">&nbsp;</label>

                            <div class="col-md-8 col-sm-8">
                                <button class="btn btn-primary btn-large" type="button" onclick="saveAccount()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;完善Demo账号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
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
<hr>
<jsp:include page="footer.jsp"/>
<hr>

</body>
</html>