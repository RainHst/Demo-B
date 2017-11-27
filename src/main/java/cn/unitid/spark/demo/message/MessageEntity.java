package cn.unitid.spark.demo.message;

import java.io.Serializable;
import java.util.UUID;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/9/21
 * @since 1.0
 */
public class MessageEntity implements Serializable {

    private static final long serialVersionUID = 7567995197816640935L;
    private String id;

    private String type;

    private int count;

    private String url;

    public MessageEntity() {
        this.id = UUID.randomUUID().toString();
    }

    public String getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
