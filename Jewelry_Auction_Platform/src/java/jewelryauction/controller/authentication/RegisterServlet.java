/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package jewelryauction.controller.authentication;

import dao.UserDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private static final String ERROR_PAGE = "/register";

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.getRequestDispatcher("register.jsp").forward(request, response);
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
//        processRequest(request, response);
        String url = ERROR_PAGE;
        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String userName = request.getParameter("username");
            String password = request.getParameter("password");
            String phoneNumber = request.getParameter("phoneNumber");
            String gender = request.getParameter("gender");
            int dobDay = Integer.parseInt(request.getParameter("dobDay"));
            int dobMonth = Integer.parseInt(request.getParameter("dobMonth"));
            int dobYear = Integer.parseInt(request.getParameter("dobYear"));
            Date dob = Date.valueOf(String.format("%d-%02d-%02d", dobYear, dobMonth, dobDay));

            UserDAOImpl dao = new UserDAOImpl();
            boolean hasError = false;
            StringBuilder errorMsg = new StringBuilder();

            if (!isValidName(firstName)) {
                hasError = true;
                errorMsg.append("First name must be between 1 and 15 characters and contain no numbers.<br>");
            }
            if (!isValidName(lastName)) {
                hasError = true;
                errorMsg.append("Last name must be between 1 and 15 characters and contain no numbers.<br>");
            }
            if (!isValidPassword(password)) {
                hasError = true;
                errorMsg.append("Password must be at least 6 characters long and contain at least one uppercase character.<br>");
            }
            if (!isValidPhoneNumber(phoneNumber)) {
                hasError = true;
                errorMsg.append("Phone number must be 10 or 11 number characters.<br>");
            }
            if (dao.checkDuplicateUsername(userName)) {
                hasError = true;
                errorMsg.append("Username is already taken.<br>");
            }

            if (hasError) {
                request.setAttribute("errorMsg", errorMsg.toString());
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                // Process registration (e.g., save to database)
                // Save user details to the database
                // Redirect to login page
                boolean result = dao.registerUser(firstName, lastName, email, userName, password, phoneNumber, gender, dob);
                if (result) {
                    response.sendRedirect(request.getContextPath() + "/login");
                }
            }

        } catch (Exception ex) {
            ex.getMessage();
        }
    }

    private boolean isValidName(String name) {
        String nameRegex = "^[A-Za-z]{1,15}$";
        Pattern pattern = Pattern.compile(nameRegex);
        Matcher matcher = pattern.matcher(name);
        return matcher.matches();
    }

    private boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z]).{6,}$";
        Pattern pattern = Pattern.compile(passwordRegex);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        String phoneRegex = "^[0-9]{10,11}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(phoneNumber);
        return matcher.matches();
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