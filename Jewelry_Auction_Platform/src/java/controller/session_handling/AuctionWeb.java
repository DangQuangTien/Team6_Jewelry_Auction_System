/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.session_handling;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class AuctionWeb {
    public static void main(String[] args) {
        // Create a new application context from the AppConfig class
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        
        // Keep the application running to observe scheduled tasks
        context.registerShutdownHook();
    }
}


