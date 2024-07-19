package jewelryauction.controller.web.auction;

import dao.UserDAOImpl;
import entity.Auction.Auction;
import entity.creditCard.CreditCard;
import entity.member.Member;
import entity.product.Category;
import entity.product.Jewelry;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AuctionServlet", urlPatterns = {"/auction"})
public class AuctionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This method can be used to handle common logic for both GET and POST requests
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ensure we call the common processRequest method if needed
        // processRequest(request, response);

        UserDAOImpl dao = new UserDAOImpl();
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("USERID");
        String auctionID = request.getParameter("auctionID");

        // Retrieve auction, catalog, and member details
        Auction auction = dao.getAuctionByID(auctionID);
        List<Jewelry> listJewelry = dao.displayCatalog(auctionID);
        Member member = dao.getInformation(userID);
        List<Category> listCategory = dao.listCategory();
        CreditCard creditCard = dao.getCardInformation(userID);
        // Set attributes for the request
        request.setAttribute("AUCTION", auction);
        request.setAttribute("CATALOG", listJewelry);
        request.setAttribute("MEMBER", member);
        request.setAttribute("AUCTIONID", auctionID);
        request.setAttribute("CATEGORIES", listCategory);
        request.setAttribute("CREDITCARD", creditCard);
        // Forward the request to the detail.jsp page in the auction folder
        request.getRequestDispatcher("/auctions/detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If we need to handle POST requests differently, add the logic here
        doGet(request, response); // Currently redirecting POST to GET for simplicity
    }

    @Override
    public String getServletInfo() {
        return "AuctionServlet handles the auction details retrieval and forwards to the auction details page.";
    }
}
