<%-- 
    Document   : designation
    Created on : 04.12.2016, 23:42:35
    Author     : Masha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Park.Designation"%>
<%@page import="java.util.ArrayList"%>

<%!ArrayList<Designation> f;
Designation g;%>
<%g=new Designation();
request.setCharacterEncoding("UTF-8");
f = new ArrayList<Designation>();
f=g.Select();%>

<% if(request.getParameter("del")!=null){
    g.Delete(Integer.parseInt(request.getParameter("del")));
    response.sendRedirect("designation.jsp");
}
%>

<%String com="";
int max=g.max()+1;
String result="";
if(request.getParameter("add")!=null){
    g=new Designation(Integer.parseInt(request.getParameter("id")),request.getParameter("designation").trim());
    if(request.getParameter("designation").compareTo("")==0){
        com="Введите указание!";
    }
    else{
        g.Add();
        response.sendRedirect("designation.jsp");
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Список указаний</title>
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
                <li><a href="plant.jsp">растения</a></li>
                <li><a href="forester.jsp">лесники</a></li>
                <li><a href="owner.jsp">владельцы</a></li>
                <li class="now"><a href="#">указания</a></li>
            </ul>
        </nav>
        
        <div class="delete">   
        </div>
        <section class="delet">
            <img src="image/delete.jpg" onclick="display();"/>
            <h4>Вы действительно хотите удалить данные об указании? Будут удалены все задания, связанные с данным указанием.</h4>
            <button onclick="window.location.href='designation.jsp?del='+$_GET('designation')">Да</button>
            <button onclick="display();">Отмена</button>
        </section>

        <h2>Указания</h2>
        <div class="container">
            <article id="alldesignation">
                <table class="table">
                        <tr>
                            <td class="visible">ID</td>
                            <td>УКАЗАНИЕ</td>
                            <% if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){ %>
                            <td></td>
                            <td></td>
                            <% } %>
                        </tr>
                            <% for(int i=0;i<f.size();++i){ %>
                        <tr>
                            <td class="visible"><%=f.get(i).getDesignationID()%></td>
                            <td><%=f.get(i).getDesignation()%></td>
                            <% if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){ %>
                            <td style="width:30px;">
                                <a href="onedesignation.jsp?designation=<%=f.get(i).getDesignationID()%>"><img class="edit" src="image/edit.png" title="редактировать"></a>
                            </td>
                            <td style="width:30px;">
                                <a href="designation.jsp?designation=<%=f.get(i).getDesignationID()%>"><img class="edit" src="image/delete.jpg" title="удалить"/></a>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                </table>

            </article>
            <%if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){%>
            <section id="adddesignation">
                <form name="designation" method="POST">
                    <h3>Добавить указание</h3>
                    <input type="hidden" name="id" value="<%=max%>">
                    <p>Указание<span class="star">*</span>  <span class="comment"><%=com%></span></p>
                    <input type="text" name="designation" value="<%=g.getDesignation()%>" >
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
            if($_GET('designation')){
                display();
            }
            function display(){
                var x=document.getElementsByClassName("delet")[0];
                var y=document.getElementsByClassName("delete")[0];
                if(x.style.display=='block'){
                    x.style.display='none';
                    y.style.display='none';
                    window.location.href='designation.jsp';
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