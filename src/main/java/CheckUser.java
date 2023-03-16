import beans.UserBean;
import beans.UserDao;
import beans.UserDaoImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(name = "CheckUser", value = "/CheckUser")
public class CheckUser extends HttpServlet {
    public void destroy() {super.destroy();}
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


//接收从客户端提交的 loginName 参数
        String loginName = request.getParameter("loginName");

        //判断表单数据是否传送过来
        //获取login.jsp页面提交的账号和密码设置到实体类User中
        UserBean user=new UserBean();
        user.setName(loginName);
        UserDao dao = new UserDaoImpl();
        Boolean us =  dao.checkUser(user);
        String responseContext = "true";

        if(!us)
        { responseContext = "false";}

        out.println(responseContext);
        out.flush();
        out.close();
    }
    public void init() throws ServletException {}
}