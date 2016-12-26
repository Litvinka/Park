package Park;

import java.util.ArrayList;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Masha
 */
public class Forester extends Person{
    private int foresterID;
    
    public Forester(int foresterID, String name,String surname, String putronumic, String phone, String email){
        super(name, surname, putronumic, phone, email);
        this.foresterID=foresterID;
    }
    public Forester(){
        super();
    }
    
    public int getForesterID(){
        return this.foresterID;
    }
    public void setForester(int foresterID){
        this.foresterID=foresterID;
    }
    
    public ArrayList<Forester> Select(){
        ArrayList<Forester> f = new ArrayList<>();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM forester");
        while (rs.next()) {
            f.add(new Forester(rs.getInt("ForesterID"),rs.getString("Name"),rs.getString("Surname"),rs.getString("Patronumic"),rs.getString("Phone"),rs.getString("Email")));
            }
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public Forester Select(int id){
        Forester f =new Forester();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM forester WHERE ForesterID="+id);
        rs.next();
        f=new Forester(rs.getInt("ForesterID"),rs.getString("Name"),rs.getString("Surname"),rs.getString("Patronumic"),rs.getString("Phone"),rs.getString("Email"));
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
        st.executeUpdate("UPDATE forester SET Name='"+this.getName()+"', Surname='"+this.getSurname()+"', Patronumic='"+this.getPutronumic()+"', Phone='"+this.getPhone()+"', Email='"+this.getEmail()+"' WHERE ForesterID="+this.foresterID);
        
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
        st.executeUpdate("DELETE FROM task WHERE ForesterID="+id);
        st.executeUpdate("DELETE FROM forester WHERE ForesterID="+id);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Add(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("INSERT INTO forester (ForesterID,Name,Surname,Patronumic,Phone,Email) VALUES("+this.getForesterID()+",'"+this.getName()+"','"+this.getSurname()+"','"+this.getPutronumic()+"','"+this.getPhone()+"','"+this.getEmail()+"')");
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
        ResultSet rs=st.executeQuery("SELECT max(ForesterID) as max FROM forester");
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
