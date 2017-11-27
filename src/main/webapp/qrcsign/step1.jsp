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

                <p class="lead">Step 1）应用系统业务录入页面，引导用户提交业务数据</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">应用系统业务数据录入</h3>
                </div>
                <div class="panel-body">
                    <form id="frm" name="frm" class="form-horizontal"
                          action="<%=request.getContextPath() %>/qrsign.do?action=apply" method="post">

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">业务名称</label>
                            <div class="col-sm-6">
                                <input class="form-control input-large" type="text" placeholder="业务名称"
                                       name="businessName"
                                       value="申请预支费用">
                                <p class="help-block">请输入业务名称</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">费用金额</label>
                            <div class="col-sm-6">
                                <input class="form-control input-large" type="text" placeholder="费用金额" name="fee"
                                       value="8000">
                                <p class="help-block">请输入费用金额，单位为元</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label" for="id_dept">申请部门</label>
                            <div class="col-sm-6">
                                <select class="form-control" name="department" id="id_dept">
                                    <option value="A001">研发部</option>
                                    <option value="A002">管理部</option>
                                    <option value="A003">销售部</option>
                                </select>

                                <p class="help-block">请选择用户部门</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">费用用途</label>
                            <div class="col-sm-6">
                                <label>
                                    <input name="feeUsage" type="checkbox" value="1" checked/> 会务
                                </label>
                                <label>
                                    <input name="feeUsage" type="checkbox" value="2"/> 活动
                                </label>
                                <label>
                                    <input name="feeUsage" type="checkbox" value="3"/> 餐饮
                                </label>
                                <p class="help-block">请选择费用用途</p>
                            </div>
                        </div>

                        <%--<div class="form-group">--%>
                            <%--<label class="col-sm-2 control-label" for="id_feeBudgetFile">费用预算报表</label>--%>
                            <%--<div class="col-sm-6">--%>
                                <%--<input class="form-control input-large" type="text" name="feeBudgetFile"--%>
                                       <%--id="id_feeBudgetFile"--%>
                                       <%--value=""><br>--%>
                                <%--<input type="hidden" name="md5" id="md5"><br>--%>
                                <%--<input type='file' id='file' name='file' onchange='app_logo_file_change(this)'/>--%>
                                <%--<p class="help-block">请选择文件</p>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">签名模式</label>
                            <div class="col-sm-6">
                                <label>
                                    <input name="signatureMode" type="radio" value="p1" checked/> PKCS1
                                </label>

                                <label>
                                    <input name="signatureMode" type="radio" value="p7"/> PKCS7
                                </label>
                                <p class="help-block">签名模式，可由应用系统指定</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label"></label>

                            <div class="col-md-7 col-sm-7">
                                <button type="submit" class="btn btn-primary">提交申请</button>
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
