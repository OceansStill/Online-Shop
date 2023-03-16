package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class photoDao {
    public List getPhoto( )
    {

        DB_Dao dao = new DB_Dao();
        List<photoBean> list = new ArrayList<>();

        try {
            Connection conn = dao.getCon();
            String sql = "select * from photo";
            PreparedStatement ps = conn.prepareStatement(sql);

            //执行全部查询
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {   photoBean photos=new photoBean();
                photos.setRndFilename(rs.getString("rndFilename"));

                list.add(photos);
               // close(conn,ps,rs);

            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }


        return list;
    }

}
