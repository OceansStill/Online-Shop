
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/tlds/mytag.tld" prefix="test"%>

<html>
<head>
    <h1><center>简单的计算器</center></h1>
</head>
<body>
<center>
    <form action="" method="post">
        <label id="num1"><b>Number 1</b></label>
        <input type="text" name ="num1"><br><br>
        <label id= "num2"><b>Number 2</b></label>
        <input type="text" name="num2"><br><br>
        <input type ="radio" name = "r1" value="Add">+
        <input type = "radio" name = "r1" value="Sub">-<br>
        <input type="radio" name="r1" value ="mul">*
        <input type = "radio" name="r1" value="div">/<br><br>
        <input type="submit" value="submit">
        <%request.setCharacterEncoding("UTF-8"); %>
        <%
            String n11 =(String) request.getParameter("num1");
            String n22 = (String) request.getParameter("num2");
            String operation1= (String) request.getParameter("r1");
            String n2= n22==null?"0":n22;
            String n1= n11==null?"0":n11;
            String operation2= operation1==null ?"Add" :operation1;
            %>

        <test:example operation="<%=operation2%>" num1="<%=n1%>" num2="<%=n2%>" />

    </form>

</center>
<script language="javascript">

</script>



</body>
</html>


