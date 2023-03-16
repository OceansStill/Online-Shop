<%@ page contentType= "text/html" pageEncoding="gb2312"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="beans.User" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Files" %>

<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.nio.file.StandardOpenOption" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<html>
<head><title>创建 Json文件</title></head>
<body>
<h2>创建 json 文件</h2><hr>
<%
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    String url="jdbc:mysql://localhost:3306/userdb?useSSL=false";
    Connection conn = DriverManager.getConnection(url,"root","1");
    Statement stmt=conn.createStatement();
    String sql="select * from users";
    ResultSet rs=stmt.executeQuery(sql);

    List<User> list=new ArrayList<User>();
    User user1=new User("bob","123456");
    User user2=new User("lily", "123456");

    while (rs.next()){




        try {

            list.add(new User(rs.getString("username").trim(), rs.getString("password").trim()));
        } catch (Exception e) {
            e.printStackTrace();
        }





    }

    out.println();
    out.println();
    out.println();

    out.println("*******javaBean to jsonString*******");
    //String str1=JSON.toJSONString(user1);
    //System.out.println(str1);
    out.println(JSON.toJSONString(list));
   out.println();
    out.println();
    out.println();
    out.println();

    String jsonString = JSONObject.toJSONString(list,true);

    String pathFile=session.getServletContext().getRealPath("/webapp/");   //注意 这个文件夹要是没有的话是会报错的
    File file=new File(pathFile);
    if (!file.exists()) { //所以在这里必须提前创建好文件夹
        file.mkdirs();
    }

    Path ConfPath = Paths.get(pathFile, "user.json");

    try {
        if (!Files.exists(ConfPath)){
            Files.createFile(ConfPath);
        }
    } catch (Exception e) {
       out.println("创建配置文件失败");
    }
    try {
        Files.write(ConfPath, JSON.toJSONBytes(list), StandardOpenOption.CREATE);
    } catch (Exception ex) {
        out.println("写入配置文件失败");
    }

    String pathFile1=session.getServletContext().getRealPath("/webapp/");
    Path ConfPath1 =Paths.get(pathFile1, "user.json");
    byte[] bytes = new byte[]{};
    try {
    bytes = Files.readAllBytes(ConfPath1);
    } catch (Exception e) {
    out.println("读取文件失败");
    }
    String jsonString1 = new String(bytes);
    out.println();
    out.println();
    out.println();

    out.println("*******从JSON文件中读取到的数据*******");
    out.println();
    out.println();
    out.println();
    out.println();

    out.println(jsonString1);


%>

</body>
</html>