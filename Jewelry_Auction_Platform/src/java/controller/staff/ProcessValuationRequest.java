package controller.staff;

import dao.UserDAOImpl;
import entity.valuation.Valuation;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProcessValuationRequest", urlPatterns = {"/ProcessValuationRequest"})
public class ProcessValuationRequest extends HttpServlet {

    private static final String ERROR_PAGE = "home.jsp";
    private static final String STAFF_PAGE = "/staff/staff.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
             out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            String url = ERROR_PAGE;
            UserDAOImpl dao = new UserDAOImpl();
            ArrayList<Valuation> lst = new ArrayList<>();
            try {
                lst = dao.displayValuationRequest();
                if (lst != null && !lst.isEmpty()){
                    url = STAFF_PAGE;
                }
            } catch (Exception ex){
                ex.getMessage();
            } finally {
                RequestDispatcher dist = request.getRequestDispatcher(url);
                dist.forward(request, response);
            }
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
