package cn.unitid.spark.demo;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision 16/7/27
 * @since 1.0
 */
public class BusinessProgressService {

    private static BusinessProgressService instance;

    private Map<String, Object> dataBaseMap = null;


    private BusinessProgressService() {
        this.dataBaseMap = new HashMap<String, Object>();
    }

    public static BusinessProgressService getInstance() {
        if (instance == null) {
            synchronized (BusinessProgressService.class) {
                instance = new BusinessProgressService();
            }
        }

        return instance;
    }

    public void put(String key, Object value) {
        this.dataBaseMap.put(key, value);
    }

    public Object get(String key) {
        return this.dataBaseMap.get(key);
    }

    public void remove(String key) {
        this.dataBaseMap.remove(key);
    }
}
