/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Park;

import java.sql.Date;
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
public class Task {
    private int TaskID;
    private String owner;
    private String designation;
    private String forester;
    private String plant;
    private Date datestart;
    private boolean performance;
    private boolean confirmationperformence;
    private String comment;

    public Task(int TaskID, String owner, String designation, String forester, String plant, Date datestart, boolean performance, boolean confirmationperformence, String comment) {
        this.TaskID = TaskID;
        this.owner = owner;
        this.designation = designation;
        this.forester = forester;
        this.plant = plant;
        this.datestart = datestart;
        this.performance = performance;
        this.confirmationperformence = confirmationperformence;
        this.comment = comment;
    }
    
    public Task(){
        
    }

    public int getTaskID() {
        return TaskID;
    }

    public void setTaskID(int TaskID) {
        this.TaskID = TaskID;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getForester() {
        return forester;
    }

    public void setForester(String forester) {
        this.forester = forester;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }

    public Date getDatestart() {
        return datestart;
    }

    public void setDatestart(Date datestart) {
        this.datestart = datestart;
    }

    public boolean isPerformance() {
        return performance;
    }

    public void setPerformance(boolean performance) {
        this.performance = performance;
    }

    public boolean isConfirmationperformence() {
        return confirmationperformence;
    }

    public void setConfirmationperformence(boolean confirmationperformence) {
        this.confirmationperformence = confirmationperformence;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public ArrayList<Task> Select(String str){
        ArrayList<Task> f = new ArrayList<>();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery(str);
        while (rs.next()) {
            f.add(new Task(rs.getInt("TaskID"),rs.getString("owner.Surname"), rs.getString("designation.Designation"),rs.getString("forester.Surname"),rs.getString("plant.Name"),rs.getDate("DateStart"),rs.getBoolean("Performence"),rs.getBoolean("ConfirmationPerformence"),rs.getString("Comment")));
            }
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public void Delete(int id){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        System.out.println("id");
        st.executeUpdate("DELETE FROM task WHERE TaskID="+id);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Update(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("UPDATE task SET DesignationID='"+Integer.parseInt(this.getDesignation())+"', ForesterID='"+Integer.parseInt(this.getForester())+"', PlantID='"+Integer.parseInt(this.getPlant())+"',Comment='"+this.getComment()+"' WHERE TaskID="+this.getTaskID());
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Update(String str){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate(str);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public Task Select(int id){
        Task f =new Task();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM Task WHERE TaskID="+id);
        rs.next();
        f=new Task(rs.getInt("TaskID"),rs.getString("OwnerID"), rs.getString("DesignationID"),rs.getString("ForesterID"),rs.getString("PlantID"),rs.getDate("DateStart"),rs.getBoolean("Performence"),rs.getBoolean("ConfirmationPerformence"),rs.getString("Comment"));
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public void Add(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("INSERT INTO task (TaskID,OwnerID,DesignationID,ForesterID,PlantID,DateStart,Performence,ConfirmationPerformence,Comment) VALUES("+this.getTaskID()+",'"+Integer.parseInt(this.getOwner())+"','"+Integer.parseInt(this.getDesignation())+"','"+Integer.parseInt(this.getForester())+"','"+Integer.parseInt(this.getPlant())+"','"+this.getDatestart()+"','"+"0"+"','"+"0"+"','"+this.getComment()+"')");
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
        ResultSet rs=st.executeQuery("SELECT max(TaskID) as max FROM task");
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
