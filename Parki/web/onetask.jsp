<%-- 
    Document   : onetask
    Created on : 06.12.2016, 9:46:53
    Author     : Masha
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Park.*"%>

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

<%!Task task; %>
<% request.setCharacterEncoding("UTF-8");
    if(request.getMethod().compareToIgnoreCase("GET")==0){
    task=new Task();
    task=task.Select(Integer.parseInt(request.getParameter("task")));
    System.out.println(task.getForester());
}%>

<%String[] com={"","","","",""};
boolean error=false;
String result="";
if(request.getParameter("update")!=null){
    long curTime = System.currentTimeMillis(); 
    Date curDate = new Date(curTime); 
    task=new Task(Integer.parseInt(request.getParameter("id")),session.getAttribute("ID").toString(), request.getParameter("designation"),request.getParameter("forester"),request.getParameter("plant"),curDate,false,false,request.getParameter("comment"));
    if(!error){
        task.Update();
        result="Данные изменены успешно!";
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <title>Задание</title>
    </head>
    <body>
        <% if(session.getAttribute("ROLE")!=null && (session.getAttribute("ROLE").toString().compareTo("владелец")==0)){ %>
        <header>
            <img class="menu" onclick="var x=document.getElementsByTagName('UL')[0];
                 if(x.style.display!='flex'){x.style.display='flex';}else{x.style.display='none';}" src="image/menu.png" />
            <a href="tasks.jsp"><h1>Система "Парк"</h1></a>
            <a href="index.jsp?del=true"><img class="out" src="image/out.png"/></a>
            <hgroup class="session">
                <h4>Вы вошли как <%=session.getAttribute("ROLE")%></h4>
            </hgroup>
        </header>
        <nav>
            <ul>
                <li class="now"><a href="tasks.jsp">задания</a></li>
                <li><a href="plant.jsp">растения</a></li>
                <li><a href="forester.jsp">лесники</a></li>
                <li><a href="owner.jsp">владельцы</a></li>
                <li><a href="designation.jsp">указания</a></li>
            </ul>
        </nav>
        
        <div class="container" style="margin-top:45px">
            <section class="back">
                <a href="tasks.jsp"><button>к списку заданий</button></a>
            </section>
            <article id="updatetask">
                <span class="good"><%=result%></span>  
             <form name="updatetask" method="POST">
                    <h3>Изменить задание</h3>
                    <input type="hidden" name="id" value="<%=request.getParameter("task")%>">
                    <p>Лесник<span class="star">*</span></p>
                    <select name="forester">
                        <% for(int i=0;i<forester.size();++i){ %>
                        <option value="<%=forester.get(i).getForesterID()%>" <% if(Integer.parseInt(task.getForester())==forester.get(i).getForesterID()){ %> <%="selected"%> <% } %>><%=forester.get(i).getSurname()%> <%=forester.get(i).getName()%></option>
                        <% } %>
                    </select>
                    <p>Указание<span class="star">*</span></p>
                    <select name="designation">
                        <% for(int i=0;i<designation.size();++i){ %>
                        <option value="<%=designation.get(i).getDesignationID()%>" <% if(Integer.parseInt(task.getDesignation())==designation.get(i).getDesignationID()){ %> <%="selected"%> <% } %>><%=designation.get(i).getDesignation()%></option>
                        <% } %>
                    </select>
                    <p>Растение<span class="star">*</span></p>
                    <select name="plant">
                        <% for(int i=0;i<plants.size();++i){ %>
                        <option value="<%=plants.get(i).getPlantID()%>" <% if(Integer.parseInt(task.getPlant())==plants.get(i).getPlantID()){ %> <%="selected"%> <% } %>><%=plants.get(i).getName()%></option>
                        <% } %>
                    </select>
                    <p>Описание</p>
                    <textarea name="comment"></textarea>
                    <input type="submit" name="update" class="update" value="Сохранить изменения">
                </form>
            </article>
        </div>
        <footer>
            <h6>@2016 Мария Долбич</h6>
        </footer>
        <% }
        else{ %>
            <h2>Данная страница недоступна! Для просмотра данных <a style="color:blue" href="index.jsp">войдите как владелец парка</a>.</h3>
        <% } %>
    </body>
</html>
