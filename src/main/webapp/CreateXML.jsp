<%@ page contentType= "text/html" pageEncoding="gb2312"%>
<%@ page import="org.dom4j.*, java.util.*" %>
<jsp:useBean id="myCreate" class="xml.CreateXML"/>
<html>
<head><title>���� XML �ļ�</title></head>
<body>
<h2>���� XML �ļ�</h2><hr>
<%
    //����һ�� myfirst.xml �ļ��ľ�������·��
    String fileName1 = request.getRealPath("/")+"webapp/myfirst.xml";
//���������� myfirst.xml �ļ�,ȡ�ø� XML �ĵ�����
    Document doc = myCreate.create(fileName1);
    String reslut = doc.asXML();//�ݴ�� XML �ĵ�������
%>
<textarea rows="10" cols="60"><%=reslut%></textarea>
<%
    //����һ������ XML �ĵ��﷨���ı���
    StringBuffer text = new StringBuffer();
    text.append("<users>");
    text.append("<user>");
    text.append("<loginname>admin</loginname>");
    text.append("<password>123</password>");
    text.append("</user>");
    text.append("</users>");
//���ı���Ϊ���ݴ���һ�� XML �ĵ�
    String fileName2 = request.getRealPath("/")+"second.xml";
    doc = myCreate.create(fileName2,text.toString());
    reslut = doc.asXML();
%>
<textarea rows="10" cols="60"><%=reslut%></textarea>
</body>
</html>

