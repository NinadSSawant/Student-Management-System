<%@ page import = "java.sql.*"  %>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Update Page </title> 
    <link rel="stylesheet" href="/css/update.css">
   </head>
<body>
  <div class="wrapper">
        <%
        String un = (String)session.getAttribute("un");
        if(un == null)
        {
            response.sendRedirect("index.jsp");
        }      
        %>
        <h2>Update Student Records</h2>
        <form method="post">
            <div class="input-box">
            <input type="number"  name="rollno" placeholder="Enter Roll Number" required min="1" autocomplete="off">
            </div>
            <div class="input-box">
                <input type="text" name="name" placeholder="Student name" required autocomplete="off">
            </div>
            <div class="input-box">
                <input type="number" name="marks" placeholder="Enter Marks" required max="100" min="0" autocomplete="off">
            </div>
            
            <div class="input-box button">
                <input type="Submit" name="btnUpdate" value="Update">
            </div>
            <div class="text">
                <h3>Back <a href="home.jsp">Home</a></h3>
                <h3>Search Student ? <a href="view.jsp">Click Here</a></h3>
            </div>
        </form>

        <%
            if (request.getParameter("btnUpdate") != null)
            {
                int rollno = Integer.parseInt(request.getParameter("rollno"));
                String name = request.getParameter("name");
                name = name.trim();
                Double marks = Double.parseDouble(request.getParameter("marks"));

                if(name.matches("[A-Za-z ]+"))
                {
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
                            String sql = "UPDATE student SET name=?, marks=? WHERE roll_no=?";
                            PreparedStatement pst = con.prepareStatement(sql);
                            
                            pst.setString(1, name);
                            pst.setDouble(2, marks);
                            pst.setInt(3, rollno);
                            pst.executeUpdate();
                            con.close();
                            %>
                                <script>
                                    let suc = "Record updated Successfully";
                                    alert(suc);
                                </script>
                            <%
                        } else {
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
                                let eAlert = "Roll number " + "<%= rollno %>" + " already exists";
                                alert(eAlert);
                            </script>
                        <%
                        }
                } else {
                    %>
                        <script>
                            let passAlert = "Please enter a valid name";
                            alert(passAlert);
                        </script>
                    <%
                }
            }
        %>

    </div>
</body>
</html>
