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
                <h1>应用消息推送-点对点模式</h1>
                <p class="lead">1）对已绑定统一认证账号的人员发送全体消息推送通知</p>
                <p class="lead">2）在已绑定统一认证账号的人员中，选择一个或多个发送消息推送通知</p>
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
                    <form id="formMessagePush" name="frm" class="form-horizontal"
                          action="<%=request.getContextPath() %>/messagepush.do?action=push" method="post">

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">消息推送模式</label>
                            <div class="col-sm-6">
                                <label>
                                    <input name="pushMode" type="radio" value="all" checked/> 全体推送&nbsp;&nbsp;&nbsp;&nbsp;
                                </label>

                                <label>
                                    <input name="pushMode" type="radio" value="some"/> 定点推送
                                </label>
                                <p class="help-block">全体推送：消息将推送给所有全体；定点推送：消息将推送到指定的人</p>
                            </div>
                        </div>
                        <div class="form-group hidden" id="id_message_receiver">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">选择推送人</label>
                            <div class="col-sm-8">
                                <table class="table table-striped" id="userList">
                                    <thead>
                                    <tr>
                                        <th>勾选</th>
                                        <th>Demo-B账号</th>
                                        <th>openid</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">消息ID</label>
                            <div class="col-sm-8">
                                <input class="form-control input-large" type="text" placeholder="消息ID"
                                       name="messageID"
                                       value="XX12891119">
                                <p class="help-block">消息的唯一ID</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">消息标题</label>
                            <div class="col-sm-8">
                                <input class="form-control input-large" type="text" placeholder="消息标题"
                                       name="title"
                                       value="国庆放假通知">
                                <p class="help-block">消息标题</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">消息回调地址</label>
                            <div class="col-sm-8">
                                <input class="form-control input-large" type="text" placeholder="消息回调地址"
                                       name="appRedirectPath"
                                       value="http://192.168.10.100:8080/b/messagepush.do?action=show">
                                <p class="help-block">用户在统一认证平台可以点击该地址，跳转回系统中进行查看或者进行业务处理.</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label" for="msg_content">消息内容</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" name="content" id="msg_content" rows="12" cols="6">根据国务院对2015年国庆节的放假通知精神，结合我公司实际情况，现将我公司国庆节放假具体安排通知如下：1、放假时间：放假调休共2天，9月28日(星期日)上班， 10月11日(星期六)上班。10月1日(星期三)至7日(星期二)放假休息，共7天，2、请各位根据自己的工作性质及进度，对节日期间的工作进行计划安排，如需加班请提前将《加班申请书》由领导批示后交前台备案，如需请假请提前将《请假申请书》由领导批示后交前台备案，谢谢大家配合!</textarea>
                                <p class="help-block">消息内容，请简要描述消息内容</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <!-- Text input-->
                            <label class="col-sm-2 control-label">消息发送者</label>
                            <div class="col-sm-8">
                                <input class="form-control input-large" type="text" placeholder="消息发送者"
                                       name="sender"
                                       value="Demo-B管理员">
                                <p class="help-block">消息发送者</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 col-sm-2 control-label"></label>

                            <div class="col-md-7 col-sm-7">
                                <button type="button" class="btn btn-primary" id="btnPushMessage">推送消息通知
                                </button>
                                &nbsp;&nbsp;
                                <button type="button" class="btn btn-danger" id="btnWithdrawMessage">撤回消息通知
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

        $(function () {
            $(':radio[name="pushMode"]').click(function () {
                if ($(this).val() == "some") {
                    $("#id_message_receiver").attr("class", "form-group");
                    showUserList();
                } else {
                    $("#id_message_receiver").attr("class", "hidden");
                }
            });
        });


        function showUserList() {
            ajaxLoad("<%=request.getContextPath()%>/account?action=userlist", {}, function (data) {

                var content = "";
                for (var i = 0; i < data.users.length; i++) {
                    var user = data.users[i].user;
                    content = content + "<tr>";
                    content += "<td><input type='checkbox' name='receivers' value='"+user.openid+"'></td>";
                    content += "<td>" + (user.account == null ? '未设置' : user.account) + "</td><td>" + user.openid + "</td></tr>";
                }
                $("#userList").empty();
                $("#userList").append(content);
            });
        }

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
