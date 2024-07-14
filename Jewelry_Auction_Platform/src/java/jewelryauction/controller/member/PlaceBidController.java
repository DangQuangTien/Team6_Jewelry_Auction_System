package jewelryauction.controller.member;

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

@WebServlet(name = "PlaceBidController", urlPatterns = {"/placebid"})
public class PlaceBidController extends HttpServlet {

    private static final String ERROR_PAGE = "index.htm";
    private static final String AUCTION_PAGE = "/auction?auctionID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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
                        boolean isJewelryOwnedByMember = dao.isJewelryOwnedByMember(jewelryID, member.getMemberID());
                        if (isJewelryOwnedByMember) {
                            String message = "You cannot place a bid on your own jewelry!";
                            request.setAttribute("PLACEDBIDSTATUS", message);
                        } else {
                            boolean check = dao.placeBid(preBidAmount, jewelryID, member.getMemberID());
                            if (!check) {
                                String message = "Failed to place a bid. Please try again.";
                                request.setAttribute("PLACEDBIDSTATUS", message);
                            } else {
                                String message = "Placed bid successfully!";
                                request.setAttribute("PLACEDBIDSTATUS", message);
                            }
                        }
                        url = AUCTION_PAGE + auctionID;
                    } catch (Exception ex) {
                        ex.printStackTrace();
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
