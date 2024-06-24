package jewelryauction.controller.member;

import com.google.gson.Gson;
import dao.UserDAOImpl;
import entity.product.Jewelry;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateJewelryServlet", urlPatterns = {"/UpdateJewelryServlet"})
public class UpdateJewelryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String userID = (String) request.getSession().getAttribute("USERID");
        if (userID == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is not available in the session.");
            return;
        }

        UserDAOImpl dao = new UserDAOImpl();
        List<Jewelry> listJewelry = dao.getJewelryByUserID(userID);

        if (listJewelry == null) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve jewelry data.");
            return;
        }
        String json = new Gson().toJson(listJewelry);
        response.getWriter().write(json);
    }

    @Override
    public String getServletInfo() {
        return "UpdateJewelryServlet provides updated jewelry data for a user";
    }
}
