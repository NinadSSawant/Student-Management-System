<%@ page import = "java.sql.*"  %>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Home Page </title> 
    <link rel="stylesheet" href="/css/home.css">
   </head>
<body>
  <div class="wrapper">
    <%
      String un = (String)session.getAttribute("username");
      if(un == null)
      {
          response.sendRedirect("index.jsp");
      }      
    %>
    <h2>Welcome <%= un %></h2>
    <form method="post">
      
      <div class="input-box button">
        <input type="Submit" name="btnAdd" value="Add">
      </div>
      <div class="input-box button">
        <input type="Submit" name="btnView" value="View">
      </div>
      <div class="input-box button">
        <input type="Submit" name="btnUpdate" value="Update">
      </div>
      <div class="input-box button">
        <input type="Submit" name="btnDelete" value="Delete">
      </div>
      <br>
      <div class="input-box logbutton">
        <input type="Submit" name="btnLogout" onclick="return confirm('Are you sure you want to logout?');" value="Logout">
      </div>
      <div class="text">
        <h3>User actions for Student Management System</h3>
      </div>
    </form>
    <%
        if(request.getParameter("btnLogout") != null )
        {
          response.sendRedirect("index.jsp");
          session.invalidate();
        }
        else if(request.getParameter("btnAdd") != null )
        {
          session.setAttribute("un", un);
          response.sendRedirect("add.jsp");
        }
        else if(request.getParameter("btnView") != null )
        {
          session.setAttribute("un", un);
          response.sendRedirect("view.jsp");
        }
        else if(request.getParameter("btnUpdate") != null )
        {
          session.setAttribute("un", un);
          response.sendRedirect("update.jsp");
        }
        else if(request.getParameter("btnDelete") != null )
        {
          session.setAttribute("un", un);
          response.sendRedirect("delete.jsp");
        }

    %>
    


  </div>
</body>
</html>
