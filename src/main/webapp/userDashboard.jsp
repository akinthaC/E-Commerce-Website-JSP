<%@ page import="lk.ijse.ecommercewebsitejsp.DTO.UserDTO" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.BO.BOFactory" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.BO.custome.ProductBO" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.Listner.ServletContextHolder" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.DTO.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_forward_ios" />
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/CSS/userDashboard.css">
    <link rel="stylesheet" href="assets/CSS/product-page.css">
    <script src="assets/lib/jquery-3.7.1.min.js" ></script>

    <style>

        .slider-container {
            position: relative;
            width: 100%;
            max-width: 1200px; /* Limit the slider width */
            margin: 50px auto;
            overflow: hidden; /* Ensure only one card is visible */
        }

        .slider {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }

        .card {
            min-width: 100%; /* Each card takes full width of the container */
            height: 300px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .card img {
            width: 100%;
            height: auto;
            transition: transform 0.5s ease;
        }

        .card:hover img {
            transform: scale(1.1); /* Zoom image on hover */
        }

        .card .card-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .card h1 {
            margin: 0;
            font-size: 2rem;
            font-weight: 600;
            color: #ffc107;
        }

        .card p {
            margin: 10px 0;
            font-size: 1rem;
            font-weight: 400;
            color: white;
        }

        .card button {
            padding: 10px 20px;
            font-size: 1.1rem;
            background-color: #ffc107;
            color: #070707;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .card button:hover {
            background-color: #0056b3;
        }

        .price {
            font-size: 1rem;
            color: #28a745;
            font-weight: bold;
        }
        .qty {
            font-size: 0.9rem;
            color: #6c757d;
        }

    </style>

</head>
<body class="bg-dark text-white"
>
<%

    UserDTO user = (UserDTO) session.getAttribute("currentUser");

%>

<%
    Integer cartCount = (Integer) session.getAttribute("cartCount");
    if (cartCount == null) {
        cartCount = 0; // Default to 0 if no cart count is stored in the session
    }
%>
<script>
    // Set the initial cart count from the session
    let cartCount = <%= cartCount %>;
    updateCartCount(cartCount); // Update the cart count on the page load
</script>


<header class="bg-warning py-3">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <!-- Logo -->
            <div class="logo fw-bold fs-4">DOLTONS</div>

            <!-- Navigation Links -->
            <nav>
                <a href="#" class="text-black fw-bold mx-3 text-decoration-none">HOME</a>
                <a href="#" class="text-black fw-bold mx-3 text-decoration-none">CATEGORIES</a>
                <a href="#" class="text-black fw-bold mx-3 text-decoration-none">HELP & CONTACT</a>

                <% if (user == null) { %>
                <!-- If user is not logged in, show LOGIN and SIGNUP -->
                <a href="index.jsp" class="text-black fw-bold mx-3 text-decoration-none">LOGIN</a>
                <a href="index.jsp" class="text-black fw-bold mx-3 text-decoration-none">SIGNUP</a>
                <% } else { %>
                <!-- If user is logged in, show a greeting -->
                <span class="text-black fw-bold mx-3">Hi, <%= user.getName() %>!</span>
                <a href="index.jsp" class="text-black fw-bold mx-3 text-decoration-none">LOGOUT</a>
                <% } %>
            </nav>
        </div>

        <div class="container mt-3">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <input type="text" class="form-control" placeholder="Search Here" id="searchInput">
                </div>
                <div class="col-md-3">
                    <button class="btn btn-dark text-warning w-100" id="searchButton"><i class="fas fa-search"></i> Search</button>
                </div>
                <div class="col-md-1 text-center">
                    <div id="cart">
                        <i id="cartIcon" class="fas fa-shopping-cart fs-3 text-black" style="cursor: pointer; position: fixed; top: 75px; right: 260px;"></i>

                        <span id="cartCount" class="badge bg-danger">3</span> <!-- Cart Count -->
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="container mt-3 text-center">
        <div class="d-flex justify-content-center flex-wrap">
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Saved</a>
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Electronic</a>
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Motors</a>
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Fashion</a>
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Home & Garden</a>
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Sport</a>
            <a href="#" class="text-black fw-bold mx-3 text-decoration-none">Collection & Art</a>
        </div>
    </div>
</header>

<!-- Main Content -->
<div class="container mt-5">
    <div class="slider-container">
        <div class="slider">
            <!-- Card 1 -->
            <div style="background: black" class="card">
                <div class="card-content">
                    <h1>Card 1 Title</h1>
                    <p>This is a description for Card 1. You can add more details here.</p>
                    <button>Shop Now</button>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="card">
                <img src="assets/img.png" alt="Card 2">
                <div class="card-content">
                    <h1>Card 2 Title</h1>
                    <p>This is a description for Card 2. You can add more details here.</p>
                    <button>Shop Now</button>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="card">
                <img src="assets/img_1.png" alt="Card 3">
                <div class="card-content">
                    <h1>Card 3 Title</h1>
                    <p>This is a description for Card 3. You can add more details here.</p>
                    <button>Shop Now</button>
                </div>
            </div>

            <!-- Card 4 -->
            <div class="card">
                <img src="assets/img_3.png" alt="Card 4">
                <div class="card-content">
                    <h1>Card 4 Title</h1>
                    <p>This is a description for Card 4. You can add more details here.</p>
                    <button>Shop Now</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="categories" class="container text-center my-3">
    <div class="row gap-6"> <!-- Added 'gap-3' for column spacing -->
        <div class="col">
            <div class="circle">
                <img src="assets/img.png" alt="Image 1" />
            </div>
            <p>Sport</p>
        </div>
        <div class="col">
            <div class="circle">
                <img src="assets/img_1.png" alt="Image 2" />
            </div>
            <p>TEXT 02</p>
        </div>
        <div class="col">
            <div class="circle">
                <img src="assets/img_1.png" alt="Image 3" />
            </div>
            <p>TEXT 03</p>
        </div>
        <div class="col">
            <div class="circle">
                <img src="assets/uploads/img_2.png" alt="Image 4" />
            </div>
            <p>TEXT 04</p>
        </div>
        <div class="col">
            <div class="circle">
                <img src="assets/uploads/img_1.png" alt="Image 5" />
            </div>
            <p>TEXT 05</p>
        </div>
    </div>
</div>

<section class="products">
    <h1>Most Selling Items</h1>
    <main class="container3 swiper wow animate__animated animate__zoomIn">
        <div class="slider-wrapper">
            <div class="card-list swiper-wrapper">
                <%-- Loop through the products list passed from the servlet --%>
                <%
                    ProductBO productBO = (ProductBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.PRODUCT);
                    BasicDataSource ds = (BasicDataSource) ServletContextHolder.getServletContext().getAttribute("datasource");

                    List<ProductDTO> products = productBO.getAllProducts(ds);
                    if (products != null) {
                        for (ProductDTO product : products) {
                %>
                    <div class="card-item swiper-slide"
                         data-id="<%= product.getId() %>"
                         data-price="<%= String.format("%.2f", product.getPrice()) %>"
                         data-qty="<%= product.getStock() %>">
                        <img src="<%= product.getMainImage() %>" alt="<%= product.getName() %>">
                        <p class="badge"><%= product.getName() %></p>
                        <p class="price">Price: $<%= String.format("%.2f", product.getPrice()) %></p>
                        <p class="qty">Qty Available: <%= product.getStock() %></p>
                        <div class="product-buttons">
                            <button class="buy-now-btn">Buy Now</button>
                            <button class="add-to-cart-btn" onclick="addToCart(this)">Add to Cart</button>
                        </div>
                    </div>

                    <%
                        }
                    }
                %>
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </main>
</section>


<section class="products">
    <h1>Most Selling Items</h1>
    <main class="container3 swiper wow animate__animated animate__zoomIn">
        <div class="slider-wrapper">
            <div class="card-list swiper-wrapper">
                <%-- Loop through the products list passed from the servlet --%>
                <%

                    if (products != null) {
                        for (ProductDTO product : products) {
                %>
                <div class="card-item swiper-slide"
                     data-id="<%= product.getId() %>"
                     data-price="<%= String.format("%.2f", product.getPrice()) %>"
                     data-qty="<%= product.getStock() %>">
                    <img src="<%= product.getMainImage() %>" alt="<%= product.getName() %>">
                    <p class="badge"><%= product.getName() %></p>
                    <p class="price">Price: $<%= String.format("%.2f", product.getPrice()) %></p>
                    <p class="qty">Qty Available: <%= product.getStock() %></p>
                    <div class="product-buttons">
                        <button class="buy-now-btn">Buy Now</button>
                        <button class="add-to-cart-btn" data-product-id="<%= product.getId() %>" data-quantity="1">Add to Cart</button> <!-- Add data-product-id attribute -->
                    </div>
                </div>

                <%
                        }
                    }
                %>
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </main>
</section>

<div class="modal fade" id="addToCartModal" tabindex="-1" aria-labelledby="addToCartModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addToCartModalLabel">Shopping Cart</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%
                    String dbURL = "jdbc:mysql://localhost:3306/e_commerce_website";
                    String dbUsername = "root";
                    String dbPassword = "Ijse@123";
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    int userId = user.getId(); // Ensure userId is valid

                    try {
                        // Establish database connection
                        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                        // SQL query to fetch cart details
                        String sql = "SELECT c.cart_id, c.product_id, p.product_name, c.quantity, p.price, c.added_date " +
                                "FROM cart c JOIN products p ON c.product_id = p.product_id " +
                                "WHERE c.user_id = ?";

                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, userId); // Use the correct userId

                        // Execute query
                        rs = pstmt.executeQuery();
                %>

                <!-- Check if cart data is available -->
                <table class="table">
                    <thead>
                    <tr>
                        <th>Cart ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                        <th>Added Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        // Loop through ResultSet and display cart data
                        if (rs != null) {
                            while (rs.next()) {
                                int cartId = rs.getInt("cart_id");
                                String productName = rs.getString("product_name");
                                int quantity = rs.getInt("quantity");
                                double price = rs.getDouble("price");
                                Timestamp addedDate = rs.getTimestamp("added_date");
                                double total = price * quantity;
                    %>
                    <tr>
                        <td><%= cartId %></td>
                        <td><%= productName %></td>
                        <td><%= quantity %></td>
                        <td><%= String.format("%.2f", price) %></td>
                        <td><%= String.format("%.2f", total) %></td>
                        <td><%= addedDate %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">Your cart is empty.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <%
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>
    </div>
</div>


<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="product.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        let currentIndex = 0; // Initial index to start from
        const cards = document.querySelectorAll('.card');
        const totalCards = cards.length;

        // Function to move to the next card
        function moveSlide() {
            // Remove the 'active' class from all cards
            cards.forEach(card => card.classList.remove('active'));

            // Add the 'active' class to the current card
            cards[currentIndex].classList.add('active');

            // Increment index for next slide, loop back to 0 if exceeds total cards
            currentIndex = (currentIndex + 1) % totalCards;
        }

        // Auto-slide functionality
        function autoSlide() {
            moveSlide();
        }

        // Initial slide
        moveSlide();  // Ensure the first card is shown

        // Set an interval for auto-sliding every 5 seconds (5000ms)
        setInterval(autoSlide, 5000);
    });

</script>

<script>
    // Function to update the cart count
    function updateCartCount(count) {
        document.getElementById('cartCount').textContent = count;
    }

    // Add event listener to each "Add to Cart" button
    document.querySelectorAll('.add-to-cart-btn').forEach(button => {
        button.addEventListener('click', function() {

            const productId = this.getAttribute('data-product-id');
            const quantity = this.getAttribute('data-quantity') || 1;  // Default quantity is 1 if not specified


            // Ensure quantity and price are valid numbers
            if (isNaN(quantity) ) {
                alert('Invalid quantity or price');
                return;
            }

            // Send an AJAX request to the servlet
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'addToCart-servlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    // Update cart count
                    const updatedCartCount = parseInt(xhr.responseText);
                    updateCartCount(updatedCartCount); // Update the cart count in the UI
                    alert('Item added to cart!');
                } else {
                    alert('Error adding item to cart');
                }
            };
            xhr.send('productId=' + productId + '&quantity=' + quantity );
        });
    });
</script>
<script>
    document.getElementById('cartIcon').addEventListener('click', function() {
        // Open the modal
        var addToCartModal = new bootstrap.Modal(document.getElementById('addToCartModal'));
        addToCartModal.show();
    });
</script>

<script>
    // Initialize cart count
    let cartCount = 0;

    // Function to update the cart count
    function updateCartCount() {
        const cartCountElement = document.getElementById('cartCount');
        cartCountElement.textContent = cartCount; // Update the count displayed in the cart icon
    }

    // Example function to simulate adding an item to the cart
    function addToCart() {
        cartCount++; // Increase cart count by 1
        updateCartCount(); // Update the cart count display
        alert('Item added to cart!'); // Show alert after adding to cart
    }

    // Add event listener to "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart-btn').forEach(button => {
        button.addEventListener('click', addToCart);
    });
</script>




</body>
</html>