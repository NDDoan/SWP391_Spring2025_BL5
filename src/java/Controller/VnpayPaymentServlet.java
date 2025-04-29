/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author nguye
 */
@WebServlet("/vnpay-payment")
public class VnpayPaymentServlet extends HttpServlet {

    private final String vnp_Version = "2.1.0";
    private final String vnp_Command = "pay";
    private final String vnp_TmnCode = "YOUR_TMN_CODE"; // lấy từ VNPay
    private final String vnp_HashSecret = "YOUR_SECRET"; // lấy từ VNPay
    private final String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private final String vnp_ReturnUrl = "http://localhost:8080/your-app/vnpay-return";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long amount = (long) (Double.parseDouble(req.getParameter("amount")) * 100); // Nhân 100 theo yêu cầu của VNPay
        String orderInfo = "Thanh toan don hang #" + System.currentTimeMillis();
        String txnRef = UUID.randomUUID().toString().replace("-","").substring(0, 10); // Mã giao dịch

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", txnRef);
        vnp_Params.put("vnp_OrderInfo", orderInfo);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", req.getRemoteAddr());
        vnp_Params.put("vnp_CreateDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

        // Sắp xếp và ký
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String fieldName : fieldNames) {
            String value = vnp_Params.get(fieldName);
            if ((value != null) && (value.length() > 0)) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(value, StandardCharsets.US_ASCII)).append('&');
                query.append(fieldName).append('=').append(URLEncoder.encode(value, StandardCharsets.US_ASCII)).append('&');
            }
        }

        hashData.deleteCharAt(hashData.length() - 1); // remove last &
        query.deleteCharAt(query.length() - 1);

        String secureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        String paymentUrl = vnp_Url + "?" + query.toString();
        resp.sendRedirect(paymentUrl);
    }

    private String hmacSHA512(String key, String data) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            Mac mac = Mac.getInstance("HmacSHA512");
            mac.init(secretKey);
            byte[] hmacBytes = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hmacBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tạo chữ ký: " + e.getMessage());
        }
    }
    @Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // Xử lý kết quả thanh toán từ VNPay tại đây
    // Ví dụ: đọc các tham số như vnp_Amount, vnp_ResponseCode, vnp_TransactionStatus,...

    String vnp_Amount = req.getParameter("vnp_Amount");
    String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
    String vnp_TxnRef = req.getParameter("vnp_TxnRef");
    String vnp_TransactionStatus = req.getParameter("vnp_TransactionStatus");

    // Hiển thị thông tin thanh toán
    resp.setContentType("text/html;charset=UTF-8");
    PrintWriter out = resp.getWriter();
    out.println("<h2>Kết quả thanh toán</h2>");
    out.println("<p>Mã giao dịch: " + vnp_TxnRef + "</p>");
    out.println("<p>Số tiền: " + vnp_Amount + "</p>");
    out.println("<p>Trạng thái: " + ("00".equals(vnp_ResponseCode) ? "Thành công" : "Thất bại") + "</p>");
}

}
