package beans;


// JDBC -- JavaBean层
public interface UserDao{
    //用户登录方法的声明
    public boolean getUser(UserBean user);
    //用户注册方法的声明
    public boolean setUser(UserBean user);
    public boolean checkUser(UserBean user);

}