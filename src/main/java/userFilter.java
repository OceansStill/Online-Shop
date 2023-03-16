import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//@WebFilter(filterName = "userFilter",)
@WebFilter(urlPatterns = {"/userFilter"})
public class userFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws ServletException, IOException {
        servletRequest.setCharacterEncoding("utf-8");
        servletResponse.setContentType("text/html;charset=utf-8");

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String servletPath = request.getServletPath();
        if(auth(servletPath)){

            //如何判断是否登录
            Object username = request.getSession().getAttribute("user");
            if(username == null){

                //跳转到登录页面
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            else {
                chain.doFilter(servletRequest, servletResponse);

            }
        }
        //如果没有这行代码，那么就是执行的拦截
        chain.doFilter(servletRequest, servletResponse);

    }

    //验证身份、权限 学的知识点落地

    private boolean auth(String servletPath) {

        if("/main.html".equals(servletPath)){

            return true;
        }
        return false;


    }
}
