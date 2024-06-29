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
        <link rel="stylesheet" type="text/css" href="index.css">
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
            <div style="font-family: Georgia; margin-left: 600px" class="header-text">
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

        <!-- Upper Part: Catalog and Item Details -->
        <div class="upper-part">
            <div class="grid-container">
                <div class="jewelry-container">
                    <div class="horizontal-scroll-container" id="jewelryContainer">
                        <% String auctionID = (String) request.getParameter("auctionID");
                            List<Jewelry> listJewelry = (List<Jewelry>) request.getAttribute("JEWELRYLIST");
                            for (Jewelry jewelry : listJewelry) {
                        %>
                        <div class="horizontal-scroll-item" data-currentbid="<%= jewelry.getCurrentBid()%>" data-id="<%= jewelry.getJewelryID()%>" data-details="<%= jewelry.getJewelryName()%>;<%= jewelry.getCategoryName()%>;<%= jewelry.getArtist()%>;<%= jewelry.getMinPrice()%>;<%= jewelry.getMaxPrice()%>;<%= jewelry.getMaterial()%>;<%= jewelry.getCondition()%>">
                            <div class="card" onclick="selectItem(this)">
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
                <div class="item-details-container" id="itemDetailsContainer">
                    <!-- Additional space for item details -->
                    <h3>Detail</h3>
                    <p id="detailName"></p>
                    <p id="detailCategory"></p>
                    <p id="detailArtist"></p>
                    <p id="detailMinPrice"></p>
                    <p id="detailMaxPrice"></p>
                    <p id="detailMaterial"></p>
                    <p id="detailCondition"></p>
                </div>
            </div>
        </div>

        <!-- Lower Part: Chat Socket -->
        <div class="chat-container">
            <div class="chat-messages" id="chatMessages">
                <!-- Messages will be displayed here -->
            </div>
            <div class="chat-input">
                <input type="number" id="textMessage" placeholder="Enter your bid...">
                <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var items = document.querySelectorAll('.horizontal-scroll-item');

                if (items.length > 0) {
                    // Automatically select the first item
                    selectItem(items[0]);
                }
            });

            var auctionID = "<%= request.getParameter("auctionID")%>";
            var memberID = "<%= memberID%>";
            var selectedJewelryID = null;

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
                if (messageContent === "Jewelry no longer exists!") {
                    setTimeout(function () {
                        location.reload();
                    }, 1000);
                }
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

            function selectItem(element) {
                // Remove 'selected' class from all items
                document.querySelectorAll('.horizontal-scroll-item').forEach(item => {
                    item.classList.remove('selected');
                });
                // Add 'selected' class to the clicked item
                element.classList.add('selected');
                selectedJewelryID = element.getAttribute("data-id");
                var currentBid = element.getAttribute("data-currentbid");
                document.getElementById("textMessage").value = currentBid;

                // Update item details
                var details = element.getAttribute("data-details").split(';');
                document.getElementById('detailName').textContent = "Name: " + details[0];
                document.getElementById('detailCategory').textContent = "Category: " + details[1];
                document.getElementById('detailArtist').textContent = "Artist: " + details[2];
                document.getElementById('detailMinPrice').textContent = "Min Price: $" + details[3];
                document.getElementById('detailMaxPrice').textContent = "Max Price: $" + details[4];
                document.getElementById('detailMaterial').textContent = "Material: " + details[5];
                document.getElementById('detailCondition').textContent = "Condition: " + details[6];

                // Update URL parameter (optional)
                updateURLParameter();
            }

            function updateURLParameter() {
                if (selectedJewelryID !== null) {
                    var url = new URL(window.location.href);
                    url.searchParams.set('jewelryID', selectedJewelryID);
                    history.pushState({}, '', url);
                }
            }

            function sendAllItems() {
                var items = document.querySelectorAll('.horizontal-scroll-item');
                if (items.length > 0) {
                    let index = 0;
                    function sendNextItem() {
                        if (index < items.length) {
                            let item = items[index];
                            selectItem(item);
                            setTimeout(() => {
                                if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
                                    let finishedMessage = {
                                        status: "finished",
                                        selectedJewelryID: item.getAttribute('data-id')
                                    };
                                    console.log("Sending finished message:", finishedMessage);
                                    websocket.send(JSON.stringify(finishedMessage));
                                    index++;
                                    sendNextItem(); // Move to the next item
                                }
                            }, 1000); // 1 second delay between each item (adjust as needed)
                        }
                    }
                    sendNextItem();
                }
            }
        </script>
    </body>
</html>
