<%@page import="entity.member.Member"%>
<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jewelry Auction Platform</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            /* Light Grey Theme */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #333; /* Light grey background */
                color: #333; /* Dark grey text */
                transition: background-color 0.3s, color 0.3s;
            }

            .container, .container-bid {
                max-width: 80%;
                margin: 50px auto;
                background-color: #fff; /* White container background */
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                padding: 20px;
                transition: box-shadow 0.3s, transform 0.3s;
            }

            .container-bid {
                max-width: 50%;
                display: flex;
                flex-direction: column;
                margin-left: auto; /* Push to right side */
                margin-top: 20px;
            }

            .container:hover, .container-bid:hover {
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
                transform: translateY(-5px); /* Lift container on hover */
            }

            /* Horizontal Scroll Container */
            .horizontal-scroll-container {
                display: flex;
                justify-content: flex-start;
                gap: 20px;
                padding: 10px;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                scroll-snap-type: x mandatory;
                width: 100%;
                scrollbar-width: none;
                -ms-overflow-style: none;
                transition: padding 0.3s;
            }

            .horizontal-scroll-container::-webkit-scrollbar {
                display: none;
            }

            .horizontal-scroll-container:hover {
                padding: 15px;
            }

            /* Horizontal Scroll Items */
            .horizontal-scroll-item {
                flex: 0 0 auto;
                width: 150px;
                scroll-snap-align: center;
                transition: transform 0.3s, width 0.3s, filter 0.3s, box-shadow 0.3s;
                filter: blur(2px);
                cursor: pointer;
                position: relative;
                overflow: hidden;
                border-radius: 10px;
            }

            .horizontal-scroll-item::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.1); /* Semi-transparent dark overlay */
                z-index: 2;
                opacity: 0;
                transition: opacity 0.3s;
            }

            .horizontal-scroll-item:hover::before {
                opacity: 0.1; /* Overlay effect on hover */
            }

            .horizontal-scroll-item.selected {
                transform: scale(1.1);
                width: 180px;
                filter: blur(0);
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* Light shadow */
            }

            .horizontal-scroll-item:hover {
                transform: scale(1.05);
            }

            /* Cards */
            .card {
                position: relative;
                overflow: hidden;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .card:hover {
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                transform: translateY(-5px); /* Lift card on hover */
            }

            .card img {
                width: 100%;
                height: 300px;
                object-fit: cover;
                transition: transform 0.3s;
            }

            .card:hover img {
                transform: scale(1.03); /* Zoom image on hover */
            }

            .card-body {
                padding: 15px;
                text-align: center;
                background-color: #f5f5f5; /* Light grey background */
                border-radius: 0 0 10px 10px;
                transition: background-color 0.3s;
            }

            .card:hover .card-body {
                background-color: #e0e0e0; /* Slightly darker grey on hover */
            }

            .card-title {
                font-size: 18px;
                margin: 10px 0 5px;
                font-weight: bold;
                color: #333; /* Dark grey title */
                transition: color 0.3s;
            }

            .card:hover .card-title {
                color: #1a1a1a; /* Darker title color on hover */
            }

            .card-text {
                font-size: 14px;
                color: #666; /* Dark grey text */
                line-height: 1.5;
                transition: color 0.3s;
            }

            .card:hover .card-text {
                color: #444; /* Slightly darker grey text on hover */
            }

            /* Additional Effects */

            /* Gradient Overlay on Horizontal Scroll Items */
            .horizontal-scroll-item::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0)); /* Gradient overlay */
                z-index: 3;
                opacity: 0;
                transition: opacity 0.3s, transform 0.3s;
            }

            .horizontal-scroll-item:hover::after {
                opacity: 0.1; /* Show gradient overlay on hover */
            }

            /* Overlay on Cards */
            .card-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.1); /* Semi-transparent overlay */
                z-index: 2;
                opacity: 0;
                transition: opacity 0.3s;
            }

            .card:hover .card-overlay {
                opacity: 0.2; /* Show overlay on card hover */
            }

            /* Text Overlay Animation */
            .card-overlay-text {
                position: absolute;
                bottom: 20px;
                left: 50%;
                transform: translateX(-50%);
                color: #fff; /* White text */
                font-size: 16px;
                font-weight: bold;
                text-transform: uppercase;
                opacity: 0;
                transition: opacity 0.3s, transform 0.3s;
            }

            .card:hover .card-overlay-text {
                opacity: 1; /* Show text on overlay */
                transform: translateX(-50%) translateY(-10px); /* Move text slightly upwards */
            }

            /* Box Shadow on Hover for Containers */
            .container:hover, .container-bid:hover, .horizontal-scroll-item:hover, .card:hover {
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2); /* Enhanced box shadow on hover */
            }




            .chat-header {
                background-color: black; /* Dark blue background */
                color: #ffffff; /* White text */
                padding: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border: 2px solid transparent; /* Transparent border initially */
                transition: background-color 0.3s, border-color 0.3s;
            }

            .header-text {
                font-size: 3rem;
                font-weight: bold;
            }

            .exit-button {
                margin-left: 10px; /* Adjusted margin */
            }

            .exit-button button.exit-btn {
                background-color: #e74c3c; /* Red button */
                color: #fff;
                border: none;
                padding: 12px 24px;
                border-radius: 8px; /* Rounded corners */
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
                font-size: 16px;
                text-transform: uppercase;
                position: relative;
                overflow: hidden;
                border: 2px solid transparent; /* Transparent border initially */
            }

            .exit-button button.exit-btn:hover {
                background-color: #c0392b; /* Darker red on hover */
                transform: scale(1.05); /* Scale up on hover */
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); /* Enhanced shadow on hover */
                border-color: #a93226; /* Darker border on hover */
            }

            .exit-button button.exit-btn i {
                margin-right: 8px; /* Space between icon and text */
                transition: transform 0.2s;
            }

            .exit-button button.exit-btn:hover i {
                transform: translateX(3px); /* Move icon to the right on hover */
            }

            .chat-container {
                display: flex;
                flex-direction: column;
                height: 400px; /* Adjust height as needed */
                border: 1px solid grey; /* Optional: Add border or other styling */
                overflow: hidden; /* Ensure overflow is set to handle scrolling */
                border-radius: 20px;
                background-color: black;
            }

            .chat-messages {
                flex: 1; /* Take remaining vertical space */
                overflow-y: auto; /* Enable vertical scrolling */
                padding: 10px;

            }

            .chat-messages::-webkit-scrollbar {
                display: none;
            }

            .message {
                max-width: 80%;
                padding: 15px;
                border-radius: 15px;
                background-color: #007bff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
                animation: fadeIn 0.5s ease;
                margin-bottom: 10px;
                margin-left: auto;

            }
            .message p {
                margin: 0;
                word-wrap: break-word;
                font-size: 20px;
                color: #FFFFFF;
            }
            .message.from-me {
                background-color: #444;
                color: #fff;
                align-self: flex-end;
                border-top-right-radius: 0;
                margin-left: 20px;
            }
            .message.from-me p {
                color: white;
            }
            .message .message-time {
                font-size: 18px;
                color: white;
                margin-top: 5px;
                text-align: right;
            }
            .chat-input {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                border-radius: 20px;
                border: 4px solid black;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .chat-input input[type="number"] {
                flex: 1;
                padding: 15px;
                border: 1px solid #ccc;
                border-radius: 20px;
                margin-right: 15px;
                outline: none;
                transition: border-color 0.3s, box-shadow 0.3s;
                background-color: #333;
                color: white;
                font-size: 20px;

            }

            .chat-input input[type="number"]:focus {
                border-color: #007bff;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.25);
            }

            .chat-input button {
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 20px;
                padding: 15px 25px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                font-weight: bold;
            }

            .chat-input button:hover {
                background-color: #0056b3;
                transform: scale(1.05);
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
            .grid-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                padding: 20px;
            }
            .btn {
                height: 3rem;
                width: 9rem;
                border-radius: 5px;
                border: 5px solid rgb(255, 255, 255);
                cursor: pointer;
                filter: drop-shadow(0px 0px 10px rgb(255, 255, 255));
                animation: flickering 2s linear infinite both;
                text-transform: uppercase;
                background-color: rgb(83, 82, 82);
                color: rgb(234, 234, 234);
                font-weight: 700;
                transition: 0.6s;
                box-shadow: 0px 0px 60px #1f4c65;
                -webkit-box-reflect: below 10px linear-gradient(to bottom, rgba(0,0,0,0.0), rgba(0,0,0,0.4));
            }

            @keyframes flickering {
                0%,
                100% {
                    opacity: 1;
                }

                41.99% {
                    opacity: 1;
                }

                42% {
                    opacity: 0;
                }

                43% {
                    opacity: 0;
                }

                43.01% {
                    opacity: 1;
                }

                47.99% {
                    opacity: 1;
                }

                48% {
                    opacity: 0;
                }

                49% {
                    opacity: 0;
                }

                49.01% {
                    opacity: 1;
                }
            }

            .text {
                font-size: 1.8rem;
                font-family: Arial, Helvetica, sans-serif;
            }

            .btn:hover {
                background-color: black;
                border-radius: 0;
            }
        </style>
    </head>
    <body>
        <%
            Member member = (Member) session.getAttribute("MEMBER");
            String memberID = null;
            if (member != null) {
                memberID = member.getMemberID();
            }
        %>
        <div class="chat-header">
            <div class="header-text">
                Live Auction
            </div>
            <div class="exit-button">
                <form action="${pageContext.request.contextPath}/auction?auctionID=<%= request.getParameter("auctionID")%>" method="post">
                    <button type="submit" class="btn">
                        <span class="text">EXIT</span>
                    </button>
                </form>
            </div>
        </div>

        <!-- Display catalog of auction -->
        <div class="grid-container">
            <div class="jewelry-container">
                <div class="horizontal-scroll-container" id="jewelryContainer">
                    <% String auctionID = (String) request.getParameter("auctionID");
                        List<Jewelry> listJewelry = (List<Jewelry>) request.getAttribute("JEWELRYLIST");
                        for (Jewelry jewelry : listJewelry) {
                    %>
                    <div class="horizontal-scroll-item" data-currentbid="<%= jewelry.getCurrentBid()%>">
                        <div class="card" onclick="selectItem(this, '<%= jewelry.getJewelryID()%>')">
                            <% String photo = jewelry.getPhotos(); %>
                            <% String[] photoArray = photo.split(";");%>
                            <img src="${pageContext.request.contextPath}/<%= photoArray[0]%>" class="card-img-top" alt="<%= jewelry.getJewelryName()%>">
                            <div class="card-body">
                                <h5 class="card-title"><%= jewelry.getJewelryID()%></h5>
                                <p class="card-text"><%= jewelry.getJewelryName()%></p>
                                <p class="card-text" style="display: none;">Current Bid: <%= jewelry.getCurrentBid()%></p> <!-- Hidden current bid -->
                                <input type="hidden" class="current-bid-value" value="<%= jewelry.getCurrentBid()%>"> <!-- Hidden input with current bid value -->
                            </div>
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>

            <div class="chat-container">
                <div class="chat-messages" id="chatMessages">
                    <!-- Messages will be displayed here -->
                </div>
                <div class="chat-input">
                    <input type="number" id="textMessage" placeholder="Enter your bid...">
                    <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var items = document.querySelectorAll('.horizontal-scroll-item');

                if (items.length > 0) {
                    // Loop through each item
                    items.forEach(item => {
                        item.style.pointerEvents = "none";
                        setCurrentBid(item);
                        selectItem(item);
                    });
                }
            });

            function setCurrentBid(element) {
                var currentBid = element.getAttribute("data-currentbid");
                document.getElementById("textMessage").value = currentBid;
            }
            var auctionID = "<%= request.getParameter("auctionID")%>";
            var memberID = "<%= memberID%>";
            var selectedJewelryID = null;
            var currentIndex = 0;
            var items = document.querySelectorAll('.horizontal-scroll-item');

            var websocketURL = "ws://localhost:8081/Jewelry_Auction_Platform/BiddingRoomServer/" + auctionID;
            var websocket = new WebSocket(websocketURL);

            websocket.onopen = function (event) {
                console.log("WebSocket connection opened.");
                processOpen(event);
                sendAllItems();
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
                        var messageData = {
                            jewelryID: selectedJewelryID,
                            bid: textMessage,
                            member: memberID
                        };
                        websocket.send(JSON.stringify(messageData));
                        document.getElementById('textMessage').value = "";
                        var bidAmount = '$' + textMessage;
                        var bidMessage = "You just bid " + bidAmount;
                        appendMessage(bidMessage, false);
                        scrollToBottom();
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
                messageText.textContent = messageContent;
                var messageTime = document.createElement('div');
                messageTime.classList.add('message-time');
                messageTime.textContent = getTime();
                messageElement.appendChild(messageText);
                messageElement.appendChild(messageTime);
                chatMessages.appendChild(messageElement);
            }
            function scrollToBottom() {
                var chatMessages = document.getElementById('chatMessages');
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            function getTime() {
                var now = new Date();
                var hours = now.getHours().toString().padStart(2, '0');
                var minutes = now.getMinutes().toString().padStart(2, '0');
                return hours + ':' + minutes;
            }

            document.getElementById('textMessage').addEventListener('keyup', function (event) {
                if (event.key === 'Enter') {
                    sendMessage();
                }
            });

            function selectItem(element, jewelryID) {
                // Remove 'selected' class from all items
                document.querySelectorAll('.horizontal-scroll-item').forEach(item => {
                    item.classList.remove('selected');
                });
                // Add 'selected' class to the clicked item
                element.classList.add('selected');
                selectedJewelryID = jewelryID;
                var currentBid = element.getAttribute("data-currentbid");
                document.getElementById("textMessage").value = currentBid;

            }

            history.pushState(null, null, document.URL);
            window.addEventListener('popstate', function () {
                history.pushState(null, null, document.URL);
            });

            function updateURLParameter() {
                if (selectedJewelryID !== null) {
                    var url = new URL(window.location.href);
                    url.searchParams.set('jewelryID', selectedJewelryID);
                    history.pushState({}, '', url);
                }
            }

            function sendAllItems() {
                if (items.length > 0) {
                    let index = 0;
                    function sendNextItem() {
                        if (index < items.length) {
                            let item = items[index];
                            selectItem(item, item.querySelector('.card-title').textContent);
                            updateURLParameter(); // Update URL with selected item (if needed)
                            setTimeout(() => {
                                if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
                                    let finishedMessage = {
                                        status: "finished",
                                        selectedJewelryID: item.querySelector('.card-title').textContent
                                    };
                                    console.log("Sending finished message:", finishedMessage);
                                    websocket.send(JSON.stringify(finishedMessage));
                                }
                                index++;
                                if (index < items.length) {
                                    sendNextItem(); // Send next item after 30000 milliseconds (6 seconds)
                                } else {
                                    // After all items are sent, redirect to another page after 30000 milliseconds
                                    window.location.href = `${pageContext.request.contextPath}/auction?auctionID=<%= request.getParameter("auctionID")%>`;
                                                            }
                                                        }, 300000);
                                                    }
                                                }

                                                if (websocket.readyState === WebSocket.OPEN) {
                                                    sendNextItem();
                                                } else {
                                                    websocket.onopen = function () {
                                                        sendNextItem();
                                                    };
                                                }
                                            }
                                        }
                                        window.onload = function () {
                                            if (websocket.readyState === WebSocket.OPEN) {
                                                sendAllItems();
                                            } else {
                                                websocket.onopen = function () {
                                                    sendAllItems();
                                                };
                                            }
                                        };
        </script>
    </body>
</html>

