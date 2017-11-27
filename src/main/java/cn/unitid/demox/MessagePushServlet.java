package cn.unitid.demox;

import cn.unitid.spark.app.sdk.connect.SparkConnectException;
import cn.unitid.spark.app.sdk.connect.api.msg.MessagePush;
import cn.unitid.spark.app.sdk.connect.javabeans.GeneralResultBean;
import cn.unitid.spark.app.sdk.connect.javabeans.msg.Message;
import com.google.gson.Gson;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/8/10
 * @since 1.0
 */
public class MessagePushServlet extends HttpServlet {
    Logger logger = Logger.getLogger(MessagePushServlet.class);

    private final String CONFIG = "config";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("show".equals(action)) {
            RequestDispatcher rd = request.getRequestDispatcher("/message/show.jsp");
            rd.forward(request, resp);
        }
    }

    /**
     * 消息精确推送及回收
     *
     * @param request
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String action = request.getParameter("action");

        Map<String, Object> responseMap = new HashMap<String, Object>();
        if ("withdraw".equals(action)) {
            MessagePush pusher = new MessagePush();
            String messageID = request.getParameter("messageID");
            try {
                GeneralResultBean result = pusher.withdrawAll(messageID);

                if (result.getRet() == 0) {
                    System.out.println("消息撤销成功");
                    responseMap.put("ret", 1);
                } else {
                    System.out.println("消息撤销失败，错误原因：" + result.getMsg());
                    responseMap.put("ret", -1);
                    responseMap.put("error", result.getMsg());
                }
            } catch (SparkConnectException e) {
                e.printStackTrace();
                responseMap.put("ret", -1);
                responseMap.put("error", "捕获异常：" + e.getMessage());
            }

            resp.setContentType("application/json;charset=utf-8");
            Gson gson = new Gson();
            PrintWriter writer = resp.getWriter();
            writer.write(gson.toJson(responseMap));
            writer.flush();
        } else if ("push".equals(action)) {
            MessagePush pusher = new MessagePush();

            String pushMode = request.getParameter("pushMode");
            String messageID = request.getParameter("messageID");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String appRedirectPath = request.getParameter("appRedirectPath");
            String sender = request.getParameter("sender");

            try {
                GeneralResultBean result = null;
                if (pushMode.equals("some")) {
                    String[] receivers = request.getParameterValues("receivers");
                    List<Message> messageList = new ArrayList<Message>();
                    Message message;
                    for (String openID : receivers) {
                        message = new Message(messageID);
                        message.setTitle(title);
                        message.setContent(content, appRedirectPath);
                        message.setSender(sender);
                        message.setReceiver(openID);

                        messageList.add(message);
                    }

                    result = pusher.push(messageList);
                } else if (pushMode.equals("all")) {
                    Message message = new Message(messageID);
                    message.setTitle(title);
                    message.setContent(content, appRedirectPath);
                    message.setSender(sender);

                    result = pusher.pushAll(message);
                } else {
                    throw new Exception("invalid push mode: " + pushMode);
                }

                if (result.getRet() == 0) {
                    System.out.println("消息推送成功");
                    responseMap.put("ret", 1);
                } else {
                    System.out.println("消息推送失败，错误原因：" + result.getMsg());
                    responseMap.put("ret", -1);
                    responseMap.put("error", result.getMsg());
                }

            } catch (Exception e) {
                e.printStackTrace();
                responseMap.put("ret", -1);
                responseMap.put("error", "捕获异常：" + e.getMessage());
            }

            resp.setContentType("application/json;charset=utf-8");
            Gson gson = new Gson();
            PrintWriter writer = resp.getWriter();
            writer.write(gson.toJson(responseMap));
            writer.flush();
        }


    }

}
