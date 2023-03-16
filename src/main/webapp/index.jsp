<%@page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@page import="java.sql.*"%>
<html>
<head><title>在线购物</title></head>
<%
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    String url="jdbc:mysql://localhost:3306/userdb?useSSL=false";
    Connection conn = DriverManager.getConnection(url,"root","1");
    Statement stmt=conn.createStatement();
    String sql="select * from shop";
    ResultSet rs=stmt.executeQuery(sql);
//输出查询结果到页面
%>
<body>
<h2>在线购物</h2><hr>
<table border="1" width="600">
    <tr bgcolor="#dddddd">
        <td align="center" width="80">商品缩图</td>
        <td align="center">商品摘要</td>
        <td align="center" width="100">在线购买</td>
    </tr>
    <%
        String sp_No;
        String sp_Name;
        String sp_Price;
        String sp_Info;
        String sp_Pic;
        String sp_Num;
//将查询结果集中的记录输出到页面上
        while (rs.next()){
            //从当前记录中读取各字段的值
            sp_Pic = rs.getString("sp_Pic").trim();
            sp_No = rs.getString("sp_No").trim();
            sp_Name = rs.getString("sp_Name").trim();
            sp_Price = rs.getString("sp_Price").trim();
            sp_Info = rs.getString("sp_Info").trim();
            sp_Num=rs.getString("sp_Num").trim();

            int sp_Num1= Integer.parseInt(sp_Num);

            //计算该产品在购物车中的所有存货，以计算库存
            Class.forName("com.mysql.jdbc.Driver").newInstance();

            String url1="jdbc:mysql://localhost:3306/userdb?useSSL=false";
            Connection conn1 = DriverManager.getConnection(url1,"root","1");
            Statement stmt1=conn.createStatement();
            String sql1="select * from cart";
            ResultSet rs1=stmt1.executeQuery(sql1);
            int buy_Num=0;

            while (rs1.next()){

               if(rs1.getString("sp_Name").trim().equals(sp_Name))
               {buy_Num = buy_Num+Integer.parseInt(rs1.getString("buy_Num").trim());}
            }
            rs1.close();
            conn1.close();
            int num=(sp_Num1-buy_Num );
            out.println("<tr>");
            out.println("<td><img src='"+sp_Pic+"' border=0 height=60 width=60></td>");
            out.println("<td>");
            out.println("商品编号："+ sp_No +"<br>");
            out.println("商品名称："+ sp_Name +"<br>");
            out.println("商品价格："+ sp_Price +"元<br>");
            out.println("商品简介："+ sp_Info +"<br>");
            out.println("商品库存："+ num+"<br>");
            out.println("</td>");
            out.println("<td><a href='buy.jsp?op=add&sp_No="+sp_No+"'>放入购物车 </a></td>");
            out.println("</tr>");
        }
    %>
</table>
<br>
<a href="cart.jsp">查看购物车</a>&nbsp;&nbsp;
<a href="buy.jsp?op=clear">清空购物车</a>
</body>
</html>