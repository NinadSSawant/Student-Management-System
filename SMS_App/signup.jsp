<%@ page import = "java.sql.*"  %>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Sign Up Page </title> 
    <link rel="stylesheet" href="/css/signup.css">
   </head>
<body>
  <div class="wrapper">
    <h2>Registration</h2>
    <form method="post">
      <div class="input-box">
        <input type="text" name="username" placeholder="Create username" required autocomplete="off">
      </div>
      <div class="input-box">
        <input type="password" name="password" placeholder="Create password" required autocomplete="off">
      </div>
      <div class="input-box">
        <input type="password" name="conpassword" placeholder="Confirm password" required autocomplete="off">
      </div>
      
      <div class="input-box button">
        <input type="Submit" name="btnSignup" value="Sign Up">
      </div>
      <div class="text">
        <h3>Already have an account? <a href="index.jsp">Login now</a></h3>
      </div>
    </form>

    <%
        if (request.getParameter("btnSignup") != null)
        {
            String username = request.getParameter("username");
            username = username.trim();
            String password = request.getParameter("password");
            password = password.trim();
            String conpassword = request.getParameter("conpassword");
            conpassword = conpassword.trim();

            if(password.matches(conpassword))
            {
                try {
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/db_name";
                    Connection con = DriverManager.getConnection(url, mysql_username, mysq_pass);
        
                    String sql = "insert into user values(?, ?)";
                    PreparedStatement pst = con.prepareStatement(sql);

                    pst.setString(1, username);
                    pst.setString(2, password);
                    pst.executeUpdate();
                    con.close();
                    %>
                        <script>
                            let suc = "Registration Successful";
                            alert(suc);
                        </script>
                    <%
                } catch (SQLException e) {
                    %>
                                <script>
                                    let eAlert = "Issue: " + "<%= e %>";
                                    alert(eAlert);
                                </script>
                    <%
                } 
            } else {
                %>
                                <script>
                                    let passAlert = "Passwords don't match";
                                    alert(passAlert);
                                </script>
                <%
            }

        }
    %>

  </div>
</body>
</html>
