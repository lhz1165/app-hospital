package com.util.util;

import org.apache.commons.codec.binary.Base64;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * base64工具类
 * @author docker
 * @date 2022-01-27
 */
public class ImageBase64Util {

    public static void main(String[] args) {
        String imageFile= "C:\\Users\\GH\\Pictures\\Camera Roll\\12.png";// 待处理的图片
        System.out.println(getImageString(imageFile));
    }

    public static String getImageString(String imageFile){
        InputStream is = null;
        try {
            byte[] data = null;
            is = new FileInputStream(new File(imageFile));
            data = new byte[is.available()];
            is.read(data);
            return new String(Base64.encodeBase64(data));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != is) {
                try {
                    is.close();
                    is = null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return "";
    }
}
