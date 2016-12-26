<%-- 
    Document   : index
    Created on : 14.11.2016, 12:35:34
    Author     : Masha
--%>

<%@page import="Park.*" %>
<%!boolean error=false;
   int b=0;
   Input inp=new Input();
   String[] err={"","",""};
   String[] data={"","",""};
%>

<%if(request.getMethod().compareToIgnoreCase("GET")==0){
    if(Boolean.parseBoolean(request.getParameter("del"))==true){
        session.removeAttribute("ROLE");
        session.removeAttribute("ID");
        response.sendRedirect("index.jsp");
    }
}    %>

<%  request.setCharacterEncoding("UTF-8");
    error=false;
    if(request.getParameter("submit")!=null){
        for(int i=0;i<3;++i){
            err[i]="";
        }
        data[0]=request.getParameter("role").trim();
        data[1]=request.getParameter("surname").trim();
        data[2]=request.getParameter("email").trim();
        if(data[0].compareTo("")==0){
            err[0]="Выберите роль!";
            error=true;
        }
        if(data[1].compareTo("")==0){
            err[1]="Введите фамилию!";
            error=true;
        }
        if(data[2].compareTo("")==0){
            err[2]="Введите email!";
            error=true;
        }
        if(!error){
            inp=new Input(data[0],data[1],data[2]);
            b=inp.input();
            if(b!=0){
                session.setAttribute("ROLE", inp.getRole());
                session.setAttribute("ID", b);
                if(inp.getRole().compareTo("владелец")==0){
                    response.sendRedirect("tasks.jsp");
                }
                else{
                    response.sendRedirect("tasks_forester.jsp");
                }
            }
            else{
                err[0]="Проверьте правильность введенных данных!";
            }
        }
    
} %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Вход в систему "Парк"</title>
        <link href="style/style.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <a href="#"><h1>Система "Парк"</h1></a>
        </header>
        <article>
            <form name="in" id="in" method="POST">
                <h3>Вход в систему</h3>
                <p>Владелец/лесник<span class="star">*</span>  <span class="comment"><%=err[0]%></span></p>
                <select name="role">
                    <option value="владелец">владелец</option>
                    <option value="лесник">лесник</option>
                </select>
                <p>Фамилия<span class="star">*</span>  <span class="comment"><%=err[1]%></span></p>
                <input type="text" name="surname" value="<%=inp.getName()%>">
                <p>Email<span class="star">*</span>  <span class="comment"><%=err[2]%></span></p>
                <input type="email" name="email" value="<%=inp.getEmail()%>">
                <p><input type="submit" name="submit" class="submit" value="войти"></p>
           </form>        
        </article>
        <footer class="footer">
            <h6>@2016 Мария Долбич</h6>
        </footer>
    </body>
</html>
