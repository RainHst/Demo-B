package cn.unitid.spark.qrsign.sdk;

import java.util.List;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author lyb
 * @version $Revision 16/7/27
 * @since 1.0
 */
public class Item {

    private String type;

    private String name;

    private String value;

    private String label;

    private String text;

    private List<ValueText> options;

    public List<ValueText> getOptions() {
        return options;
    }

    public void setOptions(List<ValueText> options) {
        this.options = options;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
