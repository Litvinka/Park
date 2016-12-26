<%-- 
    Document   : tasks_forester
    Created on : 11.12.2016, 2:30:14
    Author     : Masha
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormat"%>
<%@page import="Park.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    
<%!ArrayList<Task> task=new ArrayList<Task>();;
    Task t=new Task();
    String str="";
%>  

<%  if(request.getParameter("t")==null){
        str="SELECT *, owner.`Name`,owner.`Surname`,forester.`Name`,forester.`Surname`,designation.`Designation`,plant.`Name` FROM task join owner ON owner.`OwnerID`=task.`OwnerID` join forester ON forester.`ForesterID`=task.`ForesterID` join designation ON designation.`DesignationID`=task.`DesignationID` join plant ON plant.`PlantID`=task.`PlantID` WHERE Performence=0 AND forester.`ForesterID`="+session.getAttribute("ID");
        task=t.Select(str);
    }
    else if(request.getParameter("t")!=null){
    if(request.getParameter("t").compareTo("1")==0){
        str="SELECT *, owner.`Name`,owner.`Surname`,forester.`Name`,forester.`Surname`,designation.`Designation`,plant.`Name` FROM task join owner ON owner.`OwnerID`=task.`OwnerID` join forester ON forester.`ForesterID`=task.`ForesterID` join designation ON designation.`DesignationID`=task.`DesignationID` join plant ON plant.`PlantID`=task.`PlantID` WHERE Performence=1 AND ConfirmationPerformence=0 AND forester.`ForesterID`="+session.getAttribute("ID");
        task=t.Select(str);
    }
    if(request.getParameter("t").compareTo("2")==0){
        str="SELECT *, owner.`Name`,owner.`Surname`,forester.`Name`,forester.`Surname`,designation.`Designation`,plant.`Name` FROM task join owner ON owner.`OwnerID`=task.`OwnerID` join forester ON forester.`ForesterID`=task.`ForesterID` join designation ON designation.`DesignationID`=task.`DesignationID` join plant ON plant.`PlantID`=task.`PlantID` WHERE ConfirmationPerformence=1 AND forester.`ForesterID`="+session.getAttribute("ID");
        task=t.Select(str);
    }
}
if(request.getParameter("save")!=null){
    if(request.getParameter("perform")!=null){
        t.Update("UPDATE task SET Performence=1 WHERE TaskID="+request.getParameter("taskID"));
        response.sendRedirect("tasks_forester.jsp?t=1");
    }
    else{
        t.Update("UPDATE task SET Performence=0 WHERE TaskID="+request.getParameter("taskID"));
        response.sendRedirect("tasks_forester.jsp");
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <title>Tasks</title>
    </head>
    <body>
        
        <% if(session.getAttribute("ROLE")!=null && (session.getAttribute("ROLE").toString().compareTo("лесник")==0)){ %>
        
        <header>
            <img class="menu" onclick="var x=document.getElementsByTagName('UL')[0];
                 if(x.style.display!='flex'){x.style.display='flex';}else{x.style.display='none';}" src="image/menu.png" />
            <a href="#"><h1>Система "Парк"</h1></a>
            <a href="index.jsp?del=true"><img class="out" src="image/out.png"/></a>
            <hgroup class="session">
                <h4>Вы вошли как <%=session.getAttribute("ROLE")%></h4>
            </hgroup>
        </header>
        <nav>
            <ul>
                <li class="now"><a href="#">задания</a></li>
                <li><a href="plant.jsp">растения</a></li>
                <li><a href="forester.jsp">лесники</a></li>
                <li><a href="owner.jsp">владельцы</a></li>
                <li><a href="designation.jsp">указания</a></li>
            </ul>
        </nav>
        
        <h2>Задания</h2>
        <ul style="width:70%;">
            <li <%if(request.getParameter("t")==null){%>class="now"<% } %>><a href="tasks_forester.jsp">Текущие задания</a></li>
            <li <%if(request.getParameter("t")!=null && request.getParameter("t").compareTo("1")==0){%>class="now"<% } %>><a href="tasks_forester.jsp?t=1">Ожидают подтверждения</a></li>
            <li <%if(request.getParameter("t")!=null && request.getParameter("t").compareTo("2")==0){%>class="now"<% } %>><a href="tasks_forester.jsp?t=2">Архив</a></li>
        </ul>
        <div class="container">
            <article id="task">
                <table class="table">
                        <tr class="visible">
                            <td>ВЛАДЕЛЕЦ</td>
                            <td>УКАЗАНИЕ</td>
                            <td>РАСТЕНИЕ</td>
                            <td>ДОБАВЛЕНО</td>
                            <% if(request.getParameter("t")==null || (request.getParameter("t").compareTo("1")==0)){ %>
                                <td>ВЫПОЛНЕНО</td>
                            <% } %>
                        </tr>
                        <% for(int i=0;i<task.size();++i){ %>
                        <tr>
                            <td class="visible"><%=task.get(i).getOwner()%></td>
                            <td><%=task.get(i).getDesignation()%></td>
                            <td><%=task.get(i).getPlant()%></td>
                            <td class="visible"><%=task.get(i).getDatestart()%></td>
                            <% if(request.getParameter("t")==null || (request.getParameter("t").compareTo("1")==0)){ %>
                             <td>
                                 <form method="POST">
                                     <input type="hidden" name="taskID" value="<%=task.get(i).getTaskID()%>"/>
                                     <input type="checkbox" <% if(request.getParameter("t")!=null && (request.getParameter("t").compareTo("1")==0)){%> checked <% } %> name="perform" value="1"/>
                                     <input type="submit" name="save" value="" title="сохранить" style="background: url(image/save.png); cursor:pointer; width:20px; height:20px; border:1px solid gray;">
                                 </form>    
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                </table>
            </article>
          </div>  
        <footer class="footer">
            <h6>@2016 Мария Долбич</h6>
        </footer>
                        
<% } 
else{ %>
<h2>Данная страница недоступна! Для просмотра данных <a style="color:blue" href="index.jsp">войдите</a> как лесник.</h3>
<% } %>

    </body>
</html>

