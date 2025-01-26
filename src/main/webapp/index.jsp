<%@ page import="lk.ijse.ecommercewebsitejsp.DTO.UserDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Login & Sign-Up Slider</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
    <!-- Include SweetAlert2 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(-135deg, #070707, #070707, #ffd700);
            min-height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            position: relative;
            width: 900px;
            height: 650px;
            background-color: transparent;
            border-radius: 15px;
            overflow: hidden;
            display: flex;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        /* Form Containers */
        .form-container {
            position: absolute;
            width: 50%;
            height: 100%;
            padding: 50px 30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: rgba(178, 184, 192, 0.33);
            color: #fff;
            box-sizing: border-box;
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.3);
            transition: all 0.8s cubic-bezier(0.68, -0.55, 0.27, 1.55);
        }

        .form-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #FFD700;
        }

        .form-container form {
            width: 100%;
            display: flex;
            flex-direction: column;
        }

        .form-container form .form-group {
            margin-bottom: 15px;
        }

        .form-container form .form-group label {
            font-size: 14px;
            color: #FFD700;
            margin-bottom: 5px;
            display: block;
        }

        .form-container form .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #FFD700;
            border-radius: 5px;
            background-color: #333;
            box-sizing: border-box;
            color: #FFD700;
        }

        .form-container form button {
            background-color: #FFD700;
            color: #333;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-container form button:hover {
            background-color: #FFC107;
        }

        .form-container .forgot-password {
            margin-top: 10px;
            font-size: 14px;
            color: #FFD700;
            text-decoration: none;
        }

        .form-container .forgot-password:hover {
            color: #FFC107;
        }

        .login-container {
            left: 0;
            transform: translateX(0);
            opacity: 1;
            z-index: 2;
        }

        .signup-container {
            right: 0;
            transform: translateX(100%);
            opacity: 0;
            z-index: 1;
        }

        /* Overlay */
        .overlay {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            background: linear-gradient(-35deg, #000, #FFD700);
            display: flex;
            justify-content: center;
            align-items: center;
            transition: all 0.8s cubic-bezier(0.68, -0.55, 0.27, 1.55);
            z-index: 3;
        }

        .overlay-content {
            text-align: center;
            color: #fff;
        }

        .overlay-content h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .overlay-content p {
            font-size: 14px;
            margin-bottom: 20px;
        }

        .overlay-content button {
            background: transparent;
            border: 2px solid #fff;
            color: #fff;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .overlay-content button:hover {
            background: #fff;
            color: #000;
        }

        /* Active State Animations */
        .container.active .login-container {
            transform: translateX(-100%);
            opacity: 0;
        }

        .container.active .signup-container {
            transform: translateX(0);
            opacity: 1;
            z-index: 2;
        }

        .container.active .overlay {
            transform: translateX(-100%);
        }

        /* Password show/hide button */
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 20px;
            color: #FFD700;
            user-select: none;
        }

        /* Password Strength Checker */
        .password-strength {
            margin-top: 5px;
            font-size: 12px;
            color: #FFD700;
            font-weight: 500;
        }

        .password-Conform{
            margin-top: 5px;
            font-size: 12px;
            color: #FFD700;
            font-weight: 500;
        }

        .strength-text {
            display: none; /* Hide all by default */
        }

        .conform-text{
            display: none;
        }

        #weak {
            color: red;
        }

        /* Medium */
        #medium {
            color: orange;
        }

        /* Strong */
        #strong {
            color: green;
        }

        #Correct{
            color: green;
        }

        #InCorrect{
            color: red;
        }
        #usernameMessage {
            color: red;
            font-size: 12px;
            visibility: hidden;
        }
    </style>
</head>
<body>
<%
    String message= request.getParameter("message");
    String error= request.getParameter("error");
    String type = request.getParameter("type");
    UserDTO currentUser = (UserDTO) session.getAttribute("currentUser");

%>




    <% if (message != null) { %>
<script>
    const userRole = '<%= type %>';
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: '<%= message %>',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'OK'
    }).then(() => {
        if (userRole === 'Admin') {
            window.location.href = "adminDashboard.jsp";
        } else if (userRole === 'User') {
            window.location.href = "userDashboard.jsp";
        } else {
            alert("Invalid role! Please contact the administrator.");
        }
    });
</script>
    <% } %>


    <% if (error != null) { %>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: '<%= error %>',
        confirmButtonColor: '#d33',
        confirmButtonText: 'Retry'
    });
</script>
    <% } %>


<div class="container" id="authContainer">
    <!-- Login Form -->
    <div class="form-container login-container">
        <h2>Login</h2>
        <form action="Login-Servlet" method="get">
            <div class="form-group">
                <label for="loginUsername">Username</label>
                <input type="text" id="loginUsername" name="username" placeholder="Enter username" required>
            </div>
            <div class="form-group">
                <label for="loginPassword">Password</label>
                <div style="position: relative;">
                    <input type="password" id="loginPassword" name="password" placeholder="Enter password" required>
                    <i class="password-toggle fa fa-eye" id="loginPasswordToggle" onclick="togglePassword('loginPassword')"></i>
                </div>
            </div>
            <a href="#" class="forgot-password">Forgot Password?</a>
            <button type="submit">Login</button>
        </form>
    </div>

    <!-- Signup Form -->
    <div class="form-container signup-container">
        <h2>Sign Up</h2>
        <form action="Register-Servlet" method="POST" >
            <div class="form-group">
                <label for="signupName">Name</label>
                <input type="text" id="signupName" name="name" placeholder="Enter Your Name" required>
            </div>

            <div class="form-group">
                <label for="signupUsername">LoginUsername</label>
                <input type="text" id="signupUsername" name="username" placeholder="Enter username" required>
                <div id="usernameMessage">Username already exists.</div>
            </div>
            <div class="form-group">
                <label for="signupContact">Contact</label>
                <input type="number" id="signupContact" name="contact" placeholder="Enter Contact Number" required>
            </div>
            <div class="form-group">
                <label for="signupEmail">Email</label>
                <input type="email" id="signupEmail" name="email" placeholder="Enter email" required>
            </div>
            <div class="form-group">
                <label for="signupPassword">Password</label>
                <input type="password" id="signupPassword" name="password" placeholder="Enter password" required>
                <!-- Password Strength Checker -->
                <div id="passwordStrength" class="password-strength">
                    <span id="weak" class="strength-text">Weak</span>
                    <span id="medium" class="strength-text">Medium</span>
                    <span id="strong" class="strength-text">Strong</span>
                </div>
            </div>

            <div class="form-group">
                <label for="CoformPassword">Conform Password</label>
                <input type="password" id="CoformPassword" name="confPassword" placeholder="Enter Conform password" required>
                <div id="passwordConform" class="password-Conform">
                    <span id="Correct" class="conform-text">Correct</span>
                    <span id="InCorrect" class="conform-text">InCorrect</span>

                </div>
            </div>
            <button type="submit">Sign Up</button>
        </form>
    </div>

    <!-- Overlay -->
    <div class="overlay">
        <div class="overlay-content" id="overlayContent">
            <h2>Welcome Back!</h2>
            <p>Click below to toggle between login and sign-up.</p>
            <button onclick="toggleAuth()">Go to Sign Up</button>
        </div>
    </div>
</div>
<script src="sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    const container = document.getElementById('authContainer');
    const overlayContent = document.getElementById('overlayContent');
    const passwordField = document.getElementById("signupPassword");
    const passwordField1 = document.getElementById("CoformPassword");
    const weak = document.getElementById("weak");
    const medium = document.getElementById("medium");
    const strong = document.getElementById("strong");
    const correct = document.getElementById("Correct");
    const inCorrect = document.getElementById("InCorrect");


    function toggleAuth() {
        container.classList.toggle('active');
        const isActive = container.classList.contains('active');

        if (isActive) {
            overlayContent.innerHTML = `
                    <h2>Welcome!</h2>
                    <p>Click below to return to login.</p>
                    <button onclick="toggleAuth()">Go to Login</button>
                `;
        } else {
            overlayContent.innerHTML = `
                    <h2>Welcome Back!</h2>
                    <p>Click below to toggle between login and sign-up.</p>
                    <button onclick="toggleAuth()">Go to Sign Up</button>
                `;
        }
    }

    // Password Strength Checker Function
    passwordField.addEventListener("input", function() {
        const password = passwordField.value;
        const strength = getPasswordStrength(password);

        // Hide all strength levels by default
        weak.style.display = "none";
        medium.style.display = "none";
        strong.style.display = "none";

        if (strength === "weak") {
            weak.style.display = "inline";
        } else if (strength === "medium") {
            medium.style.display = "inline";
        } else if (strength === "strong") {
            strong.style.display = "inline";
        }
    });
    // Function to determine password strength
    function getPasswordStrength(password) {
        const lengthCriteria = password.length >= 6;
        const numberCriteria = /[0-9]/.test(password);
        const uppercaseCriteria = /[A-Z]/.test(password);
        const specialCharCriteria = /[^A-Za-z0-9]/.test(password);

        let strength = "weak";

        if (lengthCriteria && (numberCriteria || uppercaseCriteria || specialCharCriteria)) {
            strength = "medium";
        }
        if (lengthCriteria && numberCriteria && uppercaseCriteria && specialCharCriteria) {
            strength = "strong";
        }

        return strength;
    }

    function togglePassword(id) {
        const passwordField = document.getElementById(id);
        const passwordToggle = document.getElementById(id + "Toggle");
        if (passwordField.type === "password") {
            passwordField.type = "text";
            passwordToggle.classList.remove("fa-eye");
            passwordToggle.classList.add("fa-eye-slash"); // Change icon to eye-slash
        } else {
            passwordField.type = "password";
            passwordToggle.classList.remove("fa-eye-slash");
            passwordToggle.classList.add("fa-eye"); // Change icon back to eye
        }
    }

    passwordField1.addEventListener("input", function () {
        const password = passwordField.value;
        const ConfPassword = passwordField1.value;

        correct.style.display="none";
        inCorrect.style.display="none";


        if (password === ConfPassword){
            correct.style.display="inline"
        }else {
            inCorrect.style.display="inline"
        }

    })
</script>


<script>
    $(document).ready(function () {
        $("#signupUsername").on("keyup", function () {
            const username = $(this).val().trim();


            if (username.length > 0) {
                console.log("Checking username:", username);

                // Send AJAX request
                $.ajax({
                    url: "http://localhost:8080/E_Commerce_Website_JSP_war_exploded/Register-Servlet",
                    type: "GET",
                    data: { username: username }, // Pass the username as a query parameter
                    success: function (response) {
                        console.log("Server Response:", response);

                        const messageElement = $("#usernameMessage");
                        if (response.trim() === "true") {
                            messageElement.css("visibility", "visible").text("Username already exists!");
                        } else {
                            messageElement.css("visibility", "hidden").text("");
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error occurred:", error);
                    },
                });
            } else {

                $("#usernameMessage").css("visibility", "hidden").text("");
            }
        });
    });
</script>

</body>
</html>