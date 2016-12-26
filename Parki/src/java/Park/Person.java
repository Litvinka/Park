package Park;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author Masha
 */
public class Person {
    private String name;
    private String surname;
    private String putronumic;
    private String phone;
    private String email;
    
    public Person(String name,String surname,String putronumic, String phone, String email){
        this.name=name;
        this.surname=surname;
        this.putronumic=putronumic;
        this.phone=phone;
        this.email=email;
    }
    public Person(){
        this.name="";
        this.surname="";
        this.putronumic="";
        this.phone="";
        this.email="";
    }
    
    public String getName(){
        return this.name;
    }
    public void setName(String name){
        this.name=name;
    }
    
    public String getSurname(){
        return this.surname;
    }
    public void setSurname(String surname){
        this.surname=surname;
    }
    
    public String getPutronumic(){
        return this.putronumic;
    }
    public void setPutronumic(String putronumic){
        this.putronumic=putronumic;
    }
    
    public String getPhone(){
        return this.phone;
    }
    public void setPhone(String phone){
        this.phone=phone;
    }
    
    public String getEmail(){
        return this.email;
    }
    public void setEmail(String email){
        this.email=email;
    }
    
    public String[] inspectionForm(){
        String[] comments=new String[5];
        Pattern email=Pattern.compile("\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*\\.\\w{2,4}");
        Matcher memail=email.matcher(this.getEmail());
        for(int i=0;i<5;++i){
            comments[i]="";
        }
        if(this.getName().compareTo("")==0){
            comments[0]="Введите имя!";
        }
        if(this.getSurname().compareTo("")==0){
            comments[1]="Введите фамилию!";
        }
        if(this.getPutronumic().compareTo("")==0){
            comments[2]="Введите отчество!";
        }
        if(this.getPhone().compareTo("")==0){
            comments[3]="Введите телефон!";
        }
        else if(!this.getPhone().matches("\\+375+[0-9]{9}")){
            comments[3]="Некорректный формат ввода!";
        }
        if(this.getEmail().compareTo("")==0){
            comments[4]="Введите email!";
        }
        else if(!memail.matches()){
            comments[4]="Некорректный формат ввода!";
        }
        return comments;
    }
}


