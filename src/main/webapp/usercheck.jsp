<%@ page import="java.io.IOException" %>
<%@ page import="beans.UserBean" %>
<%@ page import="beans.UserDao" %>
<%@ page import="beans.UserDaoImpl" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%




    @WebServlet(name = "login1Servlet", value = "/login1Servlet")

   class loginServlet extends HttpServlet {

        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);

        }

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // TODO Auto-generated method stub
            //接收从jsp表单传过来的数据

            String name = request.getParameter("email");
            String password = request.getParameter("password");

            //判断表单数据是否传送过来
            //获取login.jsp页面提交的账号和密码设置到实体类User中
            UserBean user=new UserBean();
            user.setName(name);
            user.setPassword(password);
            UserDao dao = new UserDaoImpl();
            Boolean us = dao.getUser(user);
            if(us)
            { request.getSession(true).setAttribute("username", name);
                request.getSession().setAttribute("user", 1);
                request.getSession().setAttribute("password", password);

                response.sendRedirect(request.getContextPath()+"/main.html");}
            else
            {                response.sendRedirect(request.getContextPath() + "/login.html");
            }


        }
    }




%>