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
import model.Comment;
import model.Product;
import model.User;

/**
 *
 * @author PHUCANH
 */
public class ProductDAO {
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
    
    public static ArrayList<String> getImagesByProductId(int productId){
        try(Connection c = openConnection()){
            String select = String.format("select image_url from web_project.product_images where product_id = %d", productId);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<String> arr = new ArrayList<>();
            while(rs.next()){
                arr.add(rs.getString("image_url"));
            }
            return arr;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
    
    public static int getTotalCounts(String filter){
        try ( Connection c = openConnection()) {
            String select = String.format("select count(*) as cnt from products %s", filter);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt");
            }
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 1;
    }
    
    public static ArrayList<Product> getProductList(String sortBy, String order, String filter, int page) {
        try ( Connection c = openConnection()) {
            if (sortBy == null) {
                sortBy = "id";
            }
            if(sortBy != null && !sortBy.equals("sale_rate")){
            sortBy = "products." + sortBy;
            }
            if (order == null) {
                order = "asc";
            }
            if (filter == null) {
                filter = "";
            }
            
            int pageSize = 6; //6 sp/trang
            int start = (page - 1)*pageSize;
            String select = String.format(""
                    + "select *, (compare_at_price - price) / compare_at_price as sale_rate\n"
                    + "from products\n"
                    + "join product_images\n"
                    + "on products.id = product_images.product_id\n"
//                    + "group by products.id\n"
                    + filter + " "
                    + "order by %s %s\n"
                    + "limit %d\n"
                    + "offset %d", sortBy, order, pageSize, start);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<Product> arr = new ArrayList<>();
            while (rs.next()) {
                ArrayList<String> images = new ArrayList<>();
                images.add(rs.getString("image_url"));
                Product product = new Product(rs.getInt("id"), rs.getString("title"), rs.getString("description"),
                        rs.getInt("price"), rs.getInt("compare_at_price"), rs.getInt("quantity"));
                product.setImages(images);
                arr.add(product);
            }
            return arr;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Comment> getCommentsByProduct(Product product){
        try ( Connection c = openConnection()) {
            String select = String.format("select comments.*, users.username, users.first_name, users.last_name\n"
                    + "from web_project.comments\n"
                    + "join users\n"
                    + "on users.id = comments.user_id\n"
                    + "where product_id = %d\n"
                    + "order by id desc", product.getId());
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<Comment> cmts = new ArrayList<Comment>();
            while (rs.next()) {
                User user = new User(rs.getString("username"),rs.getString("first_name"),rs.getString("last_name"));
                Comment comment = new Comment(rs.getInt("id"),user, product, rs.getString("content"));
                cmts.add(comment);
            }
            return cmts;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public static Product getProductById(int id) {
        try ( Connection c = openConnection()) {
            String select = String.format("select * from products where id = %d", id);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product(rs.getInt("id"), rs.getString("title"), rs.getString("description"),
                        rs.getInt("price"), rs.getInt("compare_at_price"), rs.getInt("quantity"));
                ArrayList<String> images = getImagesByProductId(product.getId());
                product.setImages(images);
                ArrayList<Comment> cmts = getCommentsByProduct(product);
                product.setComments(cmts);
                return product;
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public static boolean createComment(int userId, int productId,String content){
        try(Connection c = openConnection()){
            String insert = String.format("INSERT INTO comments VALUES (null, %d, %d, '%s',now());", userId,productId,content);
            PreparedStatement ps = c.prepareStatement(insert);
            int row = ps.executeUpdate(insert);
            return row>=1 ? true : false;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return true;
    }
}
