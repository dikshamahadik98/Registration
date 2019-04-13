<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Login</title>

</head>

<body>

<%! String userdbName;

	String userdbPsw;

%>

<%
String email = request.getParameter("email");

String password = request.getParameter("password");

if((!(email.equals(null) || email.equals("")) && !(password.equals(null) || 
password.equals("")))
{

try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/record","root","");
	PreparedStatement ps = con.prepareStatement("select * from dummy_licences where email=? and password=?";);
	ResultSet rs =  ps.executeQuery();
	ps.setString(1, email);
	ps.setString(2, password);
		if(rs.next())
		{ 
			userdbName = rs.getString("email");
			userdbPsw = rs.getString("password");
			if(email.equals(userdbName) && password.equals(userdbPsw))
			{
				session.setAttribute("email",userdbName);
				response.sendRedirect("welcome.jsp"); 
			} 
		}
		else
				response.sendRedirect("error.jsp");
				rs.close();
				ps.close(); 
	}
catch(SQLException sqe)
{
	out.println(sqe);

} 

}

else

{

%>

<center><p style="color:red">Error In Login</p></center>

<% 

getServletContext().getRequestDispatcher("/login.jsp").include(request,response);

}

%>

</body>

</html>