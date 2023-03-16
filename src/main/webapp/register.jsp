

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>

<%@ page import="beans.UserBean" %>
<%@ page import="beans.UserDao" %>
<%@ page import="beans.UserDaoImpl" %>

<html>
<head>
    <title>注册</title>
</head>
<body>
<h1>小可爱请注册</h1>
<form action="" name="register" method="get">

    <br><input name="username" type="text" placeholder="请设置账户">
    <br><input type="button" name="checkLoginName" value="有效性检查" onclick="beginCheck()">
    <br><input name="password"  type="password" placeholder="请设置密码">
    <br><input type="submit" value="注册">
</form>

</body>
</html>

<script language="javascript">
    //定义一个变量用于存放 XMLHttpRequest 对象
    var xmlHttp;
    //该函数用于创建一个 XMLHttpRequest 对象
    function createXMLHttpRequest() {

        if (window.ActiveXObject)
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        else if (window.XMLHttpRequest)
            xmlHttp = new XMLHttpRequest();
    }
    //这是一个启动 AJAX 异步通信的方法
    function beginCheck(){
        var tempLoginName =  document.all.username.value;
        console.log(tempLoginName)
        if (tempLoginName == ""){//如果尚未输入注册名
            alert("对不起，请您输入注册名!");
            return;
        }
        createXMLHttpRequest();//创建一个 XMLHttpRequest 对象
        xmlHttp.onreadystatechange = processor; //将状态触发器绑定到一个函数
//通过 GET 方法向指定的 URL 建立服务器的调用
        xmlHttp.open("GET", "CheckUser?loginName="+tempLoginName);
        xmlHttp.send(null); //发送请求
    }
    //这是一用来处理状态改变的函数
    function processor () {
//定义一个变量用于存放从服务器返回的响应结果
        var responseContext;
        if(xmlHttp.readyState == 4) { //如果响应完成
            if(xmlHttp.status == 200) {//如果返回成功
//取出服务器的响应内容
                responseContext = xmlHttp.responseText;
//如果注册名检查有效
                if (responseContext.indexOf("true")!=-1)
                    alert("恭喜您，该注册名有效！");
                else
                    alert("对不起，该注册名已被使用！");
            }
        }
    }
</script>









<%request.setCharacterEncoding("UTF-8"); %>
<%
    String name = request.getParameter("username");
    String password = request.getParameter("password");

    if(password!= null){
        int letter= 0, digit = 0;

        for (Character ch : password.toCharArray()) {
            if (Character.isLetter(ch)) {
                letter= 1;
            } else if (Character.isDigit(ch)) {digit=1;
            }
        }
        if (letter+ digit <2) {
            JspWriter out1 = pageContext.getOut();
            out1.print("密码不规范");
        }
        else
        {
            RequestDispatcher rd=request.getRequestDispatcher("/UserServlet");
            rd.forward(request,response);
        }


    }






%>
