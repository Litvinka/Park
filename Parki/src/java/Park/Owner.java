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
public class Owner extends Person{
    private int ownerID;
    
    public Owner(int ownerID, String name,String surname, String putronumic, String phone, String email){
        super(name, surname, putronumic, phone, email);
        this.ownerID=ownerID;
    }
    public Owner(){
        super();
    }
    
    public int getOwnerID(){
        return this.ownerID;
    }
    public void setOwner(int ownerID){
        this.ownerID=ownerID;
    }
    
    public ArrayList<Owner> Select(){
        ArrayList<Owner> f = new ArrayList<>();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM owner");
        while (rs.next()) {
            f.add(new Owner(rs.getInt("OwnerID"),rs.getString("Name"),rs.getString("Surname"),rs.getString("Patronumic"),rs.getString("Phone"),rs.getString("Email")));
            }
        k.disconnect(rs);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return f;
    }
    
    public Owner Select(int id){
        Owner f =new Owner();
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        ResultSet rs=st.executeQuery("SELECT * FROM owner WHERE OwnerID="+id);
        rs.next();
        f=new Owner(rs.getInt("OwnerID"),rs.getString("Name"),rs.getString("Surname"),rs.getString("Patronumic"),rs.getString("Phone"),rs.getString("Email"));
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
        st.executeUpdate("UPDATE owner SET Name='"+this.getName()+"', Surname='"+this.getSurname()+"', Patronumic='"+this.getPutronumic()+"', Phone='"+this.getPhone()+"', Email='"+this.getEmail()+"' WHERE OwnerID="+this.ownerID);
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
        st.executeUpdate("DELETE FROM task WHERE OwnerID="+id);
        st.executeUpdate("DELETE FROM owner WHERE OwnerID="+id);
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public void Add(){
        DBConnection k=new DBConnection();
        try{
        Statement st=k.connect();
        st.executeUpdate("INSERT INTO owner (OwnerID,Name,Surname,Patronumic,Phone,Email) VALUES("+this.getOwnerID()+",'"+this.getName()+"','"+this.getSurname()+"','"+this.getPutronumic()+"','"+this.getPhone()+"','"+this.getEmail()+"')");
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
        ResultSet rs=st.executeQuery("SELECT max(OwnerID) as max FROM owner");
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


