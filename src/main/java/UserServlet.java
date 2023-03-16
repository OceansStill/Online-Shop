import beans.UserBean;
import beans.UserDao;
import beans.UserDaoImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UserServlet", value = "/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username");
        String password = request.getParameter("password");
        //获取registerServlet.jsp页面提交的账号和密码设置到实体类User中
        UserBean user=new UserBean();
        user.setName(name);
        user.setPassword(password);
        UserDao dao = new UserDaoImpl();
        boolean flag = dao.setUser(user);
        if(flag)
        {request.getSession(true).setAttribute("username", name);
            request.getSession().setAttribute("user", 1);
            request.getSession().setAttribute("password", password);
                     response.sendRedirect(request.getContextPath()+"/main.html");


        }
        else
        {            response.sendRedirect(request.getContextPath()+"/register.jsp");

        }
    }
}
