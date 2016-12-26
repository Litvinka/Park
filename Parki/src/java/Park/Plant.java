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

public class Plant {
    private int plantID;
    private String name;
  
    public Plant(int plantID, String name){
        this.plantID=plantID;
        this.name=name;
    }
    
    public Plant(){
        name="";
    }
    
    public int getPlantID(){
        return this.plantID;
    }
    public void setPlantID(int plantID){
        this.plantID=plantID;
    }
    
    public String getName(){
        return this.name;
    }
    public void setName(String name){
        this.name=name;
    }

    
    public ArrayList<Plant> Select(){
        ArrayList<Plant> f = new ArrayList<>();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM plant");
        while (rs.next()) {
            f.add(new Plant(rs.getInt("PlantID"),rs.getString("Name")));
            }
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public Plant Select(int id){
        Plant f =new Plant();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM plant WHERE PlantID="+id);
        rs.next();
        f=new Plant(rs.getInt("PlantID"),rs.getString("Name"));
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
        st.executeUpdate("UPDATE plant SET Name='"+this.getName()+"' WHERE PlantID="+this.getPlantID());
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
        st.executeUpdate("DELETE FROM task WHERE PlantID="+id);
        st.executeUpdate("DELETE FROM plant WHERE PlantID="+id);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Add(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("INSERT INTO plant (PlantID,Name) VALUES("+this.getPlantID()+",'"+this.getName()+"')");
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
        ResultSet rs=st.executeQuery("SELECT max(PlantID) as max FROM plant");
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
