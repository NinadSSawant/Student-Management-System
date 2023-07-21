<%@ page import = "java.sql.*"  %>
<html>
  <head>
    <title>View Page</title>
    <link rel="stylesheet" href="/css/delete.css">
  </head>
  <body>
    
    <div class="title-container">
      <div class="title">
        <h3>Student Management System</h3>
      </div>
    </div>
    <input type="button" id="btnHome" value="Home" onclick="window.location='home.jsp'" >

    <center>
      <div class="container">
        <div class="deltile">
          <h4>Delete Student Records</h4>
        </div>
        <form method="post">
          <div class="delInput">
            
            <input type="number" name="rollno" placeholder="Enter Roll Number" required min="1" autocomplete="off">
            <input style=" cursor: pointer;" type="submit" name="btnDel" onclick="return confirm('Are you sure you want to delete this feedback ?');" value="Delete Feedback"/>
          </div>
        </form>
        
        <% 
          String un = (String)session.getAttribute("un");
          if(un == null)
          {
              response.sendRedirect("index.jsp");
              session.invalidate();
          }
        %>

    </center>
     <center>
        <br> <br>
      <div class="table">
        <table border="3">
            <tr>
              <th class="rollno-heading">Roll No.</th>
              <th class="name-heading">Name</th>
              <th class="marks-heading">Marks</th>
            </tr>
            <% 
                try {
                        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                        String url = "jdbc:mysql://localhost:3306/db_name";
                        Connection con = DriverManager.getConnection(url, mysql_username, mysq_pass);
            
                        String sql = "select * from student";
                        PreparedStatement pst =  con.prepareStatement(sql);
                        ResultSet rs =  pst.executeQuery();
                        while(rs.next()){
            %>
                            
                            <tr>
                                <td><%= rs.getString(1) %></td>
                                <td><%= rs.getString(2) %></td>
                                <td><%= rs.getString(3) %></td>
                            </tr>
            
            <%
                        
                        }
                        con.close();
                    } catch (SQLException e) {
                            out.println("issue "+ e);
                    }

                    if (request.getParameter("btnLogout") != null)
                    {
                      response.sendRedirect("admin.jsp");
                      session.invalidate();
                    }

                    if (request.getParameter("btnDel") != null)
                    {
                      int rollno = Integer.parseInt(request.getParameter("rollno"));

                      try {
                            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        
                            String url = "jdbc:mysql://localhost:3306/db_name";
                            Connection con = DriverManager.getConnection(url, mysql_username, mysq_pass);
                        
                            String check = "select * from student where roll_no=?";
                            PreparedStatement p = con.prepareStatement(check);
                            p.setInt(1, rollno);
                            ResultSet rs = p.executeQuery();
                            
                            if(rs.next())
                            {
                                String sql = "delete from student where roll_no=?";
                                PreparedStatement pst = con.prepareStatement(sql);

                                pst.setInt(1, rollno);
                                pst.executeUpdate();
                                con.close();
                                %>
                                <script>
                                    let delAlert = "Roll No." + "<%= rollno %>" + " record successfully Deleted";
                                    alert(delAlert);
                                </script>
                                <%
                                response.sendRedirect("delete.jsp");
                            }
                            else 
                            {
                                %>
                                <script>
                                    let errAlert = "No record found for Roll no." + "<%= rollno %>";
                                    alert(errAlert);
                                </script>
                                <%
                            }
                        } catch (SQLException e) {
                            %>
                                        <script>
                                            let edAlert = "Issue: " + "<%= e %>";
                                            alert(eAlert);
                                        </script>
                            <%
                        } 
                    }
            %>
            </table>
      </div>
     </center>



  </body>
</html>
