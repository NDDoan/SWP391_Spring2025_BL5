package Controller;

import Util.Config;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "VNPAYIPNController", urlPatterns = {"/payment_ipn"})
public class VNPAYIPNController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
                String fieldName = params.nextElement();
                String fieldValue = request.getParameter(fieldName);
                if (fieldValue != null && fieldValue.length() > 0) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");
            fields.remove("vnp_SecureHash");

            String signValue = Config.hashAllFields(fields);

            response.setContentType("application/json");
            if (signValue.equals(vnp_SecureHash)) {
                boolean checkOrderId = true; // check order tồn tại
                boolean checkAmount = true; // check đúng số tiền
                boolean checkOrderStatus = true; // check trạng thái pending

                if (checkOrderId) {
                    if (checkAmount) {
                        if (checkOrderStatus) {
                            if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                                // Update trạng thái đơn hàng thành thành công
                                response.getWriter().print("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
                            } else {
                                // Update trạng thái đơn hàng thành thất bại
                                response.getWriter().print("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
                            }
                        } else {
                            response.getWriter().print("{\"RspCode\":\"02\",\"Message\":\"Order already confirmed\"}");
                        }
                    } else {
                        response.getWriter().print("{\"RspCode\":\"04\",\"Message\":\"Invalid Amount\"}");
                    }
                } else {
                    response.getWriter().print("{\"RspCode\":\"01\",\"Message\":\"Order not Found\"}");
                }
            } else {
                response.getWriter().print("{\"RspCode\":\"97\",\"Message\":\"Invalid Checksum\"}");
            }
        } catch (Exception e) {
            response.getWriter().print("{\"RspCode\":\"99\",\"Message\":\"Unknown error\"}");
        }
    }
}
