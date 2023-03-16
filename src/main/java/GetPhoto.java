import beans.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(name = "GetPhoto", value = "/GetPhoto")
public class GetPhoto extends HttpServlet {
    public GetPhoto() {super();}
    public void destroy() {super.destroy(); }
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("gb2312");
        PrintWriter out = response.getWriter();
        String selected = request.getParameter("selected");



        photoDao dao=new photoDao();
        List<photoBean> list=dao.getPhoto();


        int index = Integer.parseInt(selected);
//返回相片给客户端
        out.println("/"+list.get(index).getRndFilename());
        out.flush();
        out.close();
    }
    public void init() throws ServletException {}
}
