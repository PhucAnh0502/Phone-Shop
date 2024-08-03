/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PHUCANH
 */
public class Comment {
    private int id;
    private User user;
    private Product product;
    private String content;
    
    public Comment(){
        
    }

    public Comment(int id, User user, Product product, String content) {
        this.id = id;
        this.user = user;
        this.product = product;
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Product getProduct() {
        return product;
    }

    public String getContent() {
        return content;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    
}
