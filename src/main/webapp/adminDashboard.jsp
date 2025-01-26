<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.DTO.ProductDTO" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.BO.custome.ProductBO" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.BO.BOFactory" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.Listner.ServletContextHolder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO" %>
<%@ page import="lk.ijse.ecommercewebsitejsp.BO.custome.CategoryBO" %><%--
  Created by IntelliJ IDEA.
  User: akint
  Date: 23/01/2025
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>





<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">


<style>
    /* Custom Sidebar Styling */
    .sidebar {
        height: 110vh;
        width: 25%;
        background-color: #333;
        color: #fff;
        padding: 20px;
    }
    .sidebar h2 {
        text-align: center;
        color: #ffc107;
    }
    .sidebar a {
        text-decoration: none;
        color: #fff;
        display: block;
        padding: 10px;
        margin: 5px 0;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .sidebar a:hover, .sidebar a.active {
        background-color: #ffc107;
        color: #000;
    }

    #content{
        width: 100%;
    }
    #product h2 {
        font-weight: bold;
        color: #007bff;
    }

    #product .table img {
        border-radius: 5px;
    }

    #addProductModal .modal-content {
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    #imagePreview img {
        margin-top: 10px;
        display: block;
    }
    .sidebar-btn {
        display: block;
        padding: 10px 15px;
        text-decoration: none;
        color: #fff;
        background-color: #333;
        border: none;
        margin-bottom: 10px;
        border-radius: 4px;
        text-align: center;
        width: 100%;
    }

    /* Active state */
    .sidebar-btn.active {
        background-color: #ffff00;
        color: #333;
    }
    .sidebar-btn:hover {
        background-color: yellow;
        color: #333; /* Optional: change text color when hovered */
    }

    .tab-content {
        margin-top: 20px;
    }
    .tab-btn {
        margin-right: 15px;
    }
    .btn-custom {
        width: 100%;
    }


</style>
</head>
<body>




<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <button id="DashboardNav" class="sidebar-btn active">Dashboard</button>
        <button type="submit" class="sidebar-btn" id="ProductNav">Product Management</button>
        <button id="categoryNav" class="sidebar-btn">Category Management</button>
        <button id="userNav" class="sidebar-btn">User Management</button>
    </div>




    <div id="content">
        <!-- Main Content -->
        <section id="home-section">
            <div class="container-fluid p-4">
                <h2 class="mb-4 text-center">Admin Dashboard</h2>

                <div class="row text-center mb-3">
                    <div class="col-3">
                        <div class="bg-primary text-white p-2 rounded">
                            <h4>Total Users</h4>
                            <h4 id="totalUsers">150</h4>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="bg-success text-white p-2 rounded">
                            <h4>Total Categories</h4>
                            <h4 id="totalCategories">10</h4>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="bg-warning text-dark p-2 rounded">
                            <h4>Weekly Revenue</h4>
                            <h4 id="weeklyRevenue">$5,000</h4>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="bg-danger text-white p-2 rounded">
                            <h4>Total Orders</h4>
                            <h4 id="totalOrders">320</h4>
                        </div>
                    </div>
                </div>


                <!-- Add Banner Section -->
                <div>
                    <h3>Banners</h3>
                    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addBannerModal">Add Banner</button>
                    <table class="table table-bordered">
                        <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Example Banners -->
                        <tr>
                            <td>1</td>
                            <td><img src="uploads/banner1.jpg" alt="Banner" style="width: 100px;"></td>
                            <td>Summer Sale</td>
                            <td>Enjoy up to 50% off</td>
                            <td>
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editBannerModal">Edit</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Add Categories Section -->
                <div class="mt-5">
                    <h3>Categories</h3>
                    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addCategoryModal">Add Category</button>
                    <table class="table table-bordered">
                        <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Example Categories -->
                        <tr>
                            <td>1</td>
                            <td>Electronics</td>
                            <td><img src="uploads/category1.jpg" alt="Category Image" style="width: 100px;"></td>
                            <td>
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editCategoryModal">Edit</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Edit Banner Modal -->
            <div class="modal fade" id="editBannerModal" tabindex="-1" aria-labelledby="editBannerModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editBannerModalLabel">Edit Banner</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="mb-3">
                                    <label for="bannerTitle" class="form-label">Title</label>
                                    <input type="text" class="form-control" id="bannerTitle" placeholder="Enter Banner Title" value="Summer Sale">
                                </div>
                                <div class="mb-3">
                                    <label for="bannerDescription" class="form-label">Description</label>
                                    <textarea class="form-control" id="bannerDescription" placeholder="Enter Description" rows="3">Enjoy up to 50% off</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="bannerImage" class="form-label">Image</label>
                                    <input type="file" class="form-control" id="bannerImage">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Category Modal -->
            <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="mb-3">
                                    <label for="categoryName" class="form-label">Category Name</label>
                                    <input type="text" class="form-control" id="categoryName" placeholder="Enter Category Name" value="Electronics">
                                </div>
                                <div class="mb-3">
                                    <label for="categoryImage" class="form-label">Image</label>
                                    <input type="file" class="form-control" id="categoryImage">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="productSection" style="display: none;" class="p-4">
            <div class="container-fluid">
                <h2 class="text-center mb-4">Product Management</h2>

                <!-- Add Product Button (Triggers Request to Get Categories) -->
                <button class="btn btn-primary mb-4" type="button" data-bs-toggle="modal" data-bs-target="#addProductModal" onclick="loadCategories();">
                    Add Product
                </button>


                <!-- Product Table -->
                <table class="table table-bordered">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Main Image</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Sample Images</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="productTableBody">
                    <!-- Use a scriptlet to iterate over the product list -->
                    <%
                        ArrayList<ProductDTO> productDTOArrayList = new ArrayList<>();
                        ProductBO productBO = (ProductBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.PRODUCT);
                        BasicDataSource ds = (BasicDataSource) ServletContextHolder.getServletContext().getAttribute("datasource");


                        List<ProductDTO> productDTOList = productBO.getAllProducts(ds);
                        System.out.println(productDTOList.size());

                        if (productDTOList != null) {
                            for (ProductDTO product : productDTOList) {
                                System.out.println(product);
                    %>
                    <tr>
                        <td><%= product.getId() %></td>
                        <td><img src="<%= product.getMainImage() %>" alt="Main Image" style="width: 100px;"></td>
                        <td><%= product.getName() %></td>
                        <td><%= product.getCategory() %></td>
                        <td><%= product.getPrice() %></td>
                        <td><%= product.getStock() %></td>
                        <td>
                            <%
                                // Retrieve the sampleImages list from the ProductDTO object
                                List<String> sampleImages = product.getSampleImages();

                                // Check if the sampleImages list is not null and contains images
                                if (sampleImages != null && !sampleImages.isEmpty()) {
                                    // Loop through each image in the sampleImages list
                                    for (String image : sampleImages) {
                            %>
                            <!-- Generate an <img> tag for each image with spacing -->
                            <img src="<%= image %>" alt="Sample Image" style="width: 50px; height: auto; margin-right: 10px; margin-bottom: 5px;">
                            <%
                                }
                            } else {
                            %>
                            <!-- Display a message if there are no images available -->
                            <span>No Images Available</span>
                            <%
                                }
                            %>
                        </td>

                        <td>
                            <button type="button" class="btn btn-warning btn-sm edit-btn"
                                    data-bs-toggle="modal" data-bs-target="#editProductModal"
                                    data-productid="<%= product.getId() %>"
                                    data-productname="<%= product.getName() %>"
                                    data-productcategory="<%= product.getCategory() %>"
                                    data-productprice="<%= product.getPrice() %>"
                                    data-productstock="<%= product.getStock() %>"
                                    data-productmainimage="<%= product.getMainImage() %>"
                                    data-productsampleimages="<%= product.getSampleImages() %>"
                            onclick="loadCategories2()">
                                Edit
                            </button>
                            <a href="deleteProduct?id=<%= product.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                        </td>



                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </section>

        <section id="categorySection" style="display: none;" class="p-4">
            <div class="container-fluid">
                <h2 class="text-center mb-4">Category Management</h2>

                <!-- Add Category Button (Triggers Request to Get Categories) -->
                <button class="btn btn-primary mb-4" type="button" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    Add Category
                </button>

                <!-- Category Table -->
                <table class="table table-bordered">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Category Name</th>
                        <th>Description</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="categoryTableBody">
                    <!-- Use a scriptlet to iterate over the category list -->
                    <%
                        CategoryBO categoryBO = (CategoryBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.CATEGORY);


                        List<CategoryDTO> categoryDTOList = categoryBO.getAllCategories(ds);

                        if (categoryDTOList != null) {
                            for (CategoryDTO category : categoryDTOList) {
                    %>
                    <tr>
                        <td><%= category.getCategoryId() %></td>
                        <td><%= category.getCategoryName() %></td>
                        <td><%= category.getDescription() %></td>
                        <td><img src="<%= category.getImage() %>" alt="Category Image" style="width: 100px;"></td>

                        <td>
                            <!-- Edit Category Button -->
                            <button type="button" class="btn btn-warning btn-sm categoryEdit-btn"
                                    data-bs-toggle="modal" data-bs-target="#editCategoryModal11"
                                    data-category-id="<%= category.getCategoryId() %>"
                                    data-category-name="<%= category.getCategoryName() %>"
                                    data-category-description="<%= category.getDescription() %>"
                                    data-category-image="<%= category.getImage() %>"
                                    onclick="populateCategoryForm(this)">
                                Edit
                            </button>

                            <!-- Delete Category Link -->
                            <form action="DeleteCategory-Servlet" method="get" style="display: inline;">
                                <!-- Include a hidden input to send the category ID -->
                                <input type="hidden" name="id" value="<%= category.getCategoryId() %>">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this category?');">
                                    Delete
                                </button>
                            </form>

                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </section>

        <section id="userSection">
            <div class="container mt-5">
                <h2 class="text-center mb-4">Manage Users & Admins</h2>

                <!-- Tab Buttons -->
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" id="user-tab" data-toggle="tab" href="#user-management">User Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="admin-tab" data-toggle="tab" href="#admin-management">Admin Management</a>
                    </li>
                </ul>

                <!-- Tab Contents -->
                <div class="tab-content">
                    <!-- User Management Tab -->
                    <div class="tab-pane fade show active" id="user-management">
                        <h3 class="mt-4">Add New User</h3>
                        <form action="AddUserServlet" method="POST">
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="form-group">
                                <label for="role">Role:</label>
                                <select class="form-control" id="role" name="role" required>
                                    <option value="User">User</option>
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Add User</button>
                        </form>

                        <hr>

                        <h3>Existing Users</h3>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Dynamically generated users list -->
                            <tr>
                                <td>john_doe</td>
                                <td>john.doe@example.com</td>
                                <td>User</td>
                                <td>Active</td>
                                <td>
                                    <a href="restrictAccount?userId=1" class="btn btn-warning btn-sm">Restrict</a>
                                    <a href="deleteUser?userId=1" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                            <!-- More users would be listed dynamically from the database -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Admin Management Tab -->
                    <div class="tab-pane fade" id="admin-management">
                        <h3 class="mt-4">Add New Admin</h3>
                        <form action="AddAdminServlet" method="POST">
                            <div class="form-group">
                                <label for="adminUsername">Admin Username:</label>
                                <input type="text" class="form-control" id="adminUsername" name="adminUsername" required>
                            </div>
                            <div class="form-group">
                                <label for="adminEmail">Admin Email:</label>
                                <input type="email" class="form-control" id="adminEmail" name="adminEmail" required>
                            </div>
                            <div class="form-group">
                                <label for="adminPassword">Admin Password:</label>
                                <input type="password" class="form-control" id="adminPassword" name="adminPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Add Admin</button>
                        </form>

                        <hr>

                        <h3>Existing Admins</h3>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Admin Username</th>
                                <th>Admin Email</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Dynamically generated admin list -->
                            <tr>
                                <td>admin_user</td>
                                <td>admin@example.com</td>
                                <td>
                                    <a href="deleteAdmin?adminId=1" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                            <!-- More admins would be listed dynamically from the database -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>



    </div>

</div>


<!-- Edit Category Modal -->
<div class="modal fade" id="editCategoryModal11" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Edit Form for Category -->
                <form action="EditCategory-Servlet" method="post" enctype="multipart/form-data">
                    <!-- Category ID (Hidden) -->
                    <input type="hidden" name="categoryId" value="1" id="editCategoryId">

                    <!-- Category Name -->
                    <div class="mb-3">
                        <label for="editCategoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="editCategoryName" name="categoryName" required>
                    </div>

                    <!-- Category Description -->
                    <div class="mb-3">
                        <label for="editCategoryDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editCategoryDescription" name="categoryDescription" rows="3" required></textarea>
                    </div>

                    <!-- File Input and Preview -->
                    <div class="mb-3">
                        <label for="editCategoryImage" class="form-label">Choose Image</label>
                        <input type="file" class="form-control" id="editCategoryImage" name="categoryImage" accept="image/*" onchange="previewEditMainImage1(event)" required>
                        <div class="mb-3">
                            <img id="imagePreview1" src="" alt="Image Preview" class="img-fluid" style="display:none; max-height: 200px;">
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-success w-100">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addCategoryForm" action="AddCategory-Servlet" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="categoryDescription" name="description" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="categoryImage" class="form-label">Choose Image</label>
                        <input type="file" class="form-control" id="categoryImage" name="image" accept="image/*" onchange="previewImage(event)">
                    </div>
                    <!-- Image Preview Section -->
                    <div class="mb-3">
                        <img id="imagePreview" src="" alt="Image Preview" style="max-width: 100%; height: auto; display: none;">
                    </div>
                    <button type="submit" class="btn btn-primary">Add Category</button>
                </form>
            </div>
        </div>
    </div>
</div>

 <!-- Edit Product Modal -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="editProduct" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="productId" id="editProductId">

                            <div class="row">
                                <!-- Product Name -->
                                <div class="col-md-6 mb-3">
                                    <label for="editProductName" class="form-label">Product Name</label>
                                    <input type="text" name="productName" id="editProductName" class="form-control" placeholder="Enter product name" required>
                                </div>

                                <!-- Product Category -->
                                <div class="col-md-6 mb-3">
                                    <label for="editProductCategory" class="form-label">Category</label>
                                    <select name="productCategory" id="editProductCategory" class="form-select" required contenteditable="true">

                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Product Price -->
                                <div class="col-md-6 mb-3">
                                    <label for="editProductPrice" class="form-label">Price</label>
                                    <input type="number" name="productPrice" id="editProductPrice" class="form-control" placeholder="Enter price" step="0.01" required>
                                </div>

                                <!-- Product Stock -->
                                <div class="col-md-6 mb-3">
                                    <label for="editProductStock" class="form-label">Stock</label>
                                    <input type="number" name="productStock" id="editProductStock" class="form-control" placeholder="Enter stock quantity" required>
                                </div>
                            </div>

                            <!-- Image Upload and Preview Section -->
                            <div class="row">
                                <!-- Main Image -->
                                <div class="col-md-6 mb-3">
                                    <label for="mainImageInput" class="form-label">Main Image</label>
                                    <input type="file" name="mainImage" id="mainImageInput" class="form-control" accept="image/*" onchange="previewEditMainImage(event)">
                                    <!-- Image Preview -->
                                    <div class="mt-3">
                                        <img id="mainImagePreview" src="#" alt="Main Image Preview" style="display: none; max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 5px;">
                                    </div>
                                </div>

                                <!-- Sample Images -->
                                <div class="col-md-6 mb-3">
                                    <label for="sampleImagesInput" class="form-label">Sample Images (Max: 5)</label>
                                    <input type="file" name="sampleImages" id="sampleImagesInput" class="form-control" accept="image/*" multiple onchange="previewEditSampleImages(event)">
                                    <!-- Image Previews -->
                                    <div class="mt-3" id="sampleImagesPreview"></div>
                                </div>
                            </div>


                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-success w-100">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
<!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AddProduct-Servlet" method="post" enctype="multipart/form-data" >
                        <div class="row">
                            <!-- Product Name -->
                            <div class="col-md-6 mb-3">
                                <label for="addProductName" class="form-label">Product Name</label>
                                <input type="text" name="productName" id="addProductName" class="form-control" placeholder="Enter product name" required>
                            </div>

                            <!-- Product Category (Populated dynamically from Servlet) -->
                            <div class="col-md-6 mb-3">
                                <label for="addProductCategory" class="form-label">Category</label>
                                <select name="productCategory" id="addProductCategory" class="form-select" required>
                                    <option value="" disabled selected>Select Category</option>
                                    <!-- Dynamically populated categories from the server -->
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Product Price -->
                            <div class="col-md-6 mb-3">
                                <label for="addProductPrice" class="form-label">Price</label>
                                <input type="number" name="productPrice" id="addProductPrice" class="form-control" placeholder="Enter price" step="0.01" required>
                            </div>

                            <!-- Product Stock -->
                            <div class="col-md-6 mb-3">
                                <label for="addProductStock" class="form-label">Stock</label>
                                <input type="number" name="productStock" id="addProductStock" class="form-control" placeholder="Enter stock quantity" required>
                            </div>
                        </div>

                        <!-- Image Upload and Preview Section -->
                        <div class="row">
                            <!-- Main Image -->
                            <div class="col-md-6 mb-3">
                                <label for="editMainImageInput" class="form-label">Main Image</label>
                                <input type="file" name="mainImage" id="editMainImageInput" class="form-control" accept="image/*" onchange="previewEditMainImage(event)">
                                <!-- Image Preview -->
                                <div class="mt-3">
                                    <img id="editMainImagePreview" src="#" alt="Main Image Preview" style="display: none; max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 5px;">
                                </div>
                            </div>

                            <!-- Sample Images -->
                            <div class="col-md-6 mb-3">
                                <label for="editSampleImagesInput" class="form-label">Sample Images (Max: 5)</label>
                                <input type="file" name="sampleImages" id="editSampleImagesInput" class="form-control" accept="image/*" multiple onchange="previewEditSampleImages(event)">
                                <!-- Image Previews -->
                                <div class="mt-3" id="editSampleImagesPreview"></div>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary w-100">Add Product</button>
                    </form>

                </div>
            </div>
        </div>
       </div>


<!-- Add Banner Modal -->
<div class="modal fade" id="addBannerModal" tabindex="-1" aria-labelledby="addBannerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBannerModalLabel">Add New Banner</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="AddBanner-Servlet" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="bannerTitle" class="form-label">Title</label>
                        <input type="text" class="form-control" id="bannerTitle" name="title" placeholder="Enter banner title" required>
                    </div>
                    <div class="mb-3">
                        <label for="bannerImage" class="form-label">Upload Image</label>
                        <input type="file" class="form-control" id="bannerImage1" name="image" accept="image/*" onchange="previewImage(event)" required>
                    </div>
                    <div class="mb-3">
                        <label for="imagePreview" class="form-label">Image Preview</label><br>
                        <img id="imagePreview3" src="#" alt="Image Preview" style="display:none; width: 100%; max-width: 200px;" />
                    </div>
                    <div class="mb-3">
                        <label for="bannerDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="bannerDescription" name="description" rows="3" placeholder="Enter banner description" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Add Banner</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="addCategory.jsp" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="Enter category name" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryImage" class="form-label">Upload Image</label>
                        <input type="file" class="form-control" id="categoryImage" name="categoryImage" accept="image/*" required>
                    </div>
                    <button type="submit" class="btn btn-success">Add Category</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Function to preview image
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const imagePreview = document.getElementById('imagePreview3');
            imagePreview.src = reader.result;  // Set the source to the selected image data
            imagePreview.style.display = 'block';  // Make the preview visible
        }
        reader.readAsDataURL(event.target.files[0]); // Read the selected file
    }
</script>

<script>
    $(document).ready(function() {
        // Activate the 'User Management' tab by default
        $('#user-tab').tab('show');

        // Click event for switching to 'User Management' tab
        $('#user-tab').on('click', function(e) {
            e.preventDefault(); // Prevent default link behavior
            $('#user-management').tab('show');
        });

        // Click event for switching to 'Admin Management' tab
        $('#admin-tab').on('click', function(e) {
            e.preventDefault(); // Prevent default link behavior
            $('#admin-management').tab('show');
        });
    });
</script>


<script>
    function populateCategoryForm(button) {
        // Get data attributes from the clicked button
        var categoryId = button.getAttribute('data-category-id');
        var categoryName = button.getAttribute('data-category-name');
        var categoryDescription = button.getAttribute('data-category-description');
        var categoryImage = button.getAttribute('data-category-image');

        // Populate the modal form with the category data
        document.getElementById('editCategoryName').value = categoryName;
        document.getElementById('editCategoryDescription').value = categoryDescription;
        document.getElementById('editCategoryImage').value = categoryImage; // For URL or current image path
        document.getElementById('imagePreview1').src = categoryImage;  // Display image preview
        document.getElementById('imagePreview1').style.display = 'block';  // Make sure the preview is visible
    }

    document.getElementById('editCategoryImage').addEventListener('change', function (event) {
        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = function (e) {
            const imagePreview = document.getElementById('imagePreview1');
            imagePreview.src = e.target.result;
            imagePreview.style.display = 'block';  // Show the image preview
        };

        if (file) {
            reader.readAsDataURL(file);  // Read the file as a data URL
        }
    });

</script>
<script>
    // Function to preview the selected image when editing
    function previewEditMainImage1(event) {
        const file = event.target.files[0]; // Get the selected file
        const reader = new FileReader();  // Create a FileReader instance

        // When the image is loaded, display it in the preview
        reader.onload = function(e) {
            const preview = document.getElementById('imagePreview1');
            preview.src = e.target.result;  // Set the preview image's source to the file's data URL
            preview.style.display = 'block'; // Show the preview
        };

        // If the user selects a file, read it as a data URL
        if (file) {
            reader.readAsDataURL(file);
        }
    }

    // Function to populate the form with category details
    function populateCategoryForm(button) {
        var categoryId = button.getAttribute('data-category-id');
        var categoryName = button.getAttribute('data-category-name');
        var categoryDescription = button.getAttribute('data-category-description');
        var categoryImage = button.getAttribute('data-category-image');

        // Populate the modal fields with the data
        document.getElementById('editCategoryName').value = categoryName;
        document.getElementById('editCategoryDescription').value = categoryDescription;
        document.getElementById('imagePreview1').src = categoryImage;  // Set the preview image source to the current image URL
        document.getElementById('imagePreview1').style.display = 'block';  // Show the current image preview

        // If you want to preload the current image path into the file input (you may need to handle this server-side)
        document.getElementById('editCategoryImage').value = categoryImage;  // Optional: Clear the file input field
    }



</script>
<script>
    // Function to display the image preview
    // Function to display the image preview
    function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function () {
            var output = document.getElementById('imagePreview');
            output.src = reader.result;
            output.style.display = 'block';  // Display the image preview
        };
        reader.readAsDataURL(event.target.files[0]);
    }


</script>
<script>
    // Function to preview the main image
    function previewEditMainImage(event) {
        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = function (e) {
            // Show the image preview and set the src to the selected file
            $('#mainImagePreview').attr('src', e.target.result).show();
        };

        if (file) {
            reader.readAsDataURL(file);
        }
    }

    // Function to preview sample images (max 5 images)
    function previewEditSampleImages(event) {
        const files = event.target.files;
        const previewContainer = $('#sampleImagesPreview');

        previewContainer.empty(); // Clear previous previews

        if (files.length > 5) {
            alert("You can select up to 5 images only.");
            return;
        }

        // Loop through selected files and create image previews
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function (e) {
                const img = $('<img>').attr('src', e.target.result).css({
                    'max-width': '100px',
                    'margin': '5px',
                    'border': '1px solid #ddd',
                    'border-radius': '5px'
                });
                previewContainer.append(img);
            };

            if (file) {
                reader.readAsDataURL(file);
            }
        }
    }

</script>
<script>
    // JavaScript function to load categories when the "Add Product" button is clicked
    function loadCategories() {
        // Fetch categories from the servlet
        fetch("AddProduct-Servlet")
            .then(response => response.json())
            .then(data => {
                const categorySelect = document.getElementById("addProductCategory");

                // Clear previous options
                categorySelect.innerHTML = "";

                // Add default "Select Category" option
                const defaultOption = document.createElement("option");
                defaultOption.value = "";
                defaultOption.text = "Select Category";
                defaultOption.disabled = true;
                defaultOption.selected = true;
                categorySelect.appendChild(defaultOption);

                // Add fetched categories to the dropdown
                if (data.categorySelect && data.categorySelect.length > 0) {
                    data.categorySelect.forEach(category => {
                        const option = document.createElement("option");
                        option.value = category;
                        option.text = category;
                        categorySelect.appendChild(option);
                    });
                } else {
                    // If no categories are found, add "No Categories Available"
                    const noCategoriesOption = document.createElement("option");
                    noCategoriesOption.value = "";
                    noCategoriesOption.text = "No Categories Available";
                    noCategoriesOption.disabled = true;
                    categorySelect.appendChild(noCategoriesOption);
                }
            })
            .catch(error => console.error("Error fetching categories:", error));
    }

</script>

<script>
    // JavaScript function to load categories when the "Add Product" button is clicked
    function loadCategories2() {
        // Fetch categories from the servlet
        fetch("AddProduct-Servlet")
            .then(response => response.json())
            .then(data => {
                const categorySelect = document.getElementById("editProductCategory");

                // Clear previous options
                categorySelect.innerHTML = "";

                // Add default "Select Category" option
                const defaultOption = document.createElement("option");
                defaultOption.value = "";
                defaultOption.text = "Select Category";
                defaultOption.disabled = true;
                defaultOption.selected = true;
                categorySelect.appendChild(defaultOption);

                // Add fetched categories to the dropdown
                if (data.categorySelect && data.categorySelect.length > 0) {
                    data.categorySelect.forEach(category => {
                        const option = document.createElement("option");
                        option.value = category;
                        option.text = category;
                        categorySelect.appendChild(option);
                    });
                } else {
                    // If no categories are found, add "No Categories Available"
                    const noCategoriesOption = document.createElement("option");
                    noCategoriesOption.value = "";
                    noCategoriesOption.text = "No Categories Available";
                    noCategoriesOption.disabled = true;
                    categorySelect.appendChild(noCategoriesOption);
                }
            })
            .catch(error => console.error("Error fetching categories:", error));
    }

</script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


<script>
    $('.edit-btn').on('click', function () {
        // Retrieve product details from the clicked button
        let productId = $(this).data('productid');
        let productName = $(this).data('productname');
        let productCategory = $(this).data('productcategory');
        let productPrice = $(this).data('productprice');
        let productStock = $(this).data('productstock');
        let productMainImage = $(this).data('productmainimage');
        let productSampleImages = $(this).data('productsampleimages'); // Comma-separated image filenames

        // Debugging: Log data to verify
        console.log('Product Data:', {
            productId,
            productName,
            productCategory,
            productPrice,
            productStock,
            productMainImage,
            productSampleImages
        });

        // Clean the productMainImage path (remove square brackets if present)
        productMainImage = productMainImage.replace(/[\[\]]/g, '');  // Remove [ and ] characters

        // Populate the modal fields
        document.getElementById('editProductId').value = productId;
        document.getElementById('editProductName').value = productName;
        document.getElementById('editProductPrice').value = productPrice;
        document.getElementById('editProductStock').value = productStock;

        // Set the category dropdown
        const categoryDropdown = document.getElementById('editProductCategory');
        categoryDropdown.innerHTML = ''; // Clear any existing options

        // Example list of categories
        const categories = ['Electronics', 'Books', 'Clothing', 'Toys', 'Furniture'];

        // Add options to the category dropdown
        categories.forEach((category) => {
            const option = document.createElement('option');
            option.value = category;
            option.textContent = category;

            // Set the selected option based on the product category
            if (category === productCategory) {
                option.selected = true;
            }

            categoryDropdown.appendChild(option);
        });

        // Preview the main image
        const mainImagePreview = document.getElementById('mainImagePreview');
        if (productMainImage) {
            mainImagePreview.src = productMainImage; // Prepend path to main image
            mainImagePreview.style.display = 'block';
        } else {
            mainImagePreview.style.display = 'none';
        }

        // Set the sample images preview
        const sampleImagesPreview = document.getElementById('sampleImagesPreview');
        sampleImagesPreview.innerHTML = ''; // Clear any existing previews

        if (productSampleImages) {
            // Split the comma-separated sample image paths
            const sampleImagePaths = productSampleImages.split(',');

            // Loop through each sample image path and display it
            sampleImagePaths.forEach((imageFilename) => {
                // Clean each sample image path by removing square brackets
                imageFilename = imageFilename.replace(/[\[\]]/g, ''); // Remove [ and ] characters from the sample image path

                const img = document.createElement('img');
                img.src = imageFilename.trim(); // Prepend path to each sample image
                img.alt = 'Sample Image';
                img.style = 'max-width: 100px; height: auto; margin-right: 10px; border: 1px solid #ddd; border-radius: 5px;';
                sampleImagesPreview.appendChild(img); // Add to preview container
            });
        }
    });


</script>


<%--
 <script>
            window.onload = function() {
                // Check if the page was redirected with the #productSection hash
                if (window.location.hash === "#productSection") {
                    // Hide all sections except #productSection
                    const allSections = document.querySelectorAll('section');
                    allSections.forEach(function(section) {
                        if (section.id !== 'productSection') {
                            section.style.display = 'none';
                        } else {
                            section.style.display = 'block';
                        }
                    });
                }
            };
 </script>

--%>





<script>
    const homeSection = document.getElementById("DashboardNav");
    const itemSection = document.getElementById("ProductNav");
    const categorySection = document.getElementById("categoryNav");
    const userSection = document.getElementById("userNav");


    let home_section = document.getElementById("home-section");
    let item_section = document.getElementById("productSection");
    let category_section = document.getElementById("categorySection");
    let user_section = document.getElementById("userSection");

    home_section.style.display="block";
    item_section.style.display="none";
    category_section.style.display="none";
    user_section.style.display="none";

    // Initial section display

    homeSection.addEventListener("click", function () {
        home_section.style.display = "block";
        item_section.style.display = "none";
        user_section.style.display = "none";
        category_section.style.display = "none";
        itemSection.classList.remove("active");
        homeSection.classList.add("active");
    });

    itemSection.addEventListener("click", function () {
        home_section.style.display = "none";
        category_section.style.display = "none";
        item_section.style.display = "block";
        user_section.style.display = "none";
        itemSection.classList.add("active");
        homeSection.classList.remove("active");

    });

    categorySection.addEventListener("click", function () {
        home_section.style.display = "none";
        item_section.style.display = "none";
        user_section.style.display = "none";
        category_section.style.display = "block";
        itemSection.classList.add("active");
        homeSection.classList.remove("active");

    });

    userSection.addEventListener("click", function () {
        home_section.style.display = "none";
        item_section.style.display = "none";
        category_section.style.display = "none";
        user_section.style.display = "block";
        itemSection.classList.add("active");
        homeSection.classList.remove("active");

    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // JavaScript to populate the Edit Product modal with selected product details
    document.querySelectorAll('.btn-warning').forEach(button => {
        button.addEventListener('click', (event) => {
            const button = event.target;
            document.getElementById('editProductId').value = button.getAttribute('data-productid');
            document.getElementById('editProductName').value = button.getAttribute('data-productname');
            document.getElementById('editProductCategory').value = button.getAttribute('data-productcategory');
            document.getElementById('editProductPrice').value = button.getAttribute('data-productprice');
            document.getElementById('editProductStock').value = button.getAttribute('data-productstock');
            document.getElementById('editMainImagePreview').innerHTML = `<img src="${button.getAttribute('data-productmainimage')}" alt="Main Image" style="width: 100px;">`;
        });
    });
</script>
<script>
    // Main Image Preview
    document.getElementById('mainImage').addEventListener('change', function (event) {
        const preview = document.getElementById('mainImagePreview');
        preview.innerHTML = ''; // Clear existing preview
        const file = event.target.files[0];
        if (file) {
            const img = document.createElement('img');
            img.src = URL.createObjectURL(file);
            img.style.width = '150px';
            img.style.height = 'auto';
            img.style.border = '1px solid #ddd';
            img.style.padding = '5px';
            img.style.marginTop = '10px';
            preview.appendChild(img);
        }
    });

    // Sample Images Preview
    document.getElementById('sampleImages').addEventListener('change', function (event) {
        const preview = document.getElementById('sampleImagesPreview');
        preview.innerHTML = ''; // Clear existing previews
        const files = Array.from(event.target.files);
        files.slice(0, 5).forEach((file) => { // Limit to 5 images
            const img = document.createElement('img');
            img.src = URL.createObjectURL(file);
            img.style.width = '100px';
            img.style.height = 'auto';
            img.style.border = '1px solid #ddd';
            img.style.padding = '5px';
            img.style.marginRight = '10px';
            img.style.marginTop = '10px';
            preview.appendChild(img);
        });
    });
</script>
<script>
    // Main Image Preview
    const mainImageInput = document.getElementById('mainImageInput');
    const mainImagePreview = document.getElementById('mainImagePreview');

    mainImageInput.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                mainImagePreview.src = e.target.result;
                mainImagePreview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            mainImagePreview.style.display = 'none';
        }
    });

    // Sample Images Preview
    const sampleImagesInput = document.getElementById('sampleImagesInput');
    const sampleImagesPreview = document.getElementById('sampleImagesPreview');

    sampleImagesInput.addEventListener('change', (event) => {
        const files = event.target.files;
        sampleImagesPreview.innerHTML = ''; // Clear previous previews
        Array.from(files).forEach((file) => {
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '100px';
                    img.style.margin = '5px';
                    img.style.border = '1px solid #ddd';
                    img.style.borderRadius = '5px';
                    img.style.height = 'auto';
                    sampleImagesPreview.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>
<script>
    // Main Image Preview
    const mainImageInput = document.getElementById('mainImageInput');
    const mainImagePreview = document.getElementById('mainImagePreview');

    mainImageInput.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                mainImagePreview.src = e.target.result;
                mainImagePreview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            mainImagePreview.style.display = 'none';
        }
    });

    // Sample Images Preview
    const sampleImagesInput = document.getElementById('sampleImagesInput');
    const sampleImagesPreview = document.getElementById('sampleImagesPreview');

    sampleImagesInput.addEventListener('change', (event) => {
        const files = event.target.files;
        sampleImagesPreview.innerHTML = ''; // Clear previous previews
        Array.from(files).forEach((file) => {
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '100px';
                    img.style.margin = '5px';
                    img.style.border = '1px solid #ddd';
                    img.style.borderRadius = '5px';
                    img.style.height = 'auto';
                    sampleImagesPreview.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>
<!-- JavaScript for Image Preview -->
<script>
    // Main Image Preview
    const editMainImageInput = document.getElementById('editMainImageInput');
    const editMainImagePreview = document.getElementById('editMainImagePreview');

    editMainImageInput.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                editMainImagePreview.src = e.target.result;
                editMainImagePreview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            editMainImagePreview.style.display = 'none';
        }
    });

    // Sample Images Preview
    const editSampleImagesInput = document.getElementById('editSampleImagesInput');
    const editSampleImagesPreview = document.getElementById('editSampleImagesPreview');

    editSampleImagesInput.addEventListener('change', (event) => {
        const files = event.target.files;
        editSampleImagesPreview.innerHTML = ''; // Clear previous previews
        Array.from(files).forEach((file) => {
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '100px';
                    img.style.margin = '5px';
                    img.style.border = '1px solid #ddd';
                    img.style.borderRadius = '5px';
                    img.style.height = 'auto';
                    editSampleImagesPreview.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>



<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
