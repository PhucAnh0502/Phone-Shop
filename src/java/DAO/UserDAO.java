/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import static com.sun.tools.javac.tree.TreeInfo.args;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
/**
 *
 * @author PHUCANH
 */
public class UserDAO {
    public static Connection openConnection(){
        Connection conn = null;
        try{
            System.out.println("Hello from DBConfig.driver " + DBConfig.driver);
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url, DBConfig.username, DBConfig.password);
            System.out.println("Connected Successfully");
        } catch(Exception ex){
            ex.printStackTrace();
        }
        return conn;
    }
    
    public static User checkSignin(String username, String password){
        try(Connection c = openConnection()){
            String select = String.format("select * from users where username = '%s' and password = '%s'", username, password);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return new User(rs.getInt("id"),rs.getString("username"),rs.getString("password"),rs.getString("first_name"),rs.getString("last_name"),rs.getString("gender"),rs.getString("birthday"));
            }
            return null;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
    
    public static boolean isExistUsername(String username){
        try(Connection c = openConnection()){
            String select = String.format("select * from users where username = '%s'", username);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
            return false;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return true;
    }
    
    public static boolean insertUser(User user){
        try(Connection c = openConnection()){
            String insert = String.format("INSERT INTO users(username,password) VALUES ('%s','%s');", user.getUsername(),user.getPassword());
            PreparedStatement ps = c.prepareStatement(insert);
            int row = ps.executeUpdate(insert);
            return row>=1 ? true : false;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return true;
    }
}
