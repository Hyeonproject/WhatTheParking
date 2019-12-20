package example;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

//@WebServlet(name = "MainControl")
public class MainControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1. init
        HttpSession session = request.getSession(); //세션 객체 불러오기
        DBConnect db = (DBConnect)session.getAttribute("db");
        if(db == null){ //session에 존재하지 않는 군
            db = new DBConnect();
            session.setAttribute("db",db);
        }

        //2. dispatch request to processing component
        String pathInfo = request.getPathInfo();
        String viewName = "index.jsp"; //에러 뜨면 바로 보내게 하지만 나는 메인 페이지로 보내게

        if(pathInfo.equals("/parking1")){
            int count = db.parkingCount("1");
            session.setAttribute("count",count);
            viewName = "parking.jsp";
        }
        else if (pathInfo.equals("/parking2")){
            int count = db.parkingCount("2");
            session.setAttribute("count",count);
            viewName = "parking2.jsp";
        }

        //3. forward to view componet
        StringBuilder sb = new StringBuilder(viewName);
        sb.insert(0,"../");
        RequestDispatcher view = request.getRequestDispatcher(sb.toString());
        view.forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
