<%@page import="entity.member.Member"%>
<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jewelry Auction Platform</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }
            .container {
                max-width: 80%;
                margin: 50px auto;
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                padding: 20px;
            }
            .container-bid {
                max-width: 50%;
                margin: 50px auto;
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                display: flex;
                flex-direction: column;
            }
            .horizontal-scroll-container {
                display: flex;
                justify-content: center; /* Center the items */
                gap: 20px; /* Add equal spacing between items */
                padding: 10px;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                scroll-snap-type: x mandatory;
                width: 100%; /* Set fixed width */
            }
            .horizontal-scroll-item {
                flex: 0 0 auto;
                width: 150px;
                scroll-snap-align: center;
                transition: transform 0.3s, width 0.3s, filter 0.3s;
                filter: blur(2px); /* Default blur for censored effect */
            }
            .horizontal-scroll-item.selected {
                transform: scale(1.2);
                width: 200px;
                filter: blur(0); /* Remove blur for selected item */
            }
            .card {
                position: relative;
                overflow: hidden;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .card img {
                width: 100%;
                height: 300px; /* Increase height for larger images */
                object-fit: cover;
            }
            .card-body {
                padding: 10px;
                text-align: center;
            }
            .card-title {
                font-size: 16px;
                margin: 0;
            }
            .card-text {
                font-size: 14px;
                color: #555;
            }
            .btn {
                background-color: #4CAF50;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #388E3C;
            }
            .chat-header {
                background-color: #4CAF50;
                color: #fff;
                padding: 15px;
                text-align: center;
                font-size: 24px;
                border-bottom: 2px solid #388E3C;
                position: relative;
            }
            .exit-button {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            .exit-button button {
                background-color: #FF5733;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .exit-button button:hover {
                background-color: #E74C3C;
            }
            .chat-messages {
                flex: 1;
                overflow-y: auto;
                padding: 10px;
                background: linear-gradient(to right, #4CAF50, #388E3C);
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            .message {
                max-width: 60%;
                padding: 10px;
                border-radius: 15px;
                background-color: #f8f9fa;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
                animation: fadeIn 0.5s ease;
            }
            .message p {
                margin: 0;
                word-wrap: break-word;
                color: #333;
            }
            .message.from-me {
                background-color: #4CAF50;
                color: #fff;
                align-self: flex-end;
                border-top-right-radius: 0;
            }
            .message.from-me p {
                color: #fff;
            }
            .message .message-time {
                font-size: 12px;
                color: #777;
                margin-top: 5px;
                text-align: right;
            }
            .chat-input {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;
                background-color: #f8f9fa;
                border-top: 1px solid #ddd;
            }
            .chat-input input[type="number"] {
                flex: 1;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 20px;
                margin-right: 10px;
                outline: none;
            }
            .chat-input button {
                background-color: #4CAF50;
                color: #fff;
                border: none;
                border-radius: 20px;
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .chat-input button:hover {
                background-color: #388E3C;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

    </head>
    <body>
        <%
            UserDAOImpl dao = new UserDAOImpl();
            String userID = (String) session.getAttribute("USERID");
            Member member = dao.getInformation(userID);
            String memberID = null;
            if (member != null) {
                memberID = member.getMemberID();
            }
        %>

        <div class="chat-header">
            Bidding Room
            <div class="exit-button">
                <form action="${pageContext.request.contextPath}/auctions/detail.jsp?auctionID=<%= request.getParameter("auctionID")%>" method="post">
                    <button type="submit"><i class="fas fa-sign-out-alt"></i> Exit</button>
                </form>
            </div>
        </div>
        <!-- Display catalog of auction -->
        <div class="container">
            <div class="horizontal-scroll-container" id="jewelryContainer">
                <%
                    String auctionID = (String) request.getParameter("auctionID");
                    List<Jewelry> listJewelry = dao.displayCatalog(auctionID);

                    for (Jewelry jewelry : listJewelry) {
                %>
                <div class="horizontal-scroll-item">
                    <div class="card">
                        <% String photo = jewelry.getPhotos(); %>
                        <% String[] photoArray = photo.split(";");%>
                        <img src="${pageContext.request.contextPath}/<%= photoArray[0]%>" class="card-img-top" alt="<%= jewelry.getJewelryName()%>">
                        <div class="card-body">
                            <h5 class="card-title"><%= jewelry.getJewelryID()%></h5>
                            <p class="card-text"><%= jewelry.getJewelryName()%></p>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            if (userID != null && memberID != null) { // Check if userID and memberID are not null
        %>
        <!-- WebSocket chat section -->
        <div class="container-bid">
            <div class="chat-messages" id="chatMessages">
                <!-- Messages will be displayed here -->
            </div>
        </div>
        <div class="container-bid">
            <div class="chat-input">
                <input type="number" id="textMessage" placeholder="Enter your bid...">
                <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
        <% } else { %>
        <div style="text-align: center; margin-top: 20px;">
            Please <a href="${pageContext.request.contextPath}/login.jsp">log in</a> to participate in the auction.
        </div>
        <% }%>
        <script>
            var auctionID = "<%= request.getParameter("auctionID")%>";
            var memberID = "<%= memberID%>";
            var selectedJewelryID = null;

            var websocketURL = "ws://localhost:8081/Jewelry_Auction_Platform/BiddingRoomServer/" + auctionID;
            var websocket = new WebSocket(websocketURL);

            websocket.onopen = function (event) {
                console.log("WebSocket connection opened.");
                processOpen(event);
            };

            websocket.onmessage = function (event) {
                console.log("Message received: " + event.data);
                processMessage(event);
            };

            websocket.onclose = function (event) {
                if (event.wasClean) {
                    console.log("WebSocket connection closed cleanly, code=" + event.code + " reason=" + event.reason);
                } else {
                    console.error("WebSocket connection closed unexpectedly.");
                }
                processClose(event);
            };

            websocket.onerror = function (event) {
                console.error("WebSocket error:", event);
                processError(event);
            };

            function processOpen(event) {
                appendMessage("Server connected...");
            }

            function processMessage(event) {
                appendMessage(event.data, true);
            }

            function processClose(event) {
                appendMessage("Server disconnected...");
            }

            function processError(event) {
                appendMessage("Error: " + event);
            }

            function sendMessage() {
                var textMessage = document.getElementById('textMessage').value.trim();
                if (textMessage !== "" && selectedJewelryID !== null) {
                    if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
                        // Construct messageData object with bid information
                        var messageData = {
                            jewelryID: selectedJewelryID,
                            bid: textMessage,
                            member: memberID  // Ensure memberID is defined correctly
                        };

                        // Send JSON data to server
                        websocket.send(JSON.stringify(messageData));

                        // Clear input field after sending
                        document.getElementById('textMessage').value = "";

                        // Format bid message for display in the chat
                        var bidAmount = '$' + textMessage;
                        var bidMessage = "You just bid: " + bidAmount + " at " + getTime();
                        // Display user-friendly message in the chat interface
                        appendMessage(bidMessage, false);
                    }
                }
            }

            function appendMessage(messageContent, isFromMe) {
                var chatMessages = document.getElementById('chatMessages');
                var messageElement = document.createElement('div');
                messageElement.classList.add('message');
                if (isFromMe) {
                    messageElement.classList.add('from-me');
                }
                var messageText = document.createElement('p');
                messageText.textContent = messageContent; // Display user-friendly message
                var messageTime = document.createElement('div');
                messageTime.classList.add('message-time');
                messageTime.textContent = getTime();
                messageElement.appendChild(messageText);
                messageElement.appendChild(messageTime);
                chatMessages.appendChild(messageElement);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            function getTime() {
                var now = new Date();
                var hours = now.getHours().toString().padStart(2, '0');
                var minutes = now.getMinutes().toString().padStart(2, '0');
                return hours + ':' + minutes;
            }

            function selectItem(element, jewelryID) {
                // Remove 'selected' class from all items
                document.querySelectorAll('.horizontal-scroll-item').forEach(item => {
                    item.classList.remove('selected');
                });
                // Add 'selected' class to the clicked item
                element.classList.add('selected');
                selectedJewelryID = jewelryID;
            }

            function updateURLParameter() {
                if (selectedJewelryID !== null) {
                    var url = new URL(window.location.href);
                    url.searchParams.set('jewelryID', selectedJewelryID);
                    window.history.pushState({}, '', url);
                }
            }

            var currentIndex = 0;
            function autoSelectItem() {
                var items = document.querySelectorAll('.horizontal-scroll-item');
                if (items.length > 0) {
                    if (currentIndex >= items.length) {
                        // Redirect to exit page after reaching the last item
                        window.location.href = "${pageContext.request.contextPath}/auctions/detail.jsp?auctionID=<%= request.getParameter("auctionID")%>";
                                        return;
                                    }
                                    selectItem(items[currentIndex], items[currentIndex].querySelector('.card-title').textContent);
                                    updateURLParameter();
                                    currentIndex++;
                                }
                            }

                            // Automatically select the first item on page load
                            window.onload = function () {
                                autoSelectItem();
                                // Update the URL parameter and select a new item every 1 minute
                                setInterval(autoSelectItem, 60000);
                            };
        </script>
    </body>
</html>
