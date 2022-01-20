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
			<form action="LoginController" method="post">

				<div
					style="width: 300px; height: 300px; display: flex; flex-direction: column; background-color: rgba(33, 33, 33, 1); box-shadow: 3px 3px 3px black">
					<div
						style="color: #d6d6d6; font-weight: bold; text-align: center; padding: 12px; border: 1px;; border-color: #575757; font-size: large;">
						User Login</div>
					<div
						style="height: 100%; background-color: #333333; display: flex; justify-content: center; align-items: center; flex-direction: column">
						<div
							style="display: flex; flex-direction: column; justify-content: space-between; width: 70%; margin: 10px 0">

							<input
								style="padding: 8px; border-radius: 6px; background-color: rgba(33, 33, 33, 1); color: #d6d6d6"
								type="text" name="login" placeholder="Username"; >
						</div>
						<div
							style="display: flex; flex-direction: column; justify-content: space-between; width: 70%; margin-top: 10px;">

							<input
								style="padding: 8px; border-radius: 6px; background-color: rgba(33, 33, 33, 1); color: #d6d6d6"
								type="password" name="password" placeholder="Password">
						</div>
						<%
						if (request.getParameter("error") != null) {
						%>
						<div style="display: flex; width: 70%;">

							<p style="color: red">Invalid credentials.</p>
						</div>
						<%
						}
						%>


						<div
							style="display: flex; width: 100%; justify-content: flex-end; margin-right: 86px">

							<a style="text-decoration: none; color: #757575" href="#">Forgot
								password?</a>
						</div>


						<input
							style="width: 70%; margin: 4px auto; padding: 8px 0; background-color: #383838; color: #d6d6d6; cursor: pointer; margin-top: 12px"
							type="submit" value="Sign in">

						<div style="display: flex; width: 100%; justify-content: center;">

							<a style="text-decoration: none; color: #757575"
								href="register.jsp">I don't have an account.</a>
						</div>
					</div>

				</div>
			</form>



		</div>
	</div>
</body>
</html>