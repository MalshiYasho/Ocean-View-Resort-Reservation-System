package util;

import java.sql.Connection;
import java.sql.SQLException;

public class dbconnectionTest {
    public static void main(String[] args) {
        try {
            Connection conn = dbconnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println(">>> Connection test successful! <<<");
            } else {
                System.out.println(">>> Connection test failed <<<");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
