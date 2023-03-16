<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<html>
<head><title>�����ϴ����ļ�</title></head>
<body>
<h2>�����ϴ����ļ�</h2>
<hr>
<%
    /*******************************************************/
    /* ��ʵ���о����ܶ���õ���һЩ��������ʵ��Ӧ���� */
    /* ���ǿ��Ը����Լ�����Ҫ����ȡ�ᣡ */
/*******************************************************/
// �½�һ�� SmartUpload ����,�����Ǳ����
    SmartUpload myupload = new SmartUpload();
// ��ʼ��,�����Ǳ����
    myupload.initialize(pageContext);
// ����ÿ���ϴ��ļ�����󳤶�
    myupload.setMaxFileSize(1024*1024);
// �������ϴ����ݵĳ���
    myupload.setTotalMaxFileSize(5*1024*1024);
// �趨�����ϴ����ļ���ͨ����չ�����ƣ�
    myupload.setAllowedFilesList("doc,txt,jpg,gif");
// �趨��ֹ�ϴ����ļ���ͨ����չ�����ƣ�
    myupload.setDeniedFilesList("exe,bat,jsp,htm,html");
    try{
        myupload.upload(); //�ϴ��ļ�,�����Ǳ����
        int count = myupload.getFiles().getCount(); //ͳ���ϴ��ļ�������
        Request myRequest = myupload.getRequest(); //ȡ�� Request ����
        String rndFilename,fileExtName,fileName,filePathName,memo;
        Date dt = null;
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        for (int i=0;i<count;i++){//��һ��ȡ�ϴ��ļ���Ϣ��ͬʱ�ɱ����ļ�
            File file = myupload.getFiles().getFile(i); //ȡ��һ���ϴ��ļ�
            if (file.isMissing()) continue; //���ļ������������
            fileName = file.getFileName();//ȡ���ļ���
            filePathName = file.getFilePathName(); //ȡ���ļ�ȫ��
            fileExtName = file.getFileExt();// ȡ���ļ���չ��
            dt = new Date(System.currentTimeMillis()); //ȡ������ļ���
            Thread.sleep(100);
            rndFilename= fmt.format(dt)+"."+fileExtName;
            memo = myRequest.getParameter("memo"+i);
//��ʾ��ǰ�ļ���Ϣ
            out.println("��"+(i+1)+"���ļ����ļ���Ϣ��<br>");
            out.println("�ļ���Ϊ��"+fileName+"<br>");
            out.println("�ļ���չ��Ϊ��"+fileExtName+"<br>");
            out.println("�ļ�ȫ��Ϊ��"+filePathName+"<br>");
            out.println("�ļ���СΪ��"+file.getSize()+"�ֽ�<br>");
            out.println("�ļ���עΪ��"+memo+"<br>");
            out.println("�ļ�����ļ���Ϊ��"+rndFilename+"<br><br>");




            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url="jdbc:mysql://localhost:3306/userdb?useSSL=false";
            Connection conn = DriverManager.getConnection(url,"root","1");
            PreparedStatement pstat = null;
            ResultSet rs = null;
            String sql = null;




            sql = "insert into photo (fileName,fileExtName,filePathName,size,memo,rndFilename) values(?,?,?,?,?,?)";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1,fileName);
            pstat.setString(2,fileExtName);

            pstat.setString(3,filePathName);
            pstat.setInt(4,file.getSize());
            pstat.setString(5,memo);
            pstat.setString(6,rndFilename);

            pstat.executeUpdate();
            pstat.close();
            conn.close();


       //     String pathFile=session.getServletContext().getRealPath("/webapp/");   //ע�� ����ļ���Ҫ��û�еĻ��ǻᱨ���

//���ļ����,��Ӧ�õĸ�Ŀ¼��Ϊ�ϴ��ļ��ĸ�Ŀ¼����ȷ��Ŀ¼���ڣ�
             file.saveAs("/" + rndFilename, myupload.SAVE_VIRTUAL);
        }
        out.println(count+"���ļ��ϴ��ɹ���<br>");
    }catch(Exception ex){
        out.println("�ϴ��ļ������������������ϴ�ʧ��!<br>");
        out.println("����ԭ��<br>"+ex.toString());
    }
%>
</body>
</html>