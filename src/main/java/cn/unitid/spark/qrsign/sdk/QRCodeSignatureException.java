/*
 * Project: Spark_SDK4J 
 * 
 * @(#)SparkConnetException.java   13-11-11 上午10:52
 *
 * Copyright 2013 Jiangsu Syan Technology Co.,Ltd. All rights reserved.
 * Jiangsu Syan PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package cn.unitid.spark.qrsign.sdk;


/**
 * <p>
 * This class provides...
 * </p>
 *
 * @author Iceberg
 * @version $Revision $Date:13-11-11上午10:52
 * @since 1.0
 */
public class QRCodeSignatureException extends Exception {
    private int statusCode = -1;
    private static final long serialVersionUID = -2623309261327598087L;

    public QRCodeSignatureException(String msg) {
        super(msg);
    }

    public QRCodeSignatureException(Exception cause) {
        super(cause);
    }

    public QRCodeSignatureException(String msg, int statusCode) {
        super(msg);
        this.statusCode = statusCode;
    }

    public QRCodeSignatureException(String msg, Exception cause) {
        super(msg, cause);
    }

    public QRCodeSignatureException(String msg, Exception cause, int statusCode) {
        super(msg, cause);
        this.statusCode = statusCode;
    }

    public int getStatusCode() {
        return this.statusCode;
    }
}
