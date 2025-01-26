package lk.ijse.ecommerce.controller.product;

import jakarta.annotation.Resource;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import lk.ijse.ecommerce.dto.CategoryDTO;

import javax.sql.DataSource;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductSaveServlet", value = "/product-save")
@MultipartConfig
public class ProductSaveServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    private static final String UPLOAD_DIR = "images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CategoryDTO> categories = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = dataSource.getConnection();
            String sql = "SELECT id, name FROM categories";
            Statement stm = connection.createStatement();
            ResultSet rst = stm.executeQuery(sql);

            while (rst.next()) {
                int id = rst.getInt("id");
                String name = rst.getString("name");
                categories.add(new CategoryDTO(id, name, null));
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching categories: " + e.getMessage());
        }

        request.setAttribute("categories", categories);
        request.getRequestDispatcher("product-save.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        double price = 0.0;
        int stock = 0;
        int categoryId = 0;

        try {
            price = Double.parseDouble(request.getParameter("price"));
            stock = Integer.parseInt(request.getParameter("stock"));
            categoryId = Integer.parseInt(request.getParameter("category_id"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input values.");
            doGet(request, response);
            return;
        }

        Part imagePart = request.getPart("image");
        if (imagePart == null || imagePart.getSize() == 0) {
            request.setAttribute("error", "Product image is required.");
            doGet(request, response);
            return;
        }

        String fileName = imagePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        try (InputStream inputStream = imagePart.getInputStream();
             FileOutputStream outputStream = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save image: " + e.getMessage());
            doGet(request, response);
            return;
        }

        String insertProductQuery = "INSERT INTO products (name, price, qty, category_id, image_path) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertProductQuery)) {

            preparedStatement.setString(1, name);
            preparedStatement.setDouble(2, price);
            preparedStatement.setInt(3, stock);
            preparedStatement.setInt(4, categoryId);
            preparedStatement.setString(5, UPLOAD_DIR + "/" + fileName);
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("product-list");
            } else {
                request.setAttribute("error", "Failed to add product.");
                doGet(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            doGet(request, response);}
}
}