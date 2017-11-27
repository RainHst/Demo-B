<%@ page import="cn.unitid.spark.demo.DemoBSparkConfig" %>
<%@ page import="cn.unitid.spark.demo.message.MessageEntity" %>
<%@ page import="java.util.List" %>
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
                <h1>应用消息推送-发布订阅模式</h1>
                <p class="lead">1）本页面模拟应用系统根据 Open ID 动态查询出待办事项/通知等数据</p>
                <p class="lead">2）在 MessageProviderServlet 中，对统一认证平台提供消息通知查询服务</p>
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
                    <%
                        Object messageObj = request.getSession().getAttribute("messageEntityList");
                        if (messageObj != null) {
                            int totalCount = Integer.parseInt((String) request.getSession().getAttribute("totalCount"));
                    %>
                    <table class="table table-striped" id="">
                        <thead>
                        <tr>
                            <th>类型</th>
                            <th>数量(合计 <%=totalCount%>)</th>
                            <th>url</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<MessageEntity> messageEntityList = (List<MessageEntity>) messageObj;
                            for (MessageEntity m : messageEntityList) {
                        %>
                        <tr>
                            <td><%=m.getType()%>
                            </td>
                            <td><%=m.getCount()%>
                            </td>
                            <td><%=m.getUrl()%>
                            </td>
                            <td>
                                <a href="<%=request.getContextPath() %>/messageservice.do?action=remove&id=<%=m.getId()%>">delete</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <%
                        }
                    %>

                    <hr>

                    <form id="formMessagePush" name="frm" class="form-horizontal" role="form"
                          action="<%=request.getContextPath() %>/messageservice.do?action=add" method="post">

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label" for="id_mt">消息类型</label>
                            <div class="col-sm-6">
                                <input id="id_mt" class="form-control" name="messageType" type="text" placeholder="待办事项"
                                       value=""/>
                            </div>
                        </div>

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label" for="id_mc">条数</label>
                            <div class="col-sm-6">
                                <input id="id_mc" class="form-control" name="messageCount" type="text" placeholder="10"
                                       value="10"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label" for="id_url">直达URL</label>
                            <div class="col-sm-6">
                                <input id="id_url" class="form-control" name="messageUrl" type="text"
                                       value="http://localhost:8080/b"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label"></label>

                            <div class="col-md-7 col-sm-7">
                                <button type="submit" class="btn btn-primary" id="btnAddMessage">添加
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel-footer"></div>
            </div>
        </div>
    </div>
    <script type="text/javascript">


        $(document).ready(function () {
            var options = {
                type: 'POST',
                dataType: 'json',
                success: showResult,
                error: function (err) {
                    alert("error:" + err.msg);
                }
            };

            var withdrawOptions = {
                type: 'POST',
                url: '<%=request.getContextPath()%>/messagepush.do?action=withdraw',
                dataType: 'json',
                success: showResult,
                error: function (err) {
                    alert("error:" + err.msg);
                }
            };

            //$('#formMessagePush').ajaxForm(options);

            $("#btnPushMessage").click(function () {
                $('#formMessagePush').ajaxSubmit(options);
                return false;
            });

            $("#btnWithdrawMessage").click(function () {
                //$('#formMessagePush').ajaxForm(withdrawOptions);
                $('#formMessagePush').ajaxSubmit(withdrawOptions);
                return false;
            });
        });

        function showResult(data, statusText) {
            if (data.ret == 1) {
                alert("消息操作成功");
            } else {
                alert("消息操作失败，错误原因：" + data.error);
            }
        }

    </script>
    <hr>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
