<%--
  Created by IntelliJ IDEA.
  User: Iceberg
  Date: 2015/10/15
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo-B-关键代码对比</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.min.css">
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/shCoreDefault.css"/>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="<%=request.getContextPath()%>/js/html5shiv.js"></script>
    <script src="<%=request.getContextPath()%>/js/respond.min.js"></script>
    <![endif]-->

    <script src="<%=request.getContextPath()%>/js/jquery-1.10.2.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/demox.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/script/shCore.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/script/shBrushJava.js"></script>
    <script type="text/javascript">SyntaxHighlighter.all();</script>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10 col-md-12 col-sm-12">
                <h1>关键代码对比</h1>

                <p class="lead">展示接入Spark之前的登录代码和接入Spark之后的登录代码，通过对比，深入了解接入流程</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">接入Spark之前，登录逻辑主要代码</h3>
                </div>
                <div class="panel-body">

                    <pre class="brush: java;">

    @RequestMapping("/do_login")
    public String doLogin(ModelMap modelMap, HttpServletRequest request) {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        User user = null;
        try {
            user = this.accountService.login(new UserAccount(account, password));
        } catch (AccountException e) {
            modelMap.put(error, e.getMessage());
            return error;
        }

        request.getSession().setAttribute("demo_user", user);
        modelMap.put(prompt, "登录成功");

        return "redirect:/index";
    }
                    </pre>

                </div>


            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h3 class="panel-title">接入Spark之后，登录逻辑主要代码</h3>
                </div>
                <div class="panel-body">

                    <pre class="brush: java;">
 @RequestMapping(value = "/callback.do")
    public String Callback(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
        System.out.println("enter callback.do....");
        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);
            String accessToken = null;
            String openID = null;
            long tokenExpireIn = 0L;

            if (accessTokenObj.getAccessToken().equals("")) {
                System.out.print("没有获取到响应参数");
                modelMap.put(error, "获取Token失败，没有获取到响应参数");
                return error;
            } else {
                accessToken = accessTokenObj.getAccessToken();
                tokenExpireIn = accessTokenObj.getExpireIn();

                request.getSession().setAttribute("demo_access_token", accessToken);
                request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

                OpenID openIDObj = new OpenID(accessToken);
                openID = openIDObj.getUserOpenID();
                request.getSession().setAttribute("demo_openid", openID);

                UserInfo ui = new UserInfo(accessToken, openID);
                UserInfoBean uib = ui.getUserInfo();

                UserExtension ue = new UserExtension(accessToken, openID);
                UserExtensionBean ueb = ue.getUserExtension();

                if (openID == null) {
                    modelMap.put(error, "获取 Open ID 失败");
                    return error;
                }
                modelMap.put("certinfo", "数字证书:\n" + uib.getCertvalue());

                Object objectUser = request.getSession().getAttribute("demo_user");
                if (objectUser == null) {
                    //TODO 统一认证登录
//                    UserAccount account = new UserAccount();
//                    account.setOpenID(openID);
//                    User user = this.accountService.login(account);
//                    request.getSession().setAttribute("demo_user", user);
                    modelMap.put(prompt, "统一认证登录成功,您的openID:" + openID);

                    User user = null;
                    try {
                        user = this.accountService.loginWithOpenID(openID);
                        request.getSession().setAttribute("demo_user", user);
                    } catch (Exception eee) {
                        //     未绑定过demo账号            显示绑定Demo账号 连接
                        modelMap.put("bindDemoAccount", "showBindLink");
                    }

                    return prompt;
                } else {
                    //TODO：已登录用户绑定Spark账号
                    User user = (User) objectUser;
                    this.accountService.bindOpenID(user.getUserID(), openID);
                    modelMap.put(prompt, "绑定 Open ID 成功");
                    user.setOpenID(openID);
                    request.getSession().setAttribute("demo_user", user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            modelMap.put(error, e.getMessage());
            return error;
        }

        return prompt;
    }
                    </pre>
                </div>


            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">接入Spark之前，用户表结构</h3>
                </div>
                <div class="panel-body">

                    <table class="table table-bordered">
                        <tr>
                            <td colspan="3" align="center">用户表</td>
                        </tr>
                        <tr>
                            <td>主键标识</td> <td>ID</td>  <td>TEXT</td>
                        </tr>
                        <tr>
                            <td>账号名称</td>  <td>username</td>    <td>TEXT</td>
                        </tr>
                        <tr>
                            <td>密码</td>  <td>password</td>      <td>TEXT</td>
                        </tr>
                        <tr>
                            <td>...</td>  <td>...</td>       <td>...</td>
                        </tr>
                    </table>

                </div>


            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h3 class="panel-title">接入Spark之后，用户表需增加openid字段，结构如下</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <td colspan="3" align="center">用户表</td>
                        </tr>
                        <tr>
                            <td>主键标识</td> <td>ID</td>   <td>TEXT</td>
                        </tr>
                        <tr>
                            <td>账号名称</td>  <td>username</td>  <td>TEXT</td>
                        </tr>
                        <tr>
                            <td>密码</td>  <td>password</td> <td>TEXT</td>
                        </tr>
                        <tr>
                            <td><strong>openid</strong> </td>  <td><strong>openid</strong></td>    <td><strong>TEXT</strong></td>
                        </tr>
                        <tr>
                            <td>...</td>  <td>...</td>    <td>...</td>
                        </tr>
                    </table>

                </div>


            </div>
        </div>
    </div>
</div>

<hr>
<jsp:include page="footer.jsp"/>
</body>
</html>
