<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="dbconnect.jsp" %>
    <%@ include file="navbar.jsp" %>
    <title>CART</title>
    <link rel="stylesheet" href="cart.css">
</head>
<body>
    <%
    try{
        String email = (String)session.getAttribute("email");
        Statement stmt=con.createStatement();
        
        ResultSet rs=stmt.executeQuery("select product_name, price, discount, price, item.quantity, cart.quantity,cart.product_id from item, cart where cart.product_id=item.product_id and cart.email='"+email+"'");
        boolean flag = false;
        int total_payable = 0;
        
%>
    <div class="container">
        <div class="cart-div">
            <form action="./place_order.jsp" method="post">
            <div class="cart-box">
                <h2>My Cart</h2>
                <%
        while(rs.next()){
            flag = true;
            int final_price = (rs.getInt(4)*(100 - rs.getInt(3)))/100;
            total_payable += (final_price * rs.getInt(6));
            String imgName = rs.getString(7) + ".jpg";
            String img_path = "./image/";
%>
            <form action="./remove_from_cart.jsp">
                <div class="cart-product">
                    <div class="c-product-img">
                        <img src="<%= img_path+imgName %>" alt="./image/product-1.jpg" onerror="this.onerror=null; this.src='./image/default.jpg'">
                    </div>
                    <div class="c-product-details">
                        <h4><%= rs.getString(1) %></h4>
                        <h3><span>&#8377;</span><%= final_price %></h3>
                    </div>
                    <input type="number" value="<%= rs.getInt(6) %>" min="0" max="9">
                    <input type="submit" value="REMOVE">
                </div>
            </form>
                <%
        }
        
%>
<%
        
        if(flag){
%>           
                <div class="order-div">
                    <!-- <input type="submit" value="REFRESH PRICE"> -->
                    <input type="submit" value="PLACE ORDER">
                </div>
            </div>
            <div class="price-details-div">
                <h2>PRICE DETAILS</h2>
                <div class="cart-price">
                    
                    <p>Price</p>
                    <p><span>&#8377;</span><%= total_payable %></p>
                    <p>Delivery Charge</p>
                    <p class="green">FREE</p>
                    <hr>
                    <h4>Total Amount</h4>
                    <h4><span>&#8377;</span><%= total_payable %></h4>
                </div>
            </div>
        </form>
        </div>
        
    </div>
    <%
}if(flag == false){
    %>
    <p>Oops your cart is empty!</p>
    <p>Continue shopping <a href="./index.jsp">Shop Now</a></p>

    <%
}
    con.close();
    
    } catch (Exception e){
    }

%>
    
</body>
</html>