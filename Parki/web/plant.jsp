<%-- 
    Document   : plant
    Created on : 14.11.2016, 22:35:25
    Author     : Masha
--%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Park.Plant"%>

<%!ArrayList<Plant> f;
    Plant g;
    String name="";
    boolean err=false;%>
    <%g=new Plant();
    request.setCharacterEncoding("UTF-8");
        f = new ArrayList<Plant>();
        f=g.Select();%>
        
<% if(request.getParameter("del")!=null){
    g.Delete(Integer.parseInt(request.getParameter("del")));
    response.sendRedirect("plant.jsp");
}
String com="";
int max=g.max()+1;
String result="";
if(request.getParameter("add")!=null){
    g=new Plant(Integer.parseInt(request.getParameter("id")),request.getParameter("plant").trim());
    if(request.getParameter("plant").compareTo("")==0){
        com="Введите название!";
    }
    else{
        g.Add();
        response.sendRedirect("plant.jsp");
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Растения парка</title>
        <link href="style/style.css" rel="stylesheet">
    </head>
    <body>
        <%if(session.getAttribute("ROLE")!=null){%>
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
                <li class="now"><a href="#">растения</a></li>
                <li><a href="forester.jsp">лесники</a></li>
                <li><a href="owner.jsp">владельцы</a></li>
                <li><a href="designation.jsp">указания</a></li>
            </ul>
        </nav>
            
        <div class="delete">   
        </div>
        <section class="delet">
            <img src="image/delete.jpg" onclick="display();"/>
            <h4>Вы действительно хотите удалить данные о растении? Также будут удалены все задания, связанные с данным растением.</h4>
            <button onclick="window.location.href='plant.jsp?del='+$_GET('plant')">Да</button>
            <button onclick="display();">Отмена</button>
        </section>
            
        <h2>Растения</h2>
        <div class="container">
            <article id="allplant">
                <table class="table">
                        <tr>
                            <td class="visible">ID</td>
                            <td>РАСТЕНИЕ</td>
                            <% if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){ %>
                            <td></td>
                            <td></td>
                            <% } %>
                        </tr>
                            <% for(int i=0;i<f.size();++i){ %>
                        <tr>
                            <td class="visible"><%=f.get(i).getPlantID()%></td>
                            <td><%=f.get(i).getName()%></td>
                            <% if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){ %>
                            <td style="width:30px;">
                                <a href="oneplant.jsp?plant=<%=f.get(i).getPlantID()%>"><img class="edit" src="image/edit.png" title="редактировать"></a>
                            </td>
                            <td style="width:30px;">
                                <a href="plant.jsp?plant=<%=f.get(i).getPlantID()%>"><img class="edit" src="image/delete.jpg" title="удалить"/></a>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                </table>
            </article>
            <%if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){%>
            <section id="addplant">
                <form method="POST">
                    <h3>Новое растение</h3>
                    <input type="hidden" name="id" value="<%=max%>">
                    <p>Название<span class="star">*</span>  <span class="comment"><%=com%></span></p>
                    <input type="text" name="plant" value="<%=g.getName()%>" >
                    <input type="submit" name="add" class="submit" value="добавить"> 
                </form>
            </section>
            <% } %>
        </div>
        <footer <% if(session.getAttribute("ROLE").toString().compareTo("лесник")==0){ %> class="footer" <%}%> >
            <h6>@2016 Мария Долбич</h6>
        </footer>
        <script>
            function $_GET(key) {
                var p = window.location.search;
                p = p.match(new RegExp(key + '=([^&=]+)'));
                return p ? p[1] : false;
            }
            if($_GET('plant')){
                display();
            }
            function display(){
                var x=document.getElementsByClassName("delet")[0];
                var y=document.getElementsByClassName("delete")[0];
                if(x.style.display=='block'){
                    x.style.display='none';
                    y.style.display='none';
                    window.location.href='plant.jsp';
                }
                else{
                    x.style.display='block';
                    y.style.display='block';
                }
            }
        </script>  
       <% }
       else{ %>
            <h2>Данная страница недоступна! Для просмотра данных <a style="color:blue" href="index.jsp">войдите</a>.</h3>
        <% } %>
    </body>
</html>
