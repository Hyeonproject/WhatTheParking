package example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DBDAO extends DBConnect {

    private DBDAO() { }

    private static DBDAO instance = new DBDAO();

    public static DBDAO getInstance() {
        return instance;
    }

    public ArrayList<ParkingBean> getall() {
        String sql = "select * from wtp_parking";
        ArrayList<ParkingBean> list = new ArrayList<ParkingBean>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnect.connect();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ParkingBean parkingBean = new ParkingBean();
                parkingBean.setParking_no("paking_no");
                parkingBean.setA1("A1");
                parkingBean.setA2("A2");
                parkingBean.setA3("A3");
                parkingBean.setA4("A4");
                parkingBean.setA5("A5");
                parkingBean.setA6("A6");
                parkingBean.setA7("A7");
                parkingBean.setA8("A8");
                parkingBean.setA9("A9");
                parkingBean.setA10("A10");
                list.add(parkingBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return list;
    }
}






