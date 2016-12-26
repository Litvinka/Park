package Park;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Masha
 */
public class Input {
    private String role;
    private String name;
    private String email;

    public Input(String role, String name,String email) {
        this.role = role;
        this.name = name;
        this.email = email;
    }

    public Input() {
        this.role="";
        this.name="";
        this.email="";
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public int input(){
        DBConnection k=new DBConnection();
        int id=0;
        try{
            ResultSet rs;
            Statement st=k.connect();
            if(this.getRole().compareTo("владелец")==0){
               rs=st.executeQuery("SELECT * FROM owner WHERE Email='"+this.getEmail()+"' AND Surname='"+this.getName()+"'"); 
            }
            else{
                rs=st.executeQuery("SELECT * FROM forester WHERE Email='"+this.getEmail()+"' AND Surname='"+this.getName()+"'");
            }
        if(rs.next()){
            if(this.getRole().compareTo("владелец")==0){
                id=rs.getInt("OwnerID");
            }
            else{
                id=rs.getInt("ForesterID");
            }
        }
            k.disconnect(rs);
            return id;
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return id;
    }
}
