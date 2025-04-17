/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ProductMediaDao;
import Entity.ProductMedia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

/**
 *
 * @author LENOVO
 */
public class MediaUploadController extends HttpServlet {

    private final ProductMediaDao mediaDao = new ProductMediaDao();
    // Directory under webapp to save uploaded files
    private final String UPLOAD_DIR = "uploads";

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
            out.println("<title>Servlet MediaUploadController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MediaUploadController at " + request.getContextPath() + "</h1>");
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
        int productId = Integer.parseInt(request.getParameter("productId"));
        String action = request.getParameter("action");
        int mediaId = Integer.parseInt(request.getParameter("mediaId"));

        if ("delete".equals(action)) {
            mediaDao.deleteMedia(mediaId);
        } else if ("setPrimary".equals(action)) {
            mediaDao.setPrimaryMedia(mediaId, productId);
        }
        response.sendRedirect(request.getContextPath()
                + "/ProductForManagerDetailController?productId=" + productId + "&mode=view");
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
        request.setCharacterEncoding("UTF-8");
        int productId = Integer.parseInt(request.getParameter("productId"));
        String mediaType = request.getParameter("mediaType"); // "image" or "video"
        String url = request.getParameter("mediaUrl").trim();
        Part filePart = request.getPart("mediaFile");
        String mediaUrl = url;

        // If a file was uploaded, save it
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String appPath = request.getServletContext().getRealPath("");
            String savePath = appPath + File.separator + UPLOAD_DIR;
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }
            String filePath = savePath + File.separator + fileName;
            filePart.write(filePath);
            mediaUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
        }

        // Normalize YouTube URLs to embed if needed
        if (mediaType.equals("video") && url.contains("youtube.com")) {
            // extract video id
            String id = null;
            if (url.contains("v=")) {
                id = url.split("v=")[1].split("[&]")[0];
            } else if (url.contains("youtu.be/")) {
                id = url.substring(url.lastIndexOf("/") + 1);
            }
            if (id != null) {
                mediaUrl = "https://www.youtube.com/embed/" + id;
            }
        }

        // is_primary checkbox
        boolean isPrimary = request.getParameter("isPrimary") != null;

        // Persist
        ProductMedia pm = new ProductMedia();
        pm.setProductId(productId);
        pm.setMediaType(mediaType);
        pm.setMediaUrl(mediaUrl);
        pm.setPrimary(isPrimary);
        mediaDao.addMedia(pm);

        // Redirect back to detail
        response.sendRedirect(request.getContextPath()
                + "/ProductForManagerDetailController?productId=" + productId + "&mode=view");

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
