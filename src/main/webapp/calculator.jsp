<%--
  Created by IntelliJ IDEA.
  User: a
  Date: 2022/4/13
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<title>calculator</title>
<head></head>
<body>
<%@page language="java"%>
<%
        int num1 = Integer.parseInt(request.getParameter("num1"));
        int num2 = Integer.parseInt(request.getParameter("num2"));
        String operation = request.getParameter("r1");
        if(operation.equals("Add")){
            int add=num1+num2;
            out.println("Addition is: "+add);
        }
        else if(operation.equals("Sub")){
            int sub=num1-num2;
            out.println("Substraction is: "+sub);
        }
        else if(operation.equals("mul")){
            int mul=num1*num2;
            out.println("multiplication is: "+mul);
        }
        else if(operation.equals("div"))
        {
            int div = num1/num2;
            if(num1>=num2)
                out.println("division is: "+div);
            else
                out.println("The division cannot be performed");
        }
%>
</body>
</html>
