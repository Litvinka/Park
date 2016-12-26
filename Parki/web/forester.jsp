<%-- 
    Document   : forester
    Created on : 15.11.2016, 11:03:17
    Author     : Masha
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Park.Forester"%>
<%@page import="java.util.ArrayList"%>

<%!ArrayList<Forester> f;
    Forester g;%>
    <%g=new Forester();
    request.setCharacterEncoding("UTF-8");
        f = new ArrayList<Forester>();
        f=g.Select();%>
<% if(request.getParameter("del")!=null){
    g.Delete(Integer.parseInt(request.getParameter("del")));
    response.sendRedirect("forester.jsp");
}
%>

<%String[] com={"","","","",""};
int max=g.max()+1;
boolean error=false;
String result="";
if(request.getParameter("add")!=null){
    g=new Forester(Integer.parseInt(request.getParameter("id")),request.getParameter("name").trim(),request.getParameter("surname").trim(),request.getParameter("putronumic").trim(),request.getParameter("phone").trim(),request.getParameter("email").trim());
    com=g.inspectionForm();
    for(int i=0;i<5;++i){
        if(com[i].compareTo("")!=0){
            error=true;
            break;
        }
    }
    if(!error){
        g.Add();
        response.sendRedirect("forester.jsp");
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Список лесников</title>
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
                <li class="now"><a href="#">лесники</a></li>
                <li><a href="owner.jsp">владельцы</a></li>
                <li><a href="designation.jsp">указания</a></li>
            </ul>
        </nav>
        
        <div class="delete">   
        </div>
        <section class="delet">
            <img src="image/delete.jpg" onclick="display();"/>
            <h4>Вы действительно хотите удалить данные о леснике и все связанные с ним задания?</h4>
            <button onclick="window.location.href='forester.jsp?del='+$_GET('forester')">Да</button>
            <button onclick="display();">Отмена</button>
        </section>
        
        <h2>Лесники</h2>
        <div class="container">
            <article id="allforester">
                <table class="table">
                        <tr class="visible">
                            <td>ID</td>
                            <td>ИМЯ</td>
                            <td>ОТЧЕСТВО</td>
                            <td>ФАМИЛИЯ</td>
                            <td>ТЕЛЕФОН</td>
                            <td>EMAIL</td>
                            <% if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){ %>
                            <td></td>
                            <td></td>
                            <% } %>
                        </tr>
                        <% for(int i=0;i<f.size();++i){ %>
                        <tr>
                            <td class="visible"><%=f.get(i).getForesterID()%></td>
                            <td class="visible"><%=f.get(i).getName()%></td>
                            <td class="visible"><%=f.get(i).getPutronumic()%></td>
                            <td><%=f.get(i).getSurname()%></td>
                            <td><%=f.get(i).getPhone()%></td>
                            <td class="visible"><%=f.get(i).getEmail()%></td>
                            <% if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){ %>
                            <td>
                                <a href="oneforester.jsp?forester=<%=f.get(i).getForesterID()%>"><img class="edit" src="image/edit.png" title="редактировать"></a>
                            </td>
                            <td>
                                <a href="forester.jsp?forester=<%=f.get(i).getForesterID()%>"><img class="edit" src="image/delete.jpg" title="удалить"/></a>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                </table>

            </article>
            <%if(session.getAttribute("ROLE").toString().compareTo("владелец")==0){%>
            <section id="addforester">
                <form name="forester" method="POST">
                    <h3>Добавить лесника</h3>
                    <input type="hidden" name="id" value="<%=max%>">
                    <p>Имя<span class="star">*</span>  <span class="comment"><%=com[0]%></span></p>
                    <input type="text" name="name" value="<%=g.getName() %>" >
                    <p>Фамилия<span class="star">*</span>  <span class="comment"><%=com[1]%></span></p>
                    <input type="text" name="surname" value="<%=g.getSurname() %>">
                    <p>Отчество<span class="star">*</span>  <span class="comment"><%=com[2]%></span></p>
                    <input type="text" name="putronumic" value="<%=g.getPutronumic() %>">
                    <p>Телефон<span class="star">*</span>  <span class="comment"><%=com[3]%></span></p>
                    <input type="text" name="phone" value="<%=g.getPhone() %>">
                    <p>Email<span class="star">*</span>  <span class="comment"><%=com[4]%></span></p>
                    <input type="email" name="email" value="<%=g.getEmail() %>">
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
            
            if($_GET('forester')){
                display();
            }
            
            function display(){
                var x=document.getElementsByClassName("delet")[0];
                var y=document.getElementsByClassName("delete")[0];
                if(x.style.display=='block'){
                    x.style.display='none';
                    y.style.display='none';
                    window.location.href='forester.jsp';
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
