package xml;

import org.dom4j.*;
import org.dom4j.io.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class CreateXML{
    public CreateXML() {}
    public Document create(String filename) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {



        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url="jdbc:mysql://localhost:3306/userdb?useSSL=false";
        Connection conn = DriverManager.getConnection(url,"root","1");
        Statement stmt=conn.createStatement();
        String sql="select * from users";
        ResultSet rs=stmt.executeQuery(sql);
        List<String> username=new ArrayList<String>();
        List<String> password=new ArrayList<String>();

        //产生一个 XML 文档并存盘
//使用 DocumentHelper 类创建一个文档实例
        Document document=DocumentHelper.createDocument();
        Element rootElement=document.addElement("linkmans");//创建根元素
        int i=0;
        while (rs.next()){
            i++;

            try {

                username.add(rs.getString("username").trim());
                password.add( rs.getString("password").trim());

            } catch (Exception e) {
                e.printStackTrace();
            }


        }
        Element[] elements=new Element[i];
        Element[] us=new Element[i];
        Element[] ps=new Element[i];

//为根元素创建第一个子元素
        for(int a=0;a<i-1;a++)
        {
            elements[a+1]=rootElement.addElement("linkman");
            us[a+1]= elements[a+1].addElement("username");
            us[a+1].setText(username.get(a));
            ps[a+1]=elements[a+1].addElement("password");
            ps[a+1].setText(password.get(a));
        }

//将创建的 XML 文档存盘
        try{
            OutputFormat format=OutputFormat.createPrettyPrint();//创建一个格式化对象
            format.setIndent("\t");//使用 TAB 缩进
//创建一个 XMLWriter 对象
            XMLWriter output = new XMLWriter(
            new FileOutputStream(new File(filename)),format);
            output.write(document);//将 XML 文档输出
            output.close();
        }catch(IOException e){
            System.out.println(e.getMessage());
        }
//返回 XML 文档对象
        return document;
    }
    //将文本串转换成 XML 文档并存盘
    public Document create(String filename,String text) throws Exception{
//使用 DocumentHelper 类将文本串转换为 XML 文档
        Document document=DocumentHelper.parseText(text);
//将创建的 XML 文档存盘
        try{
//创建一个格式化对象
            OutputFormat format = OutputFormat.createPrettyPrint();
//使用 TAB 缩进
            format.setIndent("\t");
//创建一个 XMLWriter 对象
            XMLWriter output = new XMLWriter(
                    new FileOutputStream(new File(filename)),format);
//将 XML 文档输出
            output.write(document);
            output.close();
        }catch(IOException e){
            System.out.println(e.getMessage());
        }
//返回 XML 文档对象
        return document;
    }
}