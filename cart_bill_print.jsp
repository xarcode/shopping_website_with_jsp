<%@ include file="dbconnect.jsp" %>
<%

    String email = (String)session.getAttribute("email");
    Statement tempStmt = con.createStatement();
    ResultSet temptable = tempStmt.executeQuery("select * from temp_order");
    while(temptable.next()){
        String order_id = temptable.getString(1);
        Statement stmt = con.createStatement();
        ResultSet rs=stmt.executeQuery("select * from users where email='"+email+"'");
        Statement stmt1 = con.createStatement();
        ResultSet rs1=stmt1.executeQuery("select * from orders where order_id='" + order_id + "'");
        rs.next();
        rs1.next();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Tax Invoice</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TAX INVOICE</title>
    <link rel="stylesheet" href="./bill.css">
</head>

<body onload="window.print()">
    <div class="container">
        <div class="col-2">

            <div class="bill-ship order-div">
                <h1>Bill To</h1>
                <div class="delivery-address-div">
                    <p class="label">Name </p>
                    <p><%= rs.getString("name") %></p>
                    <p class="label">Email </p>
                    <p><%= rs.getString("email") %></p>
                    <p class="label">Phone </p>
                    <p><%= rs.getString("phone") %></p>
                    <p class="label">Address</p>
                    <p><%= rs.getString("address") %></p>
                    <p class="label">Pincode</p>
                    <p><%= rs.getString("pincode") %></p>
                </div>
            </div>
            <div class="bill-ship order-div">
                <h1>Ship To</h1>
                <div class="delivery-address-div">
                    <p class="label">Name </p>
                    <p><%= rs1.getString("shipping_name") %></p>
                    <p class="label">Email </p>
                    <p><%= rs1.getString("shipping_email") %></p>
                    <p class="label">Phone </p>
                    <p><%= rs1.getString("shipping_phone") %></p>
                    <p class="label">Address</p>
                    <p><%= rs1.getString("shipping_address") %></p>
                    <p class="label">Pincode</p>
                    <p><%= rs1.getString("shipping_pincode")%></p>
                </div>
            </div>
        </div>
        <div class="col-2">
            <div class="tax-invoice order-div">
                <h1>Tax Invoice</h1>
                <div class="delivery-address-div">
                    <p class="label">Order Id</p>
                    <p><%= order_id %></p>
                    <p class="label">Date </p>
                    <p><%= rs1.getString("buy_date") %></p>
                    <p class="label">Time </p>
                    <p><%= rs1.getString("buy_time") %></p>

                </div>
            </div>
            <div class="order-div">
                <h1>Order Details</h1>
                <div class="product-details-div">
                    <div class="product-details">
                        <h3><%= rs1.getString("product_name") %></h3>
                        <p>Price: <span>&#8377;</span><%= pretty_print_price(rs1.getString("price")) %></p>
                        <p>Quantity: <span><%= rs1.getString("quantity") %></span></p>
                        <p>Payable: <span><%= pretty_print_price(rs1.getString("total_payable")) %></span></p>
                        <p>Payment Method: <span><%= rs1.getString("payment_method") %></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>    
</body>
</html>
