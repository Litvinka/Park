package Park;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DBConnection {
    private String url = "jdbc:mysql://localhost:3306/parksy?zeroDateTimeBehavior=convertToNull";
    private String login = "root";
    private String password = "";
    private Statement stmt;
    private Connection con;
    
    public Statement connect(){
        try{
        con = DriverManager.getConnection(url, login, password);
        stmt = con.createStatement();
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
        return stmt;
    }
    
    public void disconnect(ResultSet rs){
        try{
        rs.close();
        stmt.close();
        con.close();
        }
        catch(SQLException ex){
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

}