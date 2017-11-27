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
    <title>Demo-B-用户列表</title>
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


        function pageLoad() {
            ajaxLoad("<%=request.getContextPath()%>/account?action=userlist", {}, function (data) {

                var content = "";
                for (var i = 0; i < data.users.length; i++) {
                    var user = data.users[i].user;
                    var dNItems = data.users[i].dNItems;
                    content = content + "<tr><td>" + (user.account == null ? '未设置' : user.account) + "</td><td>" + user.openid + "</td><td>";
                    if (dNItems != null) {
                        content = content + "<a href=\"#\" class=\"btn  btn-small\" data-toggle=\"modal\"  data-target=\"#" + user.id + "_certDetail\">" + data.users[i].sn + "</a>";

                        content = content + "<div id=\"" + user.id + "_certDetail\" class=\"modal fade  bs-example-modal-lg\"   tabindex=\"-1\" role=\"dialog\"  aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">";

                        content = content + "<div class=\"modal-dialog modal-lg\">";
                        content = content + "<div class=\"modal-header\">";
                        content = content + "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>";
                        content = content + "<h3 id=\"myModalLabel\">证书信息</h3></div>";

                        content = content + "<div class=\"modal-body\">";
                        content = content + "<table class=\"table table-bordered\"> ";
                        content = content + "<tbody>  ";
                        content = content + "  <tr> ";
                        content = content + "   <td width=\"60px\">主题项</td> <td> ";

                        for (var n = 0; n < dNItems.length; n++) {
                            content = content + dNItems[n] + "<br>";
                        }

                        content = content + "</td> </tr><tr> <td>序列号</td><td>" + data.users[i].sn + "</td> </tr>" +
                        "<tr><td>有效期</td></td><td>" + data.users[i].date + "</td></tr> </tbody></table>";

                        content = content + "</div>    <div class=\"modal-footer\">";
                        content = content + " <button class=\"btn\" data-dismiss=\"modal\"     aria-hidden=\"true\">关闭 </button></div></div></div>";
                    }
                    content = content + "</td><td></td></tr>";
                }

                $("#userList").append(content);

            });
        }
    </script>
</head>
<body onload="pageLoad();">
<jsp:include page="header.jsp"/>

<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>用户列表</h1>

                <p class="lead">用户列表，openid 与应用账号之间的关联关系</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 table-responsive">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">用户列表</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-striped" id="userList">

                        <thead>
                        <tr>
                            <th>账号</th>
                            <th>openid</th>
                            <th>证书</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>

                    </table>

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
