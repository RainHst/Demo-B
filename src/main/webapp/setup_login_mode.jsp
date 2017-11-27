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
    <title>Demo-B-登录模式设置</title>
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
        function saveMode(){
            var params={ loginMode:$('input:radio[name=loginMode]:checked').val()};
            ajaxLoad("<%=request.getContextPath()%>/account?action=set-mode", params, function(data){
                if(data.ret==1){window.location.href="<%=request.getContextPath()%>/setup_login_mode.jsp";}
            });
        }


    </script>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>Demo-B 登录模式设置</h1>

                <p class="lead">初始化Demo-B，可以设置APP_ID和APP_KEY，以演示DemoX接入到Spark的整个流程</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Demo-B 登录模式设置</h3>
                </div>
                <div class="panel-body">

                    <form id="demox_login_mode_form" class="form-inline" action=""
                          method="post">

                        <div class="form-group col-md-12">
                            <label for="" class="col-md-3 col-sm-3 control-label">Demo-II的登录模式</label>

                            <div class="col-md-9 col-sm-9">
                                <div class="row">
                                    <div class="col-md-1 col-sm-1">
                                        <div class="radio">
                                            <input type="radio" name="loginMode" id="loginMode1" value="1"
                                                <%="1".equals(DemoBSparkConfig.getLoginMode())?"checked":""%>>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-sm-10">
                                        <div class="thumbnail">
                                            <img src="<%=request.getContextPath()%>/img/mode1.png" alt="mode1">

                                            <div class="caption text-center"><strong>混合模式</strong></div>
                                            <p>保留原有登录方式，同时增加【统一认证登录方式】</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1 col-sm-1">
                                        <div class="radio">
                                            <input type="radio" name="loginMode" id="loginMode2"
                                                   value="2" <%="2".equals(DemoBSparkConfig.getLoginMode())?"checked":""%>>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-sm-10">
                                        <div class="thumbnail">
                                            <img src="<%=request.getContextPath()%>/img/mode2.png" alt="mode1">

                                            <div class="caption text-center"><strong>统一认证模式</strong></div>
                                            <p>去掉原有登录方式，只保留【统一认证登录方式】</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-1 col-sm-1">
                                        <div class="radio">
                                            <input type="radio" name="loginMode" id="loginMode3"
                                                   value="3" <%="3".equals(DemoBSparkConfig.getLoginMode())?"checked":""%>>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-sm-10">
                                        <div class="thumbnail">
                                            <img src="<%=request.getContextPath()%>/img/mode3.png" alt="mode1">

                                            <div class="caption text-center"><strong>直接认证模式</strong></div>
                                            <p>去掉登录方式的选择，直接跳转到Spark进行身份认证</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="" class="col-md-3 col-sm-3 control-label"></label>

                            <div class="col-md-9 col-sm-9">
                                <button  type="button" class="btn btn-primary" onclick="saveMode()">保存设置</button>
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
