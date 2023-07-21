<%@ page import = "java.sql.*"  %>

<html>
    <head>
        <title>S.M.S by Vishnu | Sign In Page</title>
        <link rel="stylesheet" href="/css/login.css">
    </head>
    <body>
        <div class="vertLine"></div>
        <div class="sms">
            <h1>Student</h1>
            <h3>Management</h3>
            <h4>System</h4>
        </div>

        <div class="wrapper">

            <h2>Sign In</h2>

            <form method="post">
                <div class="input-box">
                    <input type="text" name="username" placeholder="Enter username" required autocomplete="off">
                </div>
    
                <div class="input-box">
                    <input type="password" name="password" placeholder="Enter password" required autocomplete="off">
                </div>
    
                <div class="input-box button">
                    <input type="Submit" name="btnSignin" value="Sign In">
                </div>
    
                <div class="text">
                    <h3>Don't have an account? <a href="signup.jsp">Sign Up now</a></h3>
                </div>
            </form>

            <%
                if (request.getParameter("btnSignin") != null)
                {
                    String username = request.getParameter("username");
                    username = username.trim();
                    String password = request.getParameter("password");
                    password = password.trim();

                    try {

                        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                        String url = "jdbc:mysql://localhost:3306/db_name";
                        Connection con = DriverManager.getConnection(url, mysql_username, mysql_pass);

                        String check = "select * from user where username=? and pass=?";
                        PreparedStatement p = con.prepareStatement(check);
                        p.setString(1, username);
                        p.setString(2, password);
                        ResultSet rs = p.executeQuery();
                        
                        if(rs.next())
                        {
                            session.setAttribute("username", username);
                            response.sendRedirect("home.jsp");
                        }
                        else {
                            %>
                            <script>
                                let errAlert = "Incorrect username or password";
                                alert(errAlert);
                            </script>
                            <%
                        }
                    } catch (SQLException e) {
                        %>
                                    <script>
                                        let eAlert = "Issue: " + "<%= e %>";
                                        alert(eAlert);
                                    </script>
                        <%
                    } 

                }
            %>



        </div>
    </body>
</html>
