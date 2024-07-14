package jewelryauction.controller.web.auction;

import dao.UserDAOImpl;
import entity.member.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

@WebServlet(name = "RegisterToBid", urlPatterns = {"/registerbid"})
public class RegisterToBid extends HttpServlet {

    private static final String ERROR_PAGE = "index.htm";
    private static final String BID_PAGE = "/home";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
//            HttpSession session = request.getSession();
//            String userID = (String) session.getAttribute("USERID");
//            UserDAOImpl dao = new UserDAOImpl();
//            String auctionID = request.getParameter("auctionID");
//            request.setAttribute("AUCTIONID", auctionID);
//            Member member = dao.getInformation(userID);
//            request.setAttribute("INF", member);
            request.getRequestDispatcher("/auctions/registerBid.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAOImpl dao = new UserDAOImpl();
        String userID = (String) session.getAttribute("USERID");
        String url = ERROR_PAGE;

        try {
            Member member = dao.getInformation(userID);
            request.setAttribute("INF", member);
            if (member != null) {
                String memberID = member.getMemberID();
                String auctionID = request.getParameter("auctionID");
                String country = request.getParameter("country");
                String state = request.getParameter("state");
                String city = request.getParameter("city");
                String address1 = request.getParameter("address1");
                String address2 = request.getParameter("address2");
                String zipCode = request.getParameter("zip");
                String cardNumber = request.getParameter("cardNumber");
                String holderName = request.getParameter("cardHolderName");
                String cvvCode = request.getParameter("cvv");
                int expiryDay = Integer.parseInt(request.getParameter("expiryDay"));
                int expiryMonth = Integer.parseInt(request.getParameter("expiryMonth"));
                int expiryYear = Integer.parseInt(request.getParameter("expiryYear"));
                Date expiryDate = Date.valueOf(String.format("%d-%02d-%02d", expiryYear, expiryMonth, expiryDay));

                boolean addressInserted = dao.insertAddress(country, state, city, address1, address2, zipCode, memberID, holderName, cardNumber, cvvCode, expiryDate);
//                if(addressInserted){
//                    url = request.getContextPath() + BID_PAGE;
//                }

                if (cardNumber != null && addressInserted) {
                    member = dao.getInformation(userID);
                    session.setAttribute("INF", member);
                    url = request.getContextPath() + BID_PAGE;

                }
            }
        } catch (Exception e) {
            log("Error in RegisterToBid servlet: " + e.getMessage(), e);
        } finally {
            response.sendRedirect(url);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration for bidding in auctions.";
    }
}
