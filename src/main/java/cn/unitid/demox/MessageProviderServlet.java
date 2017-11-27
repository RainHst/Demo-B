package cn.unitid.demox;

import cn.com.syan.jcee.common.sdk.SparkMessageDigest;
import cn.com.syan.jcee.utils.StringConverter;
import cn.unitid.spark.app.sdk.connect.javabeans.msg.Message;
import cn.unitid.spark.app.sdk.connect.utils.SparkConnectConfig;
import cn.unitid.spark.app.sdk.connect.utils.SubscribeMessageUtil;
import cn.unitid.spark.demo.DemoBSparkConfig;
import cn.unitid.spark.demo.message.MessageEntity;
import cn.unitid.spark.demo.message.MessageProviderService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/9/21
 * @since 1.0
 */
public class MessageProviderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("????????????");
        String action = request.getParameter("action");
        MessageProviderService messageProvider = MessageProviderService.getInstance();

        if (action.equals("remove")) {
            String mid = request.getParameter("id");
            messageProvider.removeMessage(mid);

            request.getSession().setAttribute("messageEntityList", messageProvider.getAllMessage());
            request.getSession().setAttribute("totalCount", messageProvider.getTotalCount() + "");
            RequestDispatcher rd = request.getRequestDispatcher("/message/push2.jsp");
            rd.forward(request, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

        String action = request.getParameter("action");
        MessageProviderService messageProvider = MessageProviderService.getInstance();

        if (action.equals("add")) {
            String type = request.getParameter("messageType");
            Integer count = Integer.parseInt(request.getParameter("messageCount"));
            String url = request.getParameter("messageUrl");

            MessageEntity entity = new MessageEntity();
            entity.setType(type);
            entity.setCount(count);
            entity.setUrl(url);
            messageProvider.addMessage(entity);

            request.getSession().setAttribute("messageEntityList", messageProvider.getAllMessage());
            request.getSession().setAttribute("totalCount", messageProvider.getTotalCount() + "");
            RequestDispatcher rd = request.getRequestDispatcher("/message/push2.jsp");
            rd.forward(request, resp);
        } else if (action.equals("subscribe")) {
            String openID = request.getParameter("openid");
            String vcode = request.getParameter("vcode");

            Map<String, Object> responseMap = new HashMap<String, Object>();

            SubscribeMessageUtil subMess = new SubscribeMessageUtil(DemoBSparkConfig.getAppId(), DemoBSparkConfig.getAppKey());

            SubscribeMessageUtil subscribeMessageUtil = new SubscribeMessageUtil("ID","KEY");

            if (!subMess.verifyVcode(vcode, responseMap)) {
                System.err.println("验证请求者身份失败，非法的请求");
                responseMap.put("ret", -1);
                responseMap.put("msg", "验证请求者身份失败，非法的请求");
            } else {
                //合法身份，根据OpenID查询消息通知，封装返回

                List<Message> messageList = messageProvider.getFormattedMessage();
                int count = messageProvider.getTotalCount();
                responseMap = subMess.buildResponseMessage(messageList, count);
            }

            PrintWriter writer = resp.getWriter();
            try {
                Gson gson = new GsonBuilder().disableHtmlEscaping().create();
                String responseString = gson.toJson(responseMap);
                System.out.println(responseString);
                writer.println(responseString);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                writer.close();
            }
        }
    }

    private String genVcode(Map<String, Object> messageMap) {
        String messageJson = new Gson().toJson(messageMap);
        SparkMessageDigest sparkMessageDigest = null;
        try {
            sparkMessageDigest = SparkMessageDigest.getInstance("1.3.14.3.2.26");
            String data = messageJson + SparkConnectConfig.getValue("app_KEY");
            sparkMessageDigest.update(data.getBytes("utf-8"));
            byte[] digest = sparkMessageDigest.digest();

            return StringConverter.toHexadecimal(digest);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public static void main(String[] args) {

        String u = SparkConnectConfig.getValue("authorize_URL");


        System.out.println(u);
    }
}
