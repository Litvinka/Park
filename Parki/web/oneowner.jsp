<%-- 
    Document   : oneowner
    Created on : 04.12.2016, 1:38:30
    Author     : Masha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Park.Owner"%>

<%!Owner f; %>
<% request.setCharacterEncoding("UTF-8");
    if(request.getMethod().compareToIgnoreCase("GET")==0){
    f=new Owner();
    f=f.Select(Integer.parseInt(request.getParameter("owner")));
}%>

<%String[] com={"","","","",""};
boolean error=false;
String result="";
if(request.getParameter("update")!=null){
    f=new Owner(Integer.parseInt(request.getParameter("id")),request.getParameter("name").trim(),request.getParameter("surname").trim(),request.getParameter("putronumic").trim(),request.getParameter("phone").trim(),request.getParameter("email").trim());
    com=f.inspectionForm();
    for(int i=0;i<5;++i){
        if(com[i].compareTo("")!=0){
            error=true;
            break;
        }
    }
    if(!error){
        f.Update();
        result="Данные изменены успешно!";
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <title>Владелец</title>
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
                <li class="now"><a href="owner.jsp">владельцы</a></li>
                <li><a href="designation.jsp">указания</a></li>
            </ul>
        </nav>
        
        <div class="container" style="margin-top:45px">
            <section class="back">
                <a href="owner.jsp"><button>к списку владельцев</button></a>
            </section>
            <article id="updateowner">
                <span class="good"><%=result%></span>  
             <form name="updateowner" method="POST">
                    <h3>Изменить данные</h3>
                    <input type="hidden" name="id" value="<%=f.getOwnerID()%>">
                    <p>Имя<span class="star">*</span>  <span class="comment"><%=com[0]%></span></p>
                    <input type="text" name="name" value="<%=f.getName()%>">
                    <p>Фамилия<span class="star">*</span>  <span class="comment"><%=com[1]%></span></p>
                    <input type="text" name="surname" value="<%=f.getSurname()%>">
                    <p>Отчество<span class="star">*</span>  <span class="comment"><%=com[2]%></span></p>
                    <input type="text" name="putronumic" value="<%=f.getPutronumic()%>">
                    <p>Телефон<span class="star">*</span>  <span class="comment"><%=com[3]%></span></p>
                    <input type="text" name="phone" value="<%=f.getPhone()%>">
                    <p>Email<span class="star">*</span>  <span class="comment"><%=com[4]%></span></p>
                    <input type="email" name="email" value="<%=f.getEmail()%>">
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

