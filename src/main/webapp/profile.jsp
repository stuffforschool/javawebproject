<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<link href="styles/styles.css" rel="stylesheet" type="text/css" />



</head>
<body style="margin: 0px">

	<%
	//String userId = session.getAttribute("userId").toString();
	if (session.getAttribute("userId") == null) {
		response.sendRedirect("/LearningJavaWeb/");
	}
	UserService us = new UserService();
	int id = Integer.parseInt(session.getAttribute("userId").toString());
	User user = us.findById(id);
	%>
	<jsp:include page="fragments/navbar.jsp"></jsp:include>
	<div
		style="display: flex; flex-direction: row; width: 1200px; max-width: 1200px; height: 100%; margin: 42px auto">
		<div
			style="display: flex; flex-direction: column; justify-content: space-between; min-height: 100%; background-color: black; color: white; padding: 24px">
			<div style="display: flex; flex-direction: column;">
				<div
					style="background-color: #3d3d3d; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/profile.jsp"
						style="text-decoration: none; color: white;">Mes Informations</a>
				</div>
				<div
					style="background-color: #616161; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/profile/historique.jsp"
						style="text-decoration: none; color: white;">Mes réservations</a>
				</div>

			</div>
			<form action="LogoutController" method="post">
				<input
					style="width: auto; margin: 4px auto; font-size: medium; font-weight: 200; color: white; background-color: transparent;"
					type="submit" value="Log out">
			</form>
		</div>
		<div
			style="background-color: #292929; width: 100%; height: 600px; display: flex; flex-direction: column; padding: 0 24px">
			<div
				style="color: white; font-size: x-large; margin-top: 48px; margin-left: 86px; margin-bottom: 48px">Mes
				informations</div>

			<div
				style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 24px; align-items: center;">
				<p style="font-weight: bold; width: 100px; margin-right: 36px;">Profile
					Picture:</p>
				<img style="width: 150px; height: 150px; border-radius: 50%;"
					alt="No image found for this user"
					src="images/rooms/user-28.jpg"
					>
					
				<form id="uploadForm" action="UploadController" method="post"
					enctype="multipart/form-data">
					<div
						style="display: flex; flex-direction: row; justify-content: space-between; align-items: center;">
					
						<label for="uploadBtn"
							style="border: 1px solid #ccc; display: inline-block; padding: 6px 12px; cursor: pointer; width: 150px; text-align: center;">Upload</label>
						<input id="uploadBtn" style="display: none;" type="file"
							name="file" form="uploadForm" >
						<input type="hidden" name="op" value="upload" >
						<input type="hidden" name="id" value="<%=user.getId() %>" >
						
						<input style="padding: 8px;background-color: #212121;color:white;border-radius: 2px;font-weight: bold;" type="submit" value="Submit">
					</div>
				</form>
			</div>
			<div
				style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 24px;">
				<p style="font-weight: bold; width: 100px; margin-right: 36px;">Username:</p>
				<p><%=user.getUsername()%></p>
			</div>
			<div
				style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 24px;">
				<p style="font-weight: bold; width: 100px; margin-right: 36px;">Email:</p>
				<p><%=user.getEmail()%></p>
			</div>
			<div
				style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 24px;">
				<p style="font-weight: bold; width: 100px; margin-right: 36px;">Password:</p>
				<p>*********</p>
			</div>
		</div>
	</div>






</body>

</html>