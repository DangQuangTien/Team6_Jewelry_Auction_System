/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dao.UserDAOImpl;
import entity.member.Member;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "RegisterToBid", urlPatterns = {"/RegisterToBid"})
public class RegisterToBid extends HttpServlet {
    private static final String ERROR_PAGE = "index.htm";
    private static final String BID_PAGE = "/auctions/detail.jsp?";
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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            UserDAOImpl dao = new UserDAOImpl();
            String userID = (String)session.getAttribute("USERID");
            Member member = dao.getInformation(userID);
            String url = ERROR_PAGE;
            String memberID = member.getMemberID();
            String auctionID = request.getParameter("auctionID");
            String country = request.getParameter("country");
            String state = request.getParameter("state");
            String city = request.getParameter("city");
            String address1 = request.getParameter("address1");
            String address2 = request.getParameter("address2");
            String zipCode = request.getParameter("zipCode");
            String cardNumber = request.getParameter("cardNumber");
            boolean result = dao.insertAddress(country, state, city, address1, address2, zipCode, memberID);
            if (cardNumber != null || (cardNumber != null && result == true)){
                boolean updated = dao.registerToBid(memberID);
                if (updated){
                    member = dao.getInformation(userID);
                    url = request.getContextPath() + BID_PAGE + "auctionID=" + auctionID;
                    session.setAttribute("INF", member);
                }
            }
           response.sendRedirect(url);
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
