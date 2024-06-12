/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.session_handling;

import dao.UserDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class SessionScheduledTask {

    private final UserDAOImpl dao;

    @Autowired
    public SessionScheduledTask(UserDAOImpl dao) {
        this.dao = dao;
    }

    @Scheduled(fixedRate = 2000) // Run every 2 seconds
    public void checkAndCloseAuctions() {
        List<String> auctionID = dao.getAllAuctionID();
        for (String auctionId : auctionID) {
            if (!dao.isAuctionOpen(auctionId)) {
                dao.isAuctionEnded(auctionId);
            }
        }
    }
}