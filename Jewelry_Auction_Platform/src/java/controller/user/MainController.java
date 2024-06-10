/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String PROFILE_CONTROLLER = "ProfileController";
    private static final String PROCESS_VALUATION_CONTROLLER = "ProcessValuationRequest";
    private static final String INSERT_JEWELRY_CONTROLLER = "InsertJewelryController";
    private static final String REQUEST_SHIPMENT_CONTROLLER = "RequestShipmentController";
    private static final String CONFIRM_RECEIPT_CONTROLLER = "ConfirmReceiptController";
    private static final String UPDATE_FINAL_PRICE_CONTROLLER = "UpdateFinalPriceController";
    private static final String APPROVE_FINAL_PRICE_CONTROLLER = "ApproveFinalPriceController";
    private static final String SEND_TO_SELLER_CONTROLLER = "SendToSellerController";
    private static final String CONFIRM_TO_AUCTION_CONTROLLER = "ConfirmToAuctionController";
    private static final String REJECT_TO_AUCTION_CONTROLLER = "RejectToAuctionController";
    private static final String CREATE_AUCTION_CONTROLLER = "CreateAuctionController";

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
            String action = request.getParameter("action");
            String url = "/WEB-INF/jsp/index.jsp";
            switch (action) {
                case "Log in":
                    url = LOGIN_CONTROLLER;
                    break;
                case "Log out":
                    url = LOGOUT_CONTROLLER;
                    break;
                case "Profile":
                    url = PROFILE_CONTROLLER;
                    break;
                case "Sell":
                    url = "/seller/selling.html";
                    break;
                case "ValuationRequest":
                    url = PROCESS_VALUATION_CONTROLLER;
                    break;
                case "Submit":
                    url = INSERT_JEWELRY_CONTROLLER;
                    break;
                case "Request to Ship":
                    url = REQUEST_SHIPMENT_CONTROLLER;
                    break;
                case "Confirm Receipt":
                    url = CONFIRM_RECEIPT_CONTROLLER;
                    break;
                case "Send":
                    url = UPDATE_FINAL_PRICE_CONTROLLER;
                    break;
                case "Approve":
                    url = APPROVE_FINAL_PRICE_CONTROLLER;
                    break;
                case "Send to Seller":
                    url = SEND_TO_SELLER_CONTROLLER;
                    break;
                case "Confirm":
                    url = CONFIRM_TO_AUCTION_CONTROLLER;
                    break;
                case "Reject":
                    url = REJECT_TO_AUCTION_CONTROLLER;
                    break;
                case "Create Auction":
                    url = CREATE_AUCTION_CONTROLLER;
                    break;
                default:
                    break;
            }
            RequestDispatcher dist = request.getRequestDispatcher(url);
            dist.forward(request, response);
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
