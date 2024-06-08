/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dao.UserDAOImpl;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author T14
 */
@WebServlet(name = "CreateBidRequestController", urlPatterns = {"/CreateBidRequestController"})
public class BidRegisterRequestController extends HttpServlet {

    private static final String ERROR_PAGE = "/WEB-INF/jsp/index.jsp";
    private static final String USER_PAGE = "auctions/registerBid.jsp";

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR_PAGE;
            try {
                List items = null;
                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();
                //get Parameter
                HttpSession session = request.getSession();
                
                //sessionID where?
                String firstName = (String) params.get("firstName");
                String lastName = (String) params.get("lastName");
                String phoneNumber = (String) params.get("phone");
                Double bidAmount_Current = (Double) params.get("bidAmount_Current");
                LocalDateTime bidAmount_Time = LocalDateTime.now();

                String country = (String) params.get("country");
                String address = (String) params.get("address");
                String city = (String) params.get("city");
                String state = (String) params.get("state");
                String zipCode = (String) params.get("zip");

                String username = (String) session.getAttribute("USERNAME");
                UserDAOImpl dao = new UserDAOImpl();
                try {
                    if (username != null) {
                        boolean result = dao.createBidRegistry(firstName, lastName, phoneNumber, bidAmount_Current, bidAmount_Time, country, address, city, state, zipCode);
                        if (result) {
                            url = USER_PAGE;
                        }
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                RequestDispatcher dist = request.getRequestDispatcher(url);
                dist.forward(request, response);
            }
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
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(BidRegisterRequestController.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(BidRegisterRequestController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
