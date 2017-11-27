package cn.unitid.demox;

import cn.com.syan.jcee.common.sdk.utils.CertificateConverter;
import cn.com.syan.jcee.common.sdk.utils.CertificateStandardizedUtil;
import cn.unitid.spark.app.sdk.connect.SparkConnectException;
import cn.unitid.spark.app.sdk.connect.api.OpenID;
import cn.unitid.spark.app.sdk.connect.api.auth.UserExtension;
import cn.unitid.spark.app.sdk.connect.api.auth.UserInfo;
import cn.unitid.spark.app.sdk.connect.javabeans.AccessToken;
import cn.unitid.spark.app.sdk.connect.javabeans.auth.ExtensionOIDBean;
import cn.unitid.spark.app.sdk.connect.javabeans.auth.UserExtensionBean;
import cn.unitid.spark.app.sdk.connect.javabeans.auth.UserInfoBean;
import cn.unitid.spark.app.sdk.connect.oauth.Oauth;
import cn.unitid.spark.app.sdk.connect.utils.SparkConnectConfig;


import cn.unitid.spark.demo.DataUtil;
import cn.unitid.spark.demo.DemoBSparkConfig;
import cn.unitid.spark.demo.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg on $Date:2015/10/16 15:38
 * @version $Revision $Date:2015/10/16 15:38
 * @since 1.0
 */
public class AccountServlet extends HttpServlet {
    Logger _logger = Logger.getLogger("Demo-B-AccountServlet");
    private final String REGISTER = "register";
    private final String LOGIN = "login";

    private final String CONFIG = "config";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("sparkLogin".equals(action)) {
            SparkConnectConfig.updateProperties("authorize_URL", DemoBSparkConfig.getValue("oauth_base_URL") + "/oauth/authorize");
            SparkConnectConfig.updateProperties("access_token_URL", DemoBSparkConfig.getValue("oauth_base_URL") + "/oauth/token");
            SparkConnectConfig.updateProperties("get_openID_URL", DemoBSparkConfig.getValue("oauth_base_URL") + "/oauth/me");
            SparkConnectConfig.updateProperties("oauth_base_URL", DemoBSparkConfig.getValue("oauth_base_URL"));
            SparkConnectConfig.updateProperties("openapi_base_URL", DemoBSparkConfig.getValue("openapi_base_URL"));
            SparkConnectConfig.updateProperties("get_user_info_URL", DemoBSparkConfig.getValue("openapi_base_URL") + "/user/get_user_info");
            SparkConnectConfig.updateProperties("get_user_extension", DemoBSparkConfig.getValue("openapi_base_URL") + "/user/get_user_extension");

            SparkConnectConfig.updateProperties("app_ID", DemoBSparkConfig.getAppId());
            SparkConnectConfig.updateProperties("redirect_URI", DemoBSparkConfig.getValue("redirect_URI"));
            String authUrl = null;
            try {
                authUrl = new Oauth().getAuthorizeURL(request);
            } catch (SparkConnectException e) {
                e.printStackTrace();
            }
            _logger.info("spark_login>>" + authUrl);
            System.out.print("spark_login>>" + authUrl);
            resp.sendRedirect(authUrl);
        }

        if ("callback".equals(action)) {
            try {

                Oauth oauth = new Oauth();

                AccessToken accessTokenObj = oauth.getAccessTokenByRequest(request);
                String accessToken = null;
                String openID = null;

                if (accessTokenObj.getAccessToken().equals("")) {
                    System.out.println("没有获取到响应参数");
                    _logger.error("没有获取到响应参数");
                    RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
                    rd.forward(request, resp);
                } else {
                    accessToken = accessTokenObj.getAccessToken();
                    _logger.info("accessToken :" + accessToken);
                    request.getSession().setAttribute("demo_access_token", accessToken);

                    OpenID openIDObj = new OpenID(accessToken);
                    openID = openIDObj.getUserOpenID();
                    _logger.info("openID :" + openID);

                    UserInfo ui = new UserInfo(accessToken, openID);

                    UserInfoBean uib = ui.getUserInfo();
                    System.out.println(SparkConnectConfig.getValue("get_user_info_URL"));
                    _logger.info("spark id :" + uib.getSparkID());
                    _logger.info("certificate :" + uib.getCertvalue());

                    UserExtension ue = new UserExtension(accessToken, openID);
                    UserExtensionBean ueb = ue.getUserExtension();
                    List<ExtensionOIDBean> lst = ueb.getExtensionOIDBeans();
                    User user = DataUtil.getUserByOpenId(openID);
                    if (user == null) {
                        user = new User();
                        user.setName(uib.getNickName());
                        user.setOidList(lst);
                        user.setId(UUID.randomUUID().toString());
                        user.setOpenid(openID);
                    }
                    user.setCertificate(uib.getCertvalue());
                    System.out.println("getCertvalue" + uib.getCertvalue());
                    GsonBuilder gb = new GsonBuilder();
                    gb.disableHtmlEscaping();
                    DataUtil.put(user.getId(), gb.create().toJson(user));
                    request.getSession().setAttribute("user", user);

                    RequestDispatcher rd;

                    //这里需要判断oauth.getAppRedirectPath(),如果不为null，则应该跳转到该链接
                    if (oauth.getAppRedirectPath() == null) {
                        rd = request.getRequestDispatcher("/index.jsp");
                        rd.forward(request, resp);
                    } else {
                        resp.sendRedirect(oauth.getAppRedirectPath());
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                _logger.error(e.getMessage(), e);
                RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
                rd.forward(request, resp);
            }
        }


        if ("clear-user-data".equals(action)) {
            try {
                request.getSession().removeAttribute("user");
                DataUtil.clear();
                resp.sendRedirect(request.getContextPath() + "/user-list.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if ("reset-app".equals(action)) {
            try {
                request.getSession().removeAttribute("user");
                DemoBSparkConfig.clear();
                resp.sendRedirect(request.getContextPath() + "/init.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

        Map<String, Object> responseMap = new HashMap<String, Object>();

        String action = request.getParameter("action");

        if (CONFIG.equals(action)) {
            String appId = request.getParameter("appID");
            String appKey = request.getParameter("appKey");
            String oauthUrl = request.getParameter("url");
            if (appId != null && !"".equals(appId)) {
                DemoBSparkConfig.setAppId(appId);
                DemoBSparkConfig.setAppKey(appKey);
                DemoBSparkConfig.setOauthBaseUrl(oauthUrl);
                String callback = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/account?action=callback";
                DemoBSparkConfig.setCallBackUrl(callback);

                DemoBSparkConfig.store();
                System.out.println(SparkConnectConfig.getValue("oauth_base_URL"));
                resp.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }

        if (LOGIN.equals(action)) {
            String userAccount = request.getParameter("userAccount");
            String userPassword = request.getParameter("userPassword");
            System.out.println("userAccount" + userAccount);
            responseMap.put("ret", -1);

            for (User u : DataUtil.getUserList()) {
                if (userAccount.equals(u.getAccount())) {
                    if (userPassword.equals(u.getPassword())) {
                        responseMap.put("ret", 1);
                        request.getSession().setAttribute("user", u);
                    } else {
                        responseMap.put("ret", 0);
                        responseMap.put("msg", "密码输入错误！");
                    }
                }
            }

            System.out.println(responseMap);
        }

        if (REGISTER.equals(action)) {

            String userAccount = request.getParameter("userAccount");
            String userPassword = request.getParameter("userPassword");

            if (userAccount != null && !"".equals(userAccount)) {
                boolean exists = false;
                for (User u : DataUtil.getUserList()) {
                    if (userAccount.equals(u.getAccount())) {
                        responseMap.put("error", "账号已注册！");
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    User u = new User();
                    u.setId(UUID.randomUUID().toString());
                    u.setAccount(userAccount);
                    u.setPassword(userPassword);
                    u.setOpenid("");
                    Gson gson = new Gson();
                    DataUtil.put(userAccount, gson.toJson(u));
                    responseMap.put("ret", 1);
                } else {
                    responseMap.put("error", "账号 " + userAccount + "已经被使用，请换其他账号尝试");
                }
            }


        }


        if ("bind".equals(action)) {

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            User user = (User) request.getSession().getAttribute("user");
            responseMap.put("user", user);
            if (user != null) {

                if (user.getCertificate() != null) {
                    try {
                        String subject = CertificateStandardizedUtil.getSubject(user.getCertificate());
                        responseMap.put("subject", subject);
                        X509Certificate certificate = CertificateConverter.fromBase64(user.getCertificate());
                        String sym = "__@@##@@__";
                        String icn = "\\,";
                        String tempDN = subject.replace(icn, sym);
                        String[] dNItems = tempDN.split(",");
                        for (int i = 0; i < dNItems.length; i++) {
                            dNItems[i] = dNItems[i].replace(sym, icn);
                        }
                        responseMap.put("dNItems", dNItems);
                        responseMap.put("sn", certificate.getSerialNumber().toString(16).toUpperCase());
                        responseMap.put("date", sdf.format(certificate.getNotBefore()) + " - " + sdf.format(certificate.getNotAfter()));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    responseMap.put("loginType", "");
                }


            }

        }

        if ("saveAccount".equals(action)) {
            String userAccount = request.getParameter("account");
            String userPassword = request.getParameter("password");
            List<User> userList = DataUtil.getUserList();

            if (userAccount != null && !"".equals(userAccount)) {
                for (User u : userList) {
                    if (userAccount.equals(u.getAccount())) {
                        responseMap.put("msg", "账号已经存在");
                    } else {
                        User user = (User) request.getSession().getAttribute("user");

                        if (user == null) {
                            responseMap.put("msg", "请重新登录");
                        } else {
                            user.setAccount(userAccount);
                            user.setPassword(userPassword);
                            GsonBuilder gb = new GsonBuilder();
                            gb.disableHtmlEscaping();
                            DataUtil.put(user.getId(), gb.create().toJson(user));
                            responseMap.put("msg", "保存成功");
                        }

                    }
                }
            } else {
                responseMap.put("msg", "账号不能为空");
            }

        }

        if ("logout".equals(action)) {
            request.getSession().removeAttribute("user");
            responseMap.put("ret", 1);
        }

        if ("userlist".equals(action)) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                List<User> userList = DataUtil.getUserList();
                List<HashMap> umList = new ArrayList<HashMap>();
                for (User user : userList) {
                    HashMap v = new HashMap();
                    if (user.getCertificate() != null) {
                        String subject = CertificateStandardizedUtil.getSubject(user.getCertificate());
                        responseMap.put("subject", subject);
                        X509Certificate certificate = CertificateConverter.fromBase64(user.getCertificate());
                        String sym = "__@@##@@__";
                        String icn = "\\,";
                        String tempDN = subject.replace(icn, sym);
                        String[] dNItems = tempDN.split(",");
                        for (int i = 0; i < dNItems.length; i++) {
                            dNItems[i] = dNItems[i].replace(sym, icn);
                        }


                        v.put("dNItems", dNItems);
                        v.put("sn", certificate.getSerialNumber().toString(16).toUpperCase());
                        v.put("date", sdf.format(certificate.getNotBefore()) + " - " + sdf.format(certificate.getNotAfter()));

                    }
                    v.put("user", user);
                    umList.add(v);
                }

                responseMap.put("users", umList);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if ("set-mode".equals(action)) {
            String mode = request.getParameter("loginMode");
            System.out.println("mode" + mode);
            DemoBSparkConfig.setLoginMode(mode);
            DemoBSparkConfig.store();
            responseMap.put("ret", 1);
        }


        resp.setContentType("application/json;charset=utf-8");

        Gson gson = new Gson();
        PrintWriter writer = resp.getWriter();
        writer.write(gson.toJson(responseMap));
        writer.flush();
        writer.close();
    }
}