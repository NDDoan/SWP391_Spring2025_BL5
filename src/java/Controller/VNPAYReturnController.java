package Controller;

import Util.Config;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "VNPAYReturnController", urlPatterns = {"/payment_return"})
public class VNPAYReturnController extends HttpServlet {

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

            response.setContentType("text/html;charset=UTF-8");
            if (signValue.equals(vnp_SecureHash)) {
                if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                    response.getWriter().print("Giao dịch thành công!");
                } else {
                    response.getWriter().print("Giao dịch thất bại!");
                }
            } else {
                response.getWriter().print("Chữ ký không hợp lệ!");
            }
        } catch (Exception e) {
            response.getWriter().print("Có lỗi xảy ra!");
        }
    }
}
