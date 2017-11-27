package cn.unitid.spark.demo.message;

import cn.unitid.spark.app.sdk.connect.javabeans.msg.Message;

import java.util.*;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/9/21
 * @since 1.0
 */
public class MessageProviderService {

    private static MessageProviderService instance;

    private Map<String, MessageEntity> messageMap = new HashMap<String, MessageEntity>();
    private int totalCount;


    private MessageProviderService() {

    }

    public static MessageProviderService getInstance() {

        if (instance == null) {
            synchronized (MessageProviderService.class) {
                instance = new MessageProviderService();
            }
        }

        return instance;
    }

    public void addMessage(MessageEntity entity) {
        messageMap.put(entity.getId(), entity);
        this.totalCount += entity.getCount();
    }

    public void removeMessage(String id) {
        MessageEntity entity = this.messageMap.get(id);
        if (entity != null) {
            this.totalCount = totalCount - entity.getCount();
        }

        messageMap.remove(id);
    }

    public List<MessageEntity> getAllMessage() {
        List<MessageEntity> entityList = new ArrayList<MessageEntity>();

        for (MessageEntity o : messageMap.values()) {
            entityList.add(o);
        }

        return entityList;
    }

    public List<Message> getFormattedMessage() {
        List<Message> fmList = new ArrayList<Message>();

        Message mess;
        for (MessageEntity m : messageMap.values()) {
            mess = new Message();
            mess.setContent(m.getType() + " " + m.getCount() + " 条", m.getUrl());
            fmList.add(mess);
        }

        return fmList;
    }


    public int getTotalCount() {
        return this.totalCount;
    }

}
