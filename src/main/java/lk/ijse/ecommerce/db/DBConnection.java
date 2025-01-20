package lk.ijse.ecommerce.db;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class DBConnection {
    public static DataSource dataSource;

    static {
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerce");
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize connection pool", e);
        }
    }

    public static Connection getConnection() throws Exception {
        return dataSource.getConnection();
    }
}
