/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.UserDAO.openConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Product;
import model.Supplier;
import model.User;

/**
 *
 * @author PHUCANH
 */
public class SupplierDAO {
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
    
    public static ArrayList<Supplier> getSupplierList(){
        try(Connection c = openConnection()){
            String select = String.format("select * from suppliers");
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<Supplier> arr = new ArrayList<>();
            while(rs.next()){
                arr.add(new Supplier(rs.getInt("id"), rs.getString("company_name"), rs.getString("address"),rs.getString("contact")));
            }
            return arr;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
    
}
