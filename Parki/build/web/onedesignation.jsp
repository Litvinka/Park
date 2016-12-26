<%-- 
    Document   : onedesignation
    Created on : 05.12.2016, 1:40:03
    Author     : Masha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Park.Designation"%>

<%!Designation f; %>
<% request.setCharacterEncoding("UTF-8");
    if(request.getMethod().compareToIgnoreCase("GET")==0){
    f=new Designation();
    f=f.Select(Integer.parseInt(request.getParameter("designation")));
}%>
<%
String com="";
boolean error=false;
String result="";
if(request.getParameter("update")!=null){
    f=new Designation(Integer.parseInt(request.getParameter("id")),request.getParameter("text").trim());
    if(f.getDesignation().compareTo("")==0){
        com="Введите указание!";
    }
    else{
        f.Update();
        result="Указание изменено успешно!";
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <title>Указание</title>
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
                <li><a href="tasks.jsp">задания</a></li>
                <li><a href="plant.jsp">растения</a></li>
                <li><a href="forester.jsp">лесники</a></li>
                <li><a href="owner.jsp">владельцы</a></li>
                <li class="now"><a href="designation.jsp">указания</a></li>
            </ul>
        </nav>
        
        <div class="container" style="margin-top:45px">
            <section class="back">
                <a href="designation.jsp"><button>к списку указаний</button></a>
            </section>
            <article id="updatedesignation">
                <span class="good"><%=result%></span>  
             <form name="updatedesignation" method="POST">
                    <h3>Изменить указание</h3>
                    <input type="hidden" name="id" value="<%=f.getDesignationID()%>">
                    <p>Указание<span class="star">*</span>  <span class="comment"><%=com%></span></p>
                    <input type="text" name="text" value="<%=f.getDesignation()%>" >
                    <p><input type="submit" name="update" class="update" value="Сохранить изменения"></p>
                </form>
            </article>
        </div>
        <footer>
            <h6>@2016 Мария Долбич</h6>
        </footer
       <% }
        else{ %>
            <h2>Данная страница недоступна! Для просмотра данных <a style="color:blue" href="index.jsp">войдите как владелец парка</a>.</h2>
        <% } %>
    </body>
</html>


