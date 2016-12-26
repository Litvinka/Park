/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Park;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Masha
 */
public class Designation {
    private int DesignationID;
    private String Designation;

    public Designation() {
        this.Designation = "";
    }

    public Designation(int DesignationID, String Designation) {
        this.DesignationID = DesignationID;
        this.Designation = Designation;
    }

    public int getDesignationID() {
        return DesignationID;
    }

    public void setDesignationID(int DesignationID) {
        this.DesignationID = DesignationID;
    }

    public String getDesignation() {
        return Designation;
    }

    public void setDesignation(String Designation) {
        this.Designation = Designation;
    }
    
    public ArrayList<Designation> Select(){
        ArrayList<Designation> f = new ArrayList<>();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM designation");
        while (rs.next()) {
            f.add(new Designation(rs.getInt("DesignationID"),rs.getString("Designation")));
            }
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public Designation Select(int id){
        Designation f =new Designation();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM designation WHERE DesignationID="+id);
        rs.next();
        f=new Designation(rs.getInt("DesignationID"),rs.getString("Designation"));
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public void Update(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("UPDATE designation SET Designation='"+this.getDesignation()+"' WHERE DesignationID="+this.getDesignationID());
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Delete(int id){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        System.out.println("id");
        st.executeUpdate("DELETE FROM task WHERE DesignationID="+id);
        st.executeUpdate("DELETE FROM designation WHERE DesignationID="+id);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Add(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("INSERT INTO designation (DesignationID,Designation) VALUES("+this.getDesignationID()+",'"+this.getDesignation()+"')");
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public int max(){
        int max=0;
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT max(DesignationID) as max FROM designation");
        rs.next();
        max=rs.getInt("max");
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return max;
    }
}


