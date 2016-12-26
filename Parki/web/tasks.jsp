<%-- 
    Document   : tasks
    Created on : 21.11.2016, 12:16:43
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

<% if(session.getAttribute("ROLE").toString().compareTo("лесник")==0){
    response.sendRedirect("tasks_forester.jsp");
}%>

<%!ArrayList<Forester> forester;
    Forester g;%>
    <%g=new Forester();
    request.setCharacterEncoding("UTF-8");
    forester = new ArrayList<Forester>();
    forester=g.Select();%>
    
    <%!ArrayList<Designation> designation;
    Designation a;%>
    <%a=new Designation();
    designation = new ArrayList<Designation>();
    designation=a.Select();%>
    
    <%!ArrayList<Plant> plants;
    Plant p;%>
    <%p=new Plant();
    plants = new ArrayList<Plant>();
    plants=p.Select();%>
    
<%!ArrayList<Task> task;
    Task t;%>
    <%t=new Task();
    task = new ArrayList<Task>();
    String str="SELECT *, owner.`Name`,owner.`Surname`,forester.`Name`,forester.`Surname`,designation.`Designation`,plant.`Name` FROM task join owner ON owner.`OwnerID`=task.`OwnerID` join forester ON forester.`ForesterID`=task.`ForesterID` join designation ON designation.`DesignationID`=task.`DesignationID` join plant ON plant.`PlantID`=task.`PlantID` WHERE Performence=0 AND owner.`OwnerID`="+session.getAttribute("ID");
    task=t.Select(str);
    if(request.getParameter("del")!=null){
    t.Delete(Integer.parseInt(request.getParameter("del")));
    response.sendRedirect("tasks.jsp");}
%>  

<%  if(request.getParameter("t")!=null){
    if(request.getParameter("t").compareTo("1")==0){
        str="SELECT *, owner.`Name`,owner.`Surname`,forester.`Name`,forester.`Surname`,designation.`Designation`,plant.`Name` FROM task join owner ON owner.`OwnerID`=task.`OwnerID` join forester ON forester.`ForesterID`=task.`ForesterID` join designation ON designation.`DesignationID`=task.`DesignationID` join plant ON plant.`PlantID`=task.`PlantID` WHERE Performence=1 AND ConfirmationPerformence=0 AND owner.`OwnerID`="+session.getAttribute("ID");
        task=t.Select(str);
    }
    if(request.getParameter("t").compareTo("2")==0){
        str="SELECT *, owner.`Name`,owner.`Surname`,forester.`Name`,forester.`Surname`,designation.`Designation`,plant.`Name` FROM task join owner ON owner.`OwnerID`=task.`OwnerID` join forester ON forester.`ForesterID`=task.`ForesterID` join designation ON designation.`DesignationID`=task.`DesignationID` join plant ON plant.`PlantID`=task.`PlantID` WHERE ConfirmationPerformence=1 AND owner.`OwnerID`="+session.getAttribute("ID");
        task=t.Select(str);
    }
}
%>

<%String[] com={"","","","",""};
int max=t.max()+1;
boolean error=false;
String result="";
if(request.getParameter("add")!=null){
    long curTime = System.currentTimeMillis(); 
    Date curDate = new Date(curTime); 
    t=new Task(Integer.parseInt(request.getParameter("id")),session.getAttribute("ID").toString(),request.getParameter("designation"),request.getParameter("forester"),request.getParameter("plant"),curDate,false,false,request.getParameter("comment"));
    if(!error){
        t.Add();
        response.sendRedirect("tasks.jsp");
    }
}

if(request.getParameter("save")!=null){
    if(request.getParameter("perform")==null){
        t.Update("UPDATE task SET Performence=0,ConfirmationPerformence=0 WHERE TaskID="+request.getParameter("taskID"));
        response.sendRedirect("tasks.jsp");
    }
    else if(Integer.parseInt(request.getParameter("perform"))==1){
        t.Update("UPDATE task SET Performence=1, ConfirmationPerformence=1 WHERE TaskID="+request.getParameter("taskID"));
        response.sendRedirect("tasks.jsp?t=2");
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <title>Задания</title>
    </head>
    <body>
        <% if(session.getAttribute("ROLE")!=null && (session.getAttribute("ROLE").toString().compareTo("владелец")==0)){ %>
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
        
        <div class="delete">   
        </div>
        <section class="delet">
            <img src="image/delete.jpg" onclick="display();"/>
            <h4>Вы действительно хотите удалить задание?</h4>
            <button onclick="window.location.href='tasks.jsp?del='+$_GET('task')">Да</button>
            <button onclick="display();">Отмена</button>
        </section>
        
        <h2>Задания</h2>
        <ul style="width:70%;">
            <li <%if(request.getParameter("t")==null){%>class="now"<% } %>><a href="tasks.jsp">Текущие задания</a></li>
            <li <%if(request.getParameter("t")!=null && request.getParameter("t").compareTo("1")==0){%>class="now"<% } %>><a href="tasks.jsp?t=1">Ожидают подтверждения</a></li>
            <li <%if(request.getParameter("t")!=null && request.getParameter("t").compareTo("2")==0){%>class="now"<% } %>><a href="tasks.jsp?t=2">Архив</a></li>
        </ul>
        <div class="container">
            <article id="task">
                <table class="table">
                        <tr class="visible">
                            <td>ЛЕСНИК</td>
                            <td>УКАЗАНИЕ</td>
                            <td>РАСТЕНИЕ</td>
                            <td>ДОБАВЛЕНО</td>
                            <td>ВЫПОЛНЕНО</td>
                            <%if(request.getParameter("t")==null){ %>
                                <td></td>
                                <td></td>
                            <% } %>
                        </tr>
                        <% for(int i=0;i<task.size();++i){ %>
                        <tr>
                            <td class="visible"><%=task.get(i).getForester()%></td>
                            <td><%=task.get(i).getDesignation()%></td>
                            <td><%=task.get(i).getPlant()%></td>
                            <td class="visible"><%=task.get(i).getDatestart()%></td>
                            <td><form method="POST">
                                        <input type="hidden" name="taskID" value="<%=task.get(i).getTaskID()%> "/>
                                        <input type="checkbox" <%if(request.getParameter("t")!=null){%> checked <% } %> name="perform" value="1"> 
                                        <input type="submit" name="save" value="" title="сохранить" style="background: url(image/save.png); cursor:pointer; width:20px; height:20px; border:1px solid gray;">
                            </form></td>
                            <%if(request.getParameter("t")==null){ %><td>
                                <a href="onetask.jsp?task=<%=task.get(i).getTaskID()%>"><img class="edit" src="image/edit.png" title="редактировать"></a>
                            </td>
                            <td>
                                <a href="tasks.jsp?task=<%=task.get(i).getTaskID()%>"><img class="edit" src="image/delete.jpg" title="удалить"></a>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                </table>
            </article>
            <section id="addtask">
                <form name="task" method="POST">
                    <h3>Добавить задание</h3>
                    <input type="hidden" name="id" value="<%=max%>">
                    <p>Лесник<span class="star">*</span></p>
                    <select name="forester">
                        <% for(int i=0;i<forester.size();++i){ %>
                        <option value="<%=forester.get(i).getForesterID()%>" <% if(request.getParameter("add")!=null && (Integer.parseInt(request.getParameter("forester"))==forester.get(i).getForesterID())){ %> <%="selected"%> <% } %>><%=forester.get(i).getSurname()%> <%=forester.get(i).getName()%></option>
                        <% } %>
                    </select>
                    <p>Указание<span class="star">*</span></p>
                    <select name="designation">
                        <% for(int i=0;i<designation.size();++i){ %>
                        <option value="<%=designation.get(i).getDesignationID()%>" <% if(request.getParameter("add")!=null && (Integer.parseInt(request.getParameter("designation"))==designation.get(i).getDesignationID())){ %> <%="selected"%> <% } %>><%=designation.get(i).getDesignation()%></option>
                        <% } %>
                    </select>
                    <p>Растение<span class="star">*</span></p>
                    <select name="plant">
                        <% for(int i=0;i<plants.size();++i){ %>
                        <option value="<%=plants.get(i).getPlantID()%>" <% if(request.getParameter("add")!=null && (Integer.parseInt(request.getParameter("plant"))==plants.get(i).getPlantID())){ %> <%="selected"%> <% } %>><%=plants.get(i).getName()%></option>
                        <% } %>
                    </select>
                    <p>Описание</p>
                    <textarea name="comment"></textarea>
                    <input type="submit" name="add" class="submit" value="добавить">
                </form>
            </section>
        </div>  
        <footer>
            <h6>@2016 Мария Долбич</h6>
        </footer>
        <script>
            function $_GET(key) {
                var p = window.location.search;
                p = p.match(new RegExp(key + '=([^&=]+)'));
                return p ? p[1] : false;
            }  
            if($_GET('task')){
                display();
            }
            function display(){
                var x=document.getElementsByClassName("delet")[0];
                var y=document.getElementsByClassName("delete")[0];
                if(x.style.display=='block'){
                    x.style.display='none';
                    y.style.display='none';
                    window.location.href='tasks.jsp';
                }
                else{
                    x.style.display='block';
                    y.style.display='block';
                }
            }
        </script> 
        
        <% }
        else{ %>
            <h2>Данная страница недоступна! Для просмотра данных <a style="color:blue" href="index.jsp">войдите как владелец парка</a>.</h3>
        <% } %>
        
    </body>
</html>
