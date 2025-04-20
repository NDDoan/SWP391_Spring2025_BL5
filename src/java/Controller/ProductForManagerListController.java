/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ProductForManagerListDao;
import EntityDto.ProductForManagerListDto;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ProductForManagerListController extends HttpServlet {

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
            // Thiết lập encoding nếu cần
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

            // Đọc các tham số từ request
            String search = request.getParameter("search"); // từ khóa tìm kiếm
            String brand = request.getParameter("brand"); // lọc theo thương hiệu
            String category = request.getParameter("category"); // lọc theo danh mục
            String pageParam = request.getParameter("page");  // số trang
            String sortField = request.getParameter("sortField"); // trường sắp xếp
            String sortDir = request.getParameter("sortDir");  // hướng sắp xếp

            // Nếu không có số trang thì mặc định là trang 1
            int page = 1;
            try {
                if (pageParam != null) {
                    page = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }

            // Nếu không cung cấp tham số sắp xếp thì thiết lập giá trị mặc định.
            if (sortField == null || sortField.trim().isEmpty()) {
                sortField = "p.product_id";
            }
            if (sortDir == null || sortDir.trim().isEmpty()) {
                sortDir = "ASC";
            }

            // Gọi DAO để lấy dữ liệu theo các tham số
            ProductForManagerListDao dao = new ProductForManagerListDao();
            List<ProductForManagerListDto> productList = dao.getProductForMarketingList(search, brand, category, page, sortField, sortDir);

            // Lấy danh sách dropdown filter
            List<String> brandList = dao.getAllBrandNames();
            List<String> categoryList = dao.getAllCategoryNames();

            // Đưa dữ liệu vào request attribute để JSP có thể truy xuất
            request.setAttribute("productList", productList);
            request.setAttribute("brand", brandList);
            request.setAttribute("category", categoryList);
            // Bạn có thể set thêm các attribute khác như dữ liệu phân trang, tham số tìm kiếm, sắp xếp, ... nếu cần

            // Forward tới JSP ManagerPage/ProductList.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPage/ProductList.jsp");
            dispatcher.forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
