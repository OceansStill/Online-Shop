package beans;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DB_Dao {
    static final String url = "jdbc:mysql://localhost:3306/userdb?useSSL=false";
    static final String user = "root";
    static final String pass = "1";
    static final String driver = "com.mysql.jdbc.Driver";
    Connection conn = null;

    //Dao
    public Connection getCon() throws ClassNotFoundException, SQLException {
        //注册驱动
        Class.forName(driver);
        //连接驱动
        conn = DriverManager.getConnection(url, user, pass);

        return conn;
    }

    //关闭资源，避免出现异常
    public static void close(Connection con, PreparedStatement ps , ResultSet rs)
    {
        if(rs != null)
        {
            try
            {
                rs.close();
            }
            catch(SQLException e)
            {
                e.printStackTrace();
            }
        }
        if(ps != null)
        {
            try {
                ps.close();
            }catch(SQLException e)
            {
                e.printStackTrace();
            }
        }
        if(con != null)
        {
            try {
                con.close();
            }catch(Exception e)
            {
                e.printStackTrace();
            }
        }

    }

}