<%@page import="entities.User"%>
<%@page import="java.util.List"%>
<%@page import="services.UserService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="styles/styles.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body>
	<%
	//String userId = session.getAttribute("userId").toString();
	UserService us = new UserService();
	if (session.getAttribute("userId") == null) {
		response.sendRedirect("/LearningJavaWeb/login.jsp");
	} else {
		int id = Integer.parseInt(session.getAttribute("userId").toString());
		if (!us.findById(id).getRole().toLowerCase().equals("admin")) {
			response.sendRedirect("/LearningJavaWeb/index.jsp");
		}
	}
	%>
	<jsp:include page="fragments/navbar.jsp"></jsp:include>
	<div
		style="display: flex; flex-direction: row; width: 1200px; max-width: 1200px; height: 600px; margin: 42px auto">
		<div class="sidebar"
			style="display: flex; flex-direction: column; justify-content: space-between; min-height: 100%; background-color: black; color: white; padding: 24px">
			<div style="display: flex; flex-direction: column;">
				<div
					style="background-color: #616161; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/GestionUsers.jsp"
						style="text-decoration: none; color: white;">Gestion
						d'utilisateurs</a>
				</div>
				<div
					style="background-color: #616161; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/GestionRooms.jsp"
						style="text-decoration: none; color: white;">Gestion de
						chambres</a>
				</div>
				<div
					style="background-color: #616161; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/GestionBookings.jsp"
						style="text-decoration: none; color: white;">Gestion de
						bookings</a>
				</div>
				<div
					style="background-color: #616161; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/stats.jsp"
						style="text-decoration: none; color: white;">
						Stats</a>
				</div>
			</div>
			<div style="margin: 0 auto">Se déconnecter</div>
		</div>
		<div
			style="background-color: #2e2e2e; color:white ;display: flex; justify-content: center; align-items: center; width: 100%; height: 100%; padding: 24px">
			Admin Page</div>
	</div>
</body>
</html>