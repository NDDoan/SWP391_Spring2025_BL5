/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ProductUserListDao;
import EntityDto.ProductUserListDto;
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
public class ProductUserListController extends HttpServlet {

    private final ProductUserListDao dao = new ProductUserListDao();

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
            out.println("<title>Servlet ProductUserListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductUserListController at " + request.getContextPath() + "</h1>");
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
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        String cpuParam = request.getParameter("cpu");
        String ramParam = request.getParameter("ram");
        String screenParam = request.getParameter("screen");
        String storageParam = request.getParameter("storage");
        String colorParam = request.getParameter("color");

        try {
            // 1) sản phẩm theo filter
            List<ProductUserListDto> products = dao.getProductsSummary(
                    search, category,
                    cpuParam, ramParam,
                    screenParam, storageParam, colorParam
            );
            request.setAttribute("productList", products);

            // 2) danh sách dropdown
            request.setAttribute("brandList", dao.getAllBrands());
            request.setAttribute("categoryList", dao.getAllCategories());
            request.setAttribute("cpuList", dao.getAllCpuOptions());
            request.setAttribute("ramList", dao.getAllRamOptions());
            request.setAttribute("screenList", dao.getAllScreenOptions());
            request.setAttribute("storageList", dao.getAllStorageOptions());
            request.setAttribute("colorList", dao.getAllColorOptions());

            // 3) trả lại giá trị đã chọn
            request.setAttribute("searchTerm", search != null ? search : "");
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedCpu", cpuParam);
            request.setAttribute("selectedRam", ramParam);
            request.setAttribute("selectedScreen", screenParam);
            request.setAttribute("selectedStorage", storageParam);
            request.setAttribute("selectedColor", colorParam);

            request.getRequestDispatcher("/UserPage/ProductUserList.jsp")
                    .forward(request, response);
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
