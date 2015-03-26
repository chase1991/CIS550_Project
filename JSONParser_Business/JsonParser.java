package hw3;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class JsonParser {

    // Database credentials
    static final String USER = "ultraDobe";
    static final String PASS = "ultradobe";

    public static void main(String[] args) {
        String jdbcUrl = "jdbc:mysql://"
                + "ultradbinstance.combuootb1m3.us-east-1.rds.amazonaws.com:3306"
                + "/" + "ultraDB" + "?user=" + "ultraDobe" + "&password="
                + "ultradobe";

        String path = "/users/dustin/desktop/cis 550/project_dataset/yelp_academic_dataset_business.json";
        
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
//
//    public static String sqlParser_Cate(String line){
//        String sql = "INSERT IGNORE INTO restaurant_category(business_id, category)"
//                + " VALUES";
//        StringBuilder
//        return sb.toString();
//    }
    
    
    public static String sqlParserRC(String line){
        String sql = "INSERT IGNORE INTO Business_Category(business_id, category)"
                + " VALUES";
        StringBuilder sb = new StringBuilder(sql);
        
        try {
            JSONParser parser = new JSONParser();
            JSONObject jObj = (JSONObject) parser.parse(line);
            String bid = (String) jObj.get("business_id");
            JSONArray categories = (JSONArray) jObj.get("categories");
            if (categories == null || categories.isEmpty() ){
                return null;
            }
            sb.append("(\"");
            sb.append(bid);
            sb.append("\",\"");
            sb.append((String)categories.get(0));
            sb.append("\")");
            
            for (int i = 1; i < categories.size(); i++) {
                sb.append(",(\"");
                sb.append(bid);
                sb.append("\",\"");
                sb.append((String)categories.get(i));
                sb.append("\")");
            }
            sb.append(";");
            
        } catch (ParseException e3) {
            e3.printStackTrace();
        }
        
        return sb.toString();
    }
    
    public static String sqlParser(String line){
        String sql = "INSERT IGNORE INTO Businesses(business_id, name, full_address, city, state, latitude, longitude, star, hours, reviewNum)"
                + " VALUES";
        StringBuilder sb = new StringBuilder(sql);
        sb.append("(");
        try {
            JSONParser parser = new JSONParser();
            JSONObject jObj = (JSONObject) parser.parse(line);
            
            //append business_id
            singleStringAttr(sb, jObj, "business_id");
            
            //append name
            singleStringAttr(sb, jObj, "name");
            
            //append full_address
            singleStringAttr(sb, jObj, "full_address");
            
            //append city
            singleStringAttr(sb, jObj, "city");
            
            //append state
            singleStringAttr(sb, jObj, "state"); 
            
            //append latitude
            Double temp = (Double)jObj.get("latitude");
            if (temp == null) {
                sb.append("null");
            } else {
                sb.append(temp);
            }
            sb.append(",");
            
            //append longitude
            temp = (Double)jObj.get("longitude");
            if (temp == null) {
                sb.append("null");
            } else {
                sb.append(temp);
            }
            sb.append(",");
    
            //append stars
            Double temp1 = (Double)jObj.get("stars");
            if (temp1 == null) {
                sb.append("null");
            } else {
                sb.append(temp1);
            }
            sb.append(",");
            
            //append hours
            JSONObject hours = (JSONObject) jObj.get("hours");
            String temp0 = toHourDescription(hours);
            if (temp0.equals("")) {
                sb.append("null");
            } else {
                sb.append("\"");
                sb.append(temp0);
                sb.append("\"");
            }
            sb.append(",");
            
            //append reviewNum
            Long temp2 = (Long)jObj.get("review_count");
            if (temp2 == null) {
                sb.append("null");
            } else {
                sb.append(temp2);
            }
            sb.append(")");
        
    } catch (ParseException e3) {
        e3.printStackTrace();
    }
        return sb.toString();
    }

    public static void singleStringAttr(StringBuilder sb, JSONObject jObj, String attr) {
        String temp = addSlash((String)jObj.get(attr));
        if (temp == null) {
            sb.append("null");
        } else {
            sb.append("\"");
            sb.append(temp);
            sb.append("\"");
        }
        sb.append(",");
    }
    
    public static String toHourDescription(JSONObject hours) {
        StringBuilder sb = new StringBuilder();
        appendHour(hours, sb, "Monday");
        appendHour(hours, sb, "Tuesday");
        appendHour(hours, sb, "Wednesday");
        appendHour(hours, sb, "Thursday");
        appendHour(hours, sb, "Friday");
        appendHour(hours, sb, "Saturday");
        appendHour(hours, sb, "Sunday");
        return sb.toString();
    }

    private static void appendHour(JSONObject hours, StringBuilder sb,
            String weekDay) {
        if (hours.containsKey(weekDay)) {
            String res = toSingleHour(hours, weekDay);
            if (res != null) {
                sb.append(weekDay.substring(0, 3) + ":" + res + " ");
            }
        }
    }

    private static String toSingleHour(JSONObject hours, String weekDay) {
        StringBuilder sb = new StringBuilder();
        JSONObject time = (JSONObject) hours.get(weekDay);
        if (time != null) {
            String open = (String) time.get("open");
            if (open != null) {
                sb.append(open);
            } else
                return null;
            String close = (String) time.get("close");
            if (close != null) {
                sb.append("-");
                sb.append(close);
            } else
                return null;
        }
        return sb.toString();
    }
    
    private static String addSlash(String s) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '"') {
                sb.append("\\\"");
            } else {
                sb.append(s.charAt(i));
            }
        }
        return sb.toString();
    }

}