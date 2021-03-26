package servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.Dao;
import domain.Guquan;
import domain.Touzi;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/show4Servlet")
public class show4Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String corname = request.getParameter("corname");
        Dao dao=new Dao();
        List<Guquan> touzi = dao.show4(corname);
        response.setContentType("application/json;charset=utf-8");
        ObjectMapper mapper = new ObjectMapper();
        String touzi_json = mapper.writeValueAsString(touzi);
        response.getWriter().write(touzi_json);
        System.out.println(touzi_json);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
