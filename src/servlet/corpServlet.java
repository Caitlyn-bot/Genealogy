package servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.Dao;
import domain.PageBean;
import domain.TCorpEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/corpServlet")
public class corpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取参数
        String corname = request.getParameter("corname");
        String currentPage = request.getParameter("currentPage");//当前页码
        String rows = request.getParameter("rows");//每页显示条数

        if(currentPage == null || "".equals(currentPage)){

            currentPage = "1";
        }

        if(rows == null || "".equals(rows)){
            rows = "10";
        }
        Dao dao=new Dao();
        System.out.println(currentPage+";"+rows);
        if (corname==null||corname==""){
            PageBean<TCorpEntity> pb = dao.queryAllByPage(currentPage,rows);
            request.setAttribute("pb",pb);
            request.getRequestDispatcher("index.jsp").forward(request,response);
            //response.setContentType("application/json;charset=utf-8");
            //ObjectMapper mapper = new ObjectMapper();
            //String pb_json = mapper.writeValueAsString(pb);
            //response.getWriter().write(pb_json);
            //System.out.println(pb_json);
        }else {
            PageBean<TCorpEntity> pb = dao.queryByPage(currentPage,rows,corname);
            request.setAttribute("pb",pb);
            request.getRequestDispatcher("index.jsp").forward(request,response);
            //response.setContentType("application/json;charset=utf-8");
            //ObjectMapper mapper = new ObjectMapper();
            //String pb_json = mapper.writeValueAsString(pb);
            //response.getWriter().write(pb_json);
            //System.out.println(pb_json);
        }



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
