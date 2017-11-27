/*
 * Project: Spark_SDK4J 
 * 
 * @(#)RandomStatusGenerator.java   13-11-11 上午10:30
 *
 * Copyright 2013 Jiangsu Syan Technology Co.,Ltd. All rights reserved.
 * Jiangsu Syan PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package cn.unitid.spark.qrsign.sdk;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision $Date:13-11-11上午10:30
 * @since 1.0
 */
public class RandomStatusGenerator {

    private static String valueBeforeMD5 = "";
    private static String valueAfterMD5 = "";
    private static Random myRand;
    private static SecureRandom mySecureRand = new SecureRandom();
    private static String s_id;
    private static final int PAD_BELOW = 16;
    private static final int TWO_BYTES = 255;

    public RandomStatusGenerator() {
    }

    public RandomStatusGenerator(boolean secure) {
    }

    public static String getRandomNumber() {

//        Random random = new Random(System.currentTimeMillis());

        return "" + (100000 + myRand.nextInt(899999));
    }


    public static String getUniqueState() {
        if (valueAfterMD5.equals("")) {
            getRandomGUID(false);
        }
        return valueAfterMD5;
    }

    private static void getRandomGUID(boolean secure) {
        MessageDigest md5 = null;
        StringBuffer sbValueBeforeMD5 = new StringBuffer(128);
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
        }
        try {
            long time = System.currentTimeMillis();
            long rand = 0L;

            if (secure)
                rand = mySecureRand.nextLong();
            else {
                rand = myRand.nextLong();
            }
            sbValueBeforeMD5.append(s_id);
            sbValueBeforeMD5.append(":");
            sbValueBeforeMD5.append(Long.toString(time));
            sbValueBeforeMD5.append(":");
            sbValueBeforeMD5.append(Long.toString(rand));

            valueBeforeMD5 = sbValueBeforeMD5.toString();
            md5.update(valueBeforeMD5.getBytes());

            byte[] array = md5.digest();
            StringBuffer sb = new StringBuffer(32);
            for (int j = 0; j < array.length; j++) {
                int b = array[j] & 0xFF;
                if (b < 16)
                    sb.append('0');
                sb.append(Integer.toHexString(b));
            }

            valueAfterMD5 = sb.toString();
        } catch (Exception e) {
        }
    }

    public String toString() {
        String raw = valueAfterMD5.toUpperCase();
        StringBuffer sb = new StringBuffer(64);
        sb.append(raw.substring(0, 8));
        sb.append("-");
        sb.append(raw.substring(8, 12));
        sb.append("-");
        sb.append(raw.substring(12, 16));
        sb.append("-");
        sb.append(raw.substring(16, 20));
        sb.append("-");
        sb.append(raw.substring(20));

        return sb.toString();
    }

    static {
        long secureInitializer = mySecureRand.nextLong();
        myRand = new Random(secureInitializer);
        try {
            s_id = InetAddress.getLocalHost().toString();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] ars) {
        for (int i = 0; i < 100; i++) {
            String x = RandomStatusGenerator.getRandomNumber();
            System.out.println(x);
        }
    }

}
