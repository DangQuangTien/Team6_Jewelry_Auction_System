package jewelryauction.controller.staff;

import dao.UserDAOImpl;
import entity.product.Jewelry;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateJewelry", urlPatterns = {"/UpdateJewelry"})
public class UpdateJewelry extends HttpServlet {
    private UserDAOImpl dao;

    public void init() {
        dao = new UserDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jewelryName = request.getParameter("name");
        String jewelryID = request.getParameter("jewelryID");
        String artist = request.getParameter("artist");
        String circa = request.getParameter("circa");
        String material = request.getParameter("material");
        String dial = request.getParameter("dial");
        String braceletMaterial = request.getParameter("braceletMaterial");
        String caseDimensions = request.getParameter("caseDimensions");
        String braceletSize = request.getParameter("braceletSize");
        String serialNumber = request.getParameter("serialNumber");
        String referenceNumber = request.getParameter("referenceNumber");
        String caliber = request.getParameter("caliber");
        String movement = request.getParameter("movement");
        String condition = request.getParameter("condition");
        String metal = request.getParameter("metal");
        String gemstones = request.getParameter("gemstones");
        String measurements = request.getParameter("measurements");
        String weight = request.getParameter("weight");
        String stamped = request.getParameter("stamped");
        String ringSize = request.getParameter("ringSize");
        Jewelry jewelry = new Jewelry();
        jewelry.setJewelryName(jewelryName);
        jewelry.setJewelryID(jewelryID);
        jewelry.setArtist(artist != null ? artist : "");
        jewelry.setCirca(circa != null ? circa : "");
        jewelry.setMaterial(material != null ? material : "");
        jewelry.setDial(dial != null ? dial : "");
        jewelry.setBraceletMaterial(braceletMaterial != null ? braceletMaterial : "");
        jewelry.setCaseDimensions(caseDimensions != null ? caseDimensions : "");
        jewelry.setBraceletSize(braceletSize != null ? braceletSize : "");
        jewelry.setSerialNumber(serialNumber != null ? serialNumber : "");
        jewelry.setReferenceNumber(referenceNumber != null ? referenceNumber : "");
        jewelry.setCaliber(caliber != null ? caliber : "");
        jewelry.setMovement(movement != null ? movement : "");
        jewelry.setCondition(condition != null ? condition : "");
        jewelry.setMetal(metal != null ? metal : "");
        jewelry.setGemstones(gemstones != null ? gemstones : "");
        jewelry.setMeasurements(measurements != null ? measurements : "");
        jewelry.setWeight(weight != null ? weight : "");
        jewelry.setStamped(stamped != null ? stamped : "");
        jewelry.setRingSize(ringSize != null ? ringSize : "");

        boolean result = dao.updateJewelry(jewelry);
        if (result) {
            response.sendRedirect(request.getContextPath() + "/finalValuation");
        } else {
            response.sendRedirect("index.htm");
        }
    }
}
