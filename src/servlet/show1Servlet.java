package servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.Dao;
import domain.Guquan;
import domain.TCorpEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/show1Servlet")
public class show1Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String corname = request.getParameter("corname");
        System.out.println(corname);
        Dao dao=new Dao();
        List<Guquan> guquan = dao.show1(corname);
        System.out.println(guquan);
        response.setContentType("application/json;charset=utf-8");
        ObjectMapper mapper = new ObjectMapper();
        String guquan_json = mapper.writeValueAsString(guquan);
        response.getWriter().write(guquan_json);
        System.out.println(guquan_json);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
