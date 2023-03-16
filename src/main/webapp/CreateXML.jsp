<%@ page contentType= "text/html" pageEncoding="gb2312"%>
<%@ page import="org.dom4j.*, java.util.*" %>
<jsp:useBean id="myCreate" class="xml.CreateXML"/>
<html>
<head><title>创建 XML 文件</title></head>
<body>
<h2>创建 XML 文件</h2><hr>
<%
    //定义一个 myfirst.xml 文件的绝对物理路径
    String fileName1 = request.getRealPath("/")+"webapp/myfirst.xml";
//产生并保存 myfirst.xml 文件,取得该 XML 文档对象
    Document doc = myCreate.create(fileName1);
    String reslut = doc.asXML();//暂存该 XML 文档的内容
%>
<textarea rows="10" cols="60"><%=reslut%></textarea>
<%
    //创建一个符合 XML 文档语法的文本串
    StringBuffer text = new StringBuffer();
    text.append("<users>");
    text.append("<user>");
    text.append("<loginname>admin</loginname>");
    text.append("<password>123</password>");
    text.append("</user>");
    text.append("</users>");
//以文本串为内容创建一个 XML 文档
    String fileName2 = request.getRealPath("/")+"second.xml";
    doc = myCreate.create(fileName2,text.toString());
    reslut = doc.asXML();
%>
<textarea rows="10" cols="60"><%=reslut%></textarea>
</body>
</html>

