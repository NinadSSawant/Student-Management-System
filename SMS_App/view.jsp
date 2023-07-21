<%@ page import = "java.sql.*"  %>
<html>
  <head>
    <title>View Page</title>
    <link rel="stylesheet" href="/css/view.css">
  </head>
  <body>
    <%
      String un = (String)session.getAttribute("un");
      String numStr = (String)session.getAttribute("strRoll");
      if(un == null)
      {
          response.sendRedirect("index.jsp");
      }      
    %>
    
    <div class="title-container">
      <div class="title">
        <h3>Student Management System</h3>
      </div>
    </div>
    <div class="nav button">
        <input type="button" id="btnHome" value="Home" onclick="window.location='home.jsp'" >
    </div>
    

    <center>
      <div class="container">
            <h4 id="viewTitle">Complete Student Records</h4>

            <form method="post">
                <h3 id="note">**Note: enter 0 to view all records.**</h3>
                <div class="input-box">
                    <input type="number" name="rollno" placeholder="Enter Roll Number" required min="0" autocomplete="off">
                </div>
                <br>
                <div class="input-box button">
                    <input type="Submit" name="btnSearch" value="Search">
                    <input type="button" name="btnUpdate" value="Update" onclick="window.location='update.jsp'">
                    <input type="reset" id="btnClear" name="btnClear" value="Clear">
                </div>
            </form>

            <div class="table">
              <table border="3">
                  <tr>
                    <th class="rollno-heading">Roll No.</th>
                    <th class="name-heading">Name</th>
                    <th class="marks-heading">Marks</th>
                  </tr>
                  <% 

                        if (numStr == null || numStr.matches("0"))
                        {
                            try {
                                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                                String url = "jdbc:mysql://localhost:3306/db_name;
                                Connection con = DriverManager.getConnection(url, mysql_username, mysq_pass);
                    
                                String sql = "select * from student";
                                PreparedStatement pst =  con.prepareStatement(sql);
                                ResultSet rs =  pst.executeQuery();

                                while(rs.next())
                                {
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
                                %>
                                    <script>
                                        let edAlert = "Issue: " + "<%= e %>";
                                        alert(eAlert);
                                    </script>
                                <%
                            }
                        }
                        else {
                            int rollNum = Integer.parseInt(numStr);

                            try {
                                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                                String url = "jdbc:mysql://localhost:3306/db_name";
                                Connection con = DriverManager.getConnection(url, mysql_username, mysq_pass);
                    
                                String sql = "select * from student where roll_no=?";
                                PreparedStatement pst =  con.prepareStatement(sql);
                                pst.setInt(1, rollNum);

                                ResultSet rs =  pst.executeQuery();

                                while(rs.next())
                                {
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
                                %>
                                    <script>
                                        let elseAlert = "Issue: " + "<%= e %>";
                                        alert(elseAlert);
                                    </script>
                                <%
                            }
                        }


                        if(request.getParameter("btnSearch") != null)
                        {
                            String strRoll = String.valueOf(request.getParameter("rollno"));
                            session.setAttribute("strRoll", strRoll);
                            response.sendRedirect("view.jsp");
                        }
                    %>
                </table>
        </form>
    </center>
</div>


  </body>
</html>
