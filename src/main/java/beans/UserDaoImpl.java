package beans;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class UserDaoImpl implements UserDao{

    Connection conn = null;
    PreparedStatement ps = null;
    PreparedStatement ps1 = null;
    ResultSet rs = null;

    public boolean setUser(UserBean user) {
        DB_Dao dao = new DB_Dao();
        try {
            conn = dao.getCon();
            //判断传送过来的username数据库中是否已经存在,如果存在则返回false
            String sql1 = "select count(1) from users where username = ?";
            ps1 = conn.prepareStatement(sql1);
            ps1.setString(1,user.getName());
            rs = ps1.executeQuery();
            while(rs.next())
            {
                if(rs.getInt(1)>0)
                {
                    return false;
                    //close(conn,ps,rs);

                }
            }
            //如果没被注册,执行插入语句
            String sql = "insert into users(username,password) values(?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1,user.getName());
            ps.setString(2,user.getPassword());
            //执行更新
            ps.executeUpdate();
            //close(conn,ps,rs);
            return true;
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        //判断账号是否已被注册
        return false;
    }


    //=====登陆校验=====
    public boolean getUser(UserBean user)
    {

        DB_Dao dao = new DB_Dao();
        try {
            conn = dao.getCon();
            String sql = "select * from users where username = ? and password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            //执行全部查询
            rs = ps.executeQuery();
            UserBean users = null;
            if(rs.next())
            {
                users = new UserBean();
                users.setName(rs.getString("username"));
                users.setPassword(rs.getString("password"));
                //close(conn,ps,rs);
                return true;
            }
            else
            {
                //close(conn,ps,rs);
                return false;
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return false;
    }

    //=====重复校验=====
    public boolean checkUser(UserBean user)
    {

        DB_Dao dao = new DB_Dao();
        try {
            conn = dao.getCon();
            String sql = "select * from users where username = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            //执行全部查询
            rs = ps.executeQuery();
            if(rs.next())
            {

                //close(conn,ps,rs);
                return false;
            }
            else
            {
                //close(conn,ps,rs);
                return true;
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return false;
    }
}