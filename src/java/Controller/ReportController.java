/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ReportDao;
import EntityDto.ProductStockDto;
import EntityDto.TimeCountDto;
import EntityDto.VariantStockDto;
import EntityDto.RoleCountDto;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author LENOVO
 */
public class ReportController extends HttpServlet {

    private final ReportDao reportDao = new ReportDao();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReportController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Đọc từ/ngày mặc định
            LocalDate to = LocalDate.now();
            LocalDate from = to.minusDays(7);
            // Có thể lấy param period = day/week/month ?
            // Parse date range for time-based reports (default to last 7 days)
            String fromParam = request.getParameter("from");
            String toParam = request.getParameter("to");
            LocalDate toDate = toParam != null ? LocalDate.parse(toParam) : LocalDate.now();
            LocalDate fromDate = fromParam != null ? LocalDate.parse(fromParam) : toDate.minusDays(7);

            // Trends
            List<TimeCountDto> productTrend;
            String period = request.getParameter("period"); // "day","week","month"
            if (period == null) {
                period = "day";
            }
            if ("week".equals(period)) {
                productTrend = reportDao.getProductCountByWeek(from, to);
            } else if ("month".equals(period)) {
                productTrend = reportDao.getProductCountByMonth(from, to);
            } else {
                productTrend = reportDao.getProductCountByDay(from, to);
            }

            // Fetch user registration counts by day
            List<TimeCountDto> userTrend = reportDao.getUserRegistrationsByDay(fromDate, toDate);

            // Fetch user count by role
            List<RoleCountDto> usersByRole = reportDao.getUserCountByRole();

            // Tổng số
            int totalProducts = reportDao.getTotalProducts();
            int totalCustomers = reportDao.getTotalCustomers();

            // 
            List<ProductStockDto> productStocks = reportDao.getAllProductsTotalStock();
            request.setAttribute("productStocks", productStocks);

            // Top 5 tồn kho cao nhất
            List<ProductStockDto> top5Stocks = reportDao.getTop5ProductsByStock();

            // Map từ productId sang danh sách variant tồn kho
            Map<Integer, List<VariantStockDto>> variantStockMap = reportDao.getAllVariantStocksMap();

            // If productId specified, fetch variant stock distribution
            String pidParam = request.getParameter("productId");
            List<VariantStockDto> variantStock = new ArrayList<>();
            if (pidParam != null) {
                try {
                    int productId = Integer.parseInt(pidParam);
                    variantStock = reportDao.getStockByVariant(productId);
                    request.setAttribute("selectedProductId", productId);
                } catch (NumberFormatException ignore) {
                }
            }

            // Set attributes for JSP
            request.setAttribute("productTrend", productTrend);
            request.setAttribute("userTrend", userTrend);
            request.setAttribute("usersByRole", usersByRole);
            request.setAttribute("variantStock", variantStock);
            request.setAttribute("fromDate", fromDate);
            request.setAttribute("toDate", toDate);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("top5Stocks", top5Stocks);
            request.setAttribute("variantStockMap", variantStockMap);
            request.setAttribute("period", period);

            // Forward to report JSP
            request.getRequestDispatcher("/AdminPage/Report.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
