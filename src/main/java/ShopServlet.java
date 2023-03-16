import beans.UserBean;
import beans.UserDao;
import beans.UserDaoImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ShopServlet", value = "/ShopServlet")
public class ShopServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name=(String) request.getSession().getAttribute("username");
        String password=(String)  request.getSession().getAttribute("password");

        UserBean user=new UserBean();
        user.setName(name);
        user.setPassword(password);
        UserDao dao = new UserDaoImpl();


        Boolean us = dao.getUser(user);
        if(us){
            request.getSession().setAttribute("username", name);;
            response.sendRedirect(request.getContextPath()+"/main.html");}
        else
        {                response.sendRedirect(request.getContextPath() + "/login.html");
        }
    }
}
