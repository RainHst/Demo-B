<%@ page import="cn.unitid.spark.demo.User" %>
<%@ page import="cn.unitid.spark.demo.DemoBSparkConfig" %>
<%--
  Created by IntelliJ IDEA.
  User: Iceberg
  Date: 2015/10/16
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String mode = DemoBSparkConfig.getLoginMode();%>
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="<%=request.getContextPath()%>/" class="navbar-brand">Demo-B</a>
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav">
                <li>
                    <a href="<%=request.getContextPath()%>/init.jsp">初始化设置</a>
                </li>
                <%
                    User user = (User) request.getSession().getAttribute("user");
                    if (user != null && user.getOpenid() != null && !"".equals(user.getOpenid())) {
                %>
                <li>
                    <a href="<%=request.getContextPath()%>/bind.jsp">完善账号</a>
                </li>
                <%
                    }
                %>
                <li>
                    <a href="<%=request.getContextPath()%>/user-list.jsp">用户列表</a>
                </li>

                <li>
                    <a href="<%=request.getContextPath()%>/setup_login_mode.jsp">登录模式设置</a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/key_code.jsp">关键代码对比</a>
                </li>
                <li><a href="<%=request.getContextPath()%>/qrcsign/step1.jsp">二维码扫码签名示例</a></li>
                <li>
                    <a href="#" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        应用消息推送<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                        <li><a href="<%=request.getContextPath()%>/message/push.jsp">点对点模式</a></li>
                        <li><a href="<%=request.getContextPath()%>/message/push2.jsp">发布订阅模式</a></li>
                    </ul>

                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">


                <% if (user != null) { %>
                <li><a href="javascript:void(0)" onclick="logout()">登出</a></li>
                <% } else {

                    if ("3".equals(mode)) {
                %>
                <li><a href="<%=request.getContextPath()%>/account?action=sparkLogin">登录</a></li>
                <%
                } else {
                %>
                <li><a href="javascript:void(0)" onclick="showLoginModal()">登录</a></li>
                <%
                        }
                    }
                %>

                <li>
                    <a href="#" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        重置应用<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                        <li><a href="javascript:void(0)" onclick="showClearModal();">重置用户数据</a></li>
                        <li><a href="javascript:void(0)" onclick="showResetModal();">重置应用配置</a></li>
                    </ul>

                </li>
            </ul>

        </div>
    </div>
</div>
<div class="modal fade" id="login_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 class="modal-title text-center">登录到Demo-B</h3>
            </div>
            <div class="modal-body">
                <% if ("1".equals(mode)) {
                %>
                <form id="_form" class="form-horizontal" action="<%=request.getContextPath()%>/account"
                      method="post">

                    <div class="form-group">
                        <label for="loginUserAccount" class="col-sm-3 control-label">Demo-I 账号</label>

                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="loginUserAccount"
                                   name="loginUserAccount" value=""
                                   placeholder="登录账号">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="loginUserPassword" class="col-sm-3 control-label">口令</label>

                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="loginUserPassword"
                                   name="loginUserPassword" value=""
                                   placeholder="登录口令">
                        </div>
                    </div>
                </form>
                <%}%>
            </div>
            <div class="modal-footer">
                <% if ("1".equals(mode)) {%>
                <a class="pull-right" href="javascript:void(0)" onclick="showRegisterModal()">没有账号？马上注册一个</a><br><br>
                <% }%>
                <button type="button" class="btn btn-success" onclick="sparkLogin('<%=request.getContextPath()%>')">
                    使用Spark账号登录
                </button>
                <% if ("1".equals(mode)) {%>
                <button type="button" class="btn btn-primary" onclick="login()">&nbsp;登 录&nbsp;&gt;&gt;</button>
                <% }%>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="register_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 class="modal-title text-center">注册Demo-B账号</h3>
            </div>
            <div class="modal-body">

                <form id="register_form" class="form-horizontal" action="<%=request.getContextPath()%>/account"
                      method="post">

                    <div class="form-group">
                        <label for="userAccount" class="col-sm-3 control-label">Demo-B 账号</label>

                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="userAccount"
                                   name="userAccount" value=""
                                   placeholder="请输入登录账号">

                            <p class="help-block"><strong>注意：</strong>账号只能是英文字母和数字的组合</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="userPassword" class="col-sm-3 control-label">口令</label>

                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="userPassword"
                                   name="userPassword" value=""
                                   placeholder="请设置登录口令">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">不注册了</button>
                <button type="button" class="btn btn-primary" onclick="register();">&nbsp;注 册&nbsp;&gt;&gt;</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="clear_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 class="modal-title text-center">重置用户数据</h3>
            </div>
            <div class="modal-body">
                重置用户数据将清空所有用户账号信息，您确定重置用户数据吗？
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">再考虑一下
                </button>
                <a class="btn btn-warning"
                   href="<%=request.getContextPath() %>/account?action=clear-user-data">重置用户数据</a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="reset_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 class="modal-title text-center">重置应用配置</h3>
            </div>
            <div class="modal-body">
                重置应用配置将清空应用相关配置，应用将恢复到接入Spark之前的状态，您确定重置应用吗？
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">再考虑一下
                </button>
                <a class="btn btn-warning" href="<%=request.getContextPath() %>/account?action=reset-app">重置应用配置</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function register() {
        var account = $("#userAccount").val();
        var password = $("#userPassword").val();
        doRegister("<%=request.getContextPath()%>", account, password);
    }

    function login() {
        var account = $("#loginUserAccount").val();
        var password = $("#loginUserPassword").val();
        doLogin("<%=request.getContextPath()%>", account, password);
    }

    function logout() {
        if (document.all == null) {
            if (window.crypto) {
                if (window.crypto.logout)  window.crypto.logout();
            } else {
                document.execCommand('ClearAuthenticationCache');
            }
        } else {
            document.execCommand('ClearAuthenticationCache');
        }

        ajaxLoad("<%=request.getContextPath()%>/account?action=logout", {}, function (data) {
            if (data.ret == 1) window.location.href = "<%=request.getContextPath()+"/index.jsp"%>"
        });
    }

</script>
