/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package jewelryauction.controller.staff;

import dao.UserDAOImpl;
import dao.UserDao;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author User
 */
@WebServlet(name = "ConfirmPaymentServlet", urlPatterns = {"/confirmPayment"})
public class ConfirmPaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder jsonPayload = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonPayload.append(line);
        }

        JSONObject jsonObject = new JSONObject(jsonPayload.toString());
        String invoiceID = jsonObject.getString("invoiceID");
        String jewelryID = jsonObject.getString("jewelryID");

        UserDao dao = new UserDAOImpl();
        try {
            boolean result = dao.confirmPayment(jewelryID);
            dao.updateSoldAmount(jewelryID);
            if (result) {
                response.sendRedirect("transaction");
            } else {
                response.sendRedirect("index.htm");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Xử lý lỗi nếu có ngoại lệ
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
