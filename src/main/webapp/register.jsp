<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="styles/styles.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: url('images/bgimg.jpg');">
	<div class="container">
		<%
		//String userId = session.getAttribute("userId").toString();
		if (session.getAttribute("userId") != null) {
			response.sendRedirect("/LearningJavaWeb/");
		}
		%>
		<jsp:include page="fragments/navbar.jsp"></jsp:include>
		<div
			style="max-width: 1200px; margin-left: auto; margin-right: auto; height: 95vh; display: flex; justify-content: center; align-items: center;">
			<form action="RegisterController" method="post">

				<div
					style="width: 300px; height: 350px; display: flex; flex-direction: column; background-color: rgba(33, 33, 33, 1);box-shadow: 3px 3px 3px black">
					<div style="color: #d6d6d6;font-weight:bold;text-align: center; padding: 12px;border:1px; ;border-color: #575757 ;font-size: large;">
					User Register
					
					</div>
					<div style="height: 100%;background-color: #333333;display: flex;justify-content: center;align-items: center;flex-direction: column" >
					<div
						style="display: flex; flex-direction: column;  width: 70%; margin: 10px 0">

						<input
							style="padding: 8px; border-radius: 6px; background-color: rgba(33, 33, 33, 1); color: #d6d6d6"
							type="text" name="username" placeholder="Username" value="<%= request.getParameter("username") == null ? "" : request.getParameter("username")%>">
							<%if(request.getParameter("field")!=null && request.getParameter("field").equals("usernameA")){ %>
							<p style="color:red;position: absolute;margin-top: 36px " > Username should be between 4 and 16 characters </p>
							<%}else if(request.getParameter("field")!=null && request.getParameter("field").equals("usernameB")){ %>
							<p style="color:red;position: absolute;margin-top: 36px " > Username should not contain symbols </p>
							<%}else if(request.getParameter("field")!=null && request.getParameter("field").equals("usernameC")){ %>
							<p style="color:red;position: absolute;margin-top: 36px " > Username already taken </p>
							<%} %>
					</div>
					<div
						style="display: flex; flex-direction: column; justify-content: space-between; width: 70%; margin: 10px 0">

						<input
							style="padding: 8px; border-radius: 6px; background-color: rgba(33, 33, 33, 1); color: #d6d6d6"
							type="text" name="email" placeholder="Email" value="<%= request.getParameter("email") == null ? "" : request.getParameter("email")%>" >
						
							<%if(request.getParameter("field")!=null && request.getParameter("field").equals("emailA")){ %>
							<p style="color:red;position: absolute;margin-top: 36px " > Invalid email  </p>
							<%}else if(request.getParameter("field")!=null && request.getParameter("field").equals("emailB")){ %>
							<p style="color:red;position: absolute;margin-top: 36px " > Email already taken </p>
							<%}%>
					</div>
					<div
						style="display: flex; flex-direction: column; justify-content: space-between; width: 70%; margin-top: 10px;margin-bottom: 15px">

						<input style="padding: 8px; border-radius: 6px; background-color: rgba(33, 33, 33, 1); color: #d6d6d6" type="password"
							name="password" placeholder="Password">
							<%if(request.getParameter("field")!=null && request.getParameter("field").equals("passwordA")){ %>
							<p style="color:red;position: absolute;margin-top: 36px " > invalid Password </p>
								<%} %>
					</div>
					
					<div style="display: flex;width: 100%;justify-content: flex-end;margin-right: 86px" >
						<a style="text-decoration: none;color:#757575" href="login.jsp" >Already have an account?</a>
					</div>

					<input style="width: 70%; margin: 4px auto;padding: 8px 0;background-color: #383838;color:#d6d6d6;cursor: pointer;margin-top: 12px " type="submit"
						value="Sign up">
					</div>
					
				</div>
			</form>



		</div>
	</div>
</body>
</html>