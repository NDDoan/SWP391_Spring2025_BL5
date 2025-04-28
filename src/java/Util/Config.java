package Util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

public class Config {
    public static String vnp_HashSecret = "NTZH7SWQSML3M1T7XW9LKWZ4RBM1IE6X"; // nhập secret do VNPAY cấp
    public static String vnp_TmnCode = "WJSQOMWX";        // nhập mã TMN do VNPAY cấp
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:8080/Swp391_Spring2025_BL5/payment_return"; 
    public static String vnp_IpnUrl = "http://localhost:8080/Swp391_Spring2025_BL5/payment_ipn";

    // Hàm tạo chuỗi hash HMAC SHA512
    public static String hmacSHA512(String key, String data) throws Exception {
        Mac hmac512 = Mac.getInstance("HmacSHA512");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        hmac512.init(secretKey);
        byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hash = new StringBuilder();
        for (byte b : bytes) {
            hash.append(String.format("%02x", b));
        }
        return hash.toString();
    }

    // Hàm băm tất cả các field theo thứ tự alpha
    public static String hashAllFields(Map<String, String> fields) throws Exception {
        Set<String> fieldNames = new TreeSet<>(fields.keySet());
        StringBuilder sb = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                sb.append(fieldName).append('=').append(fieldValue);
                sb.append('&');
            }
        }
        if (sb.length() > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        return hmacSHA512(vnp_HashSecret, sb.toString());
    }
}
