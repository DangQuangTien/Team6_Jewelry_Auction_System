package controller.user.authentication;

import dao.UserDAOImpl;
import dto.UserDTO;
import entity.member.Member;
import utils.RoleConstants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private static final String ADMIN_PAGE = "/admin/admin.jsp";
    private static final String STAFF_PAGE = "/staff/staff.jsp";
    private static final String MANAGER_PAGE = "/manager/manager.jsp";
    private static final String HOME_PAGE = "/home";
    private static final String ERROR_PAGE = "index.htm";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private String determinePageByRole(String role) {
        switch (role) {
            case RoleConstants.ADMIN:
                return ADMIN_PAGE;
            case RoleConstants.MEMBER:
                return HOME_PAGE;
            case RoleConstants.STAFF:
                return STAFF_PAGE;
            case RoleConstants.MANAGER:
                return MANAGER_PAGE;
            default:
                return ERROR_PAGE;
        }
    }

    private void initializeSession(HttpServletRequest request, UserDTO user) {
        HttpSession session = request.getSession(true);
        session.setAttribute("USERNAME", user.getUsername());
        session.setAttribute("USERID", user.getUserID());
        session.setAttribute("ROLE", user.getRole());
    }

    @Override
    public String getServletInfo() {
        return "LoginController handles user authentication and role-based redirection.";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("email");
        String password = request.getParameter("password");
        String url = ERROR_PAGE;
        UserDAOImpl dao = new UserDAOImpl();
        try {
            UserDTO user = dao.checkLogin(username, password);
            if (user == null){
                request.setAttribute("error", "Username or password invalid!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            else {
                url = determinePageByRole(user.getRole());
                if ("Member".equals(user.getRole())) {
                    Member member = dao.getInformation(user.getUserID());
                    HttpSession session = request.getSession();
                    session.setAttribute("INF", member);
                }
                initializeSession(request, user);
            }
        } catch (Exception ex) {
            log("LoginController Exception: " + ex.getMessage(), ex);
        } finally {
            if (url.equals(ERROR_PAGE)) {
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + url);
            }
        }
    }
}
