package JDBS;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ExecuteQuery {
 // Database credentials
    static final String USER = "ultraDobe";
    static final String PASS = "ultradobe";

    public static void main(String[] args) {
        String jdbcUrl = "jdbc:mysql://"
                + "ultradbinstance.combuootb1m3.us-east-1.rds.amazonaws.com:3306"
                + "/" + "ultraDB" + "?user=" + "ultraDobe" + "&password="
                + "ultradobe";
        
        Connection conn = null;
        Statement stmt = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl);
            stmt = conn.createStatement();
            FileReader reader = new FileReader(path);
            BufferedReader br = new BufferedReader(reader);
            String line = br.readLine();
            while (line != null) {
               
//               stmt.executeUpdate(sqlParser(line));
                String sql = sqlParserRC(line);
                if (sql != null) {
                    stmt.executeUpdate(sqlParserRC(line));
                }

                line = br.readLine();
            }
            br.close();
        
            stmt.close();
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            // Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            // finally block used to close resources
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException se2) {
            }// nothing we can do
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            } 
        }
    }
    }
}
