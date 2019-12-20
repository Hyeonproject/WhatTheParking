package example;

import java.sql.*;
import java.util.ArrayList;

public class DBConnect {
    private String driver = "com.mysql.cj.jdbc.Driver";
    private String url = "jdbc:mysql://52.79.239.76:3306/wtp_test?serverTimezone=UTC";
    private String user = "LEE";
    private String pwd = "oradb";
    private String dbParkingTable = "wtp_parking";

    private Connection conn = null;
    private Statement stmt = null;

    public void connect() { //연결 확인
        try {
            conn = DriverManager.getConnection(url,user,pwd);
            System.out.println("연결 완료");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void disconnect() { //연결 끊기
        try{
            if(stmt != null){
                stmt.close();
            }
            if(conn != null){
                conn.close();
            }

            System.out.println("연결 헤재");
        }
        catch (SQLException e){
            e.printStackTrace();
        }
    }

    public Integer parkingCount(String parking_no){
        Integer count = null;

        connect(); //db 연결

        //sql 구문
        StringBuilder sb = new StringBuilder("select count(*) from wtp_parking where parkino = ?");
        sb.append(" where parking_no = '");
        sb.append(parking_no);
        sb.append("';");

        try{
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sb.toString());
            count = rs.getInt(0);
            rs.next();
            rs.close();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            disconnect();
        }

        return count;
    }
}
