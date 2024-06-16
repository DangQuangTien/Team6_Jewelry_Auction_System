package controller.user;

import dao.UserDAOImpl;
import entity.member.Member;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PlaceBidController", urlPatterns = {"/PlaceBidController"})
public class PlaceBidController extends HttpServlet {

    private static final String ERROR_PAGE = "/index.htm";
    private static final String DETAIL_PAGE = "/auctions/detail.jsp";
    private static final String AUCTION_PARAM = "auctionID";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        UserDAOImpl dao = new UserDAOImpl();
        String url = ERROR_PAGE;
        String userID = (String) session.getAttribute("USERID");

        try {
            Member member = dao.getInformation(userID);

            if (member != null) {
                String preBidAmount = request.getParameter("preBid_Amount");
                String auctionID = request.getParameter("auctionID");
                String jewelryID = request.getParameter("jewelryID");

                if (preBidAmount != null && auctionID != null && jewelryID != null) {
                    try {
                        boolean check = dao.placeBid(preBidAmount, jewelryID, member.getMemberID());
                        if (!check) {
                            String message = "You have placed this jewelry";
                            request.setAttribute("PlACEBIDSTATUS", message);
                        } else {
                            String message = "PLACED BID SUCCESSFULLY!";
                            request.setAttribute("PlACEBIDSTATUS", message);
                        }
                        url = DETAIL_PAGE + "?" + AUCTION_PARAM + "=" + auctionID;
                    } catch (Exception ex) {
                        ex.printStackTrace(); // Proper logging should be implemented
                    }
                } else {
                    System.err.println("Invalid parameters received in request.");
                }
            } else {
                System.err.println("Member information not found for userID: " + userID);
            }
        } catch (Exception ex) {
            ex.printStackTrace(); // Proper logging should be implemented
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "PlaceBidController Servlet";
    }
}
