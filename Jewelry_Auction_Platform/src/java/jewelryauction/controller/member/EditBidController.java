/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package jewelryauction.controller.member;

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
@WebServlet(name = "EditBidController", urlPatterns = {"/editbid"})
public class EditBidController extends HttpServlet {

    private static final String ERROR_PAGE = "index.htm";
    private static final String AUCTION_PAGE = "auction?auctionID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            UserDAOImpl dao = new UserDAOImpl();
            String url = ERROR_PAGE;
            try {
                Member member = (Member) session.getAttribute("MEMBER");
                if (member != null) {
                    String preBidAmount = request.getParameter("preBid_Amount");
                    String auctionID = request.getParameter("auctionID");
                    String jewelryID = request.getParameter("jewelryID");

                    if (preBidAmount != null && auctionID != null && jewelryID != null) {
                        try {
                            boolean check = dao.editBid(preBidAmount, jewelryID, member.getMemberID());
                            if (!check) {
                                String message = "PLEASE PLACE BID FIRST!";
                                request.setAttribute("PLACEDBIDSTATUS", message);
                            } else {
                                String message = "UPDATE BID SUCCESSFULLY!";
                                request.setAttribute("PLACEDBIDSTATUS", message);
                            }
                            url = AUCTION_PAGE + auctionID;
                        } catch (Exception ex) {
                            ex.printStackTrace(); // Proper logging should be implemented
                        }
                    } else {
                        System.err.println("Invalid parameters received in request.");
                    }
                } else {
                    System.err.println("Member information not found");
                }
            } catch (Exception ex) {
                ex.printStackTrace(); // Proper logging should be implemented
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
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
