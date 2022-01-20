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

	UserService uss = new UserService();
	if (session.getAttribute("userId") == null) {
		response.sendRedirect("/LearningJavaWeb/login.jsp");
	} else {
		int id = Integer.parseInt(session.getAttribute("userId").toString());
		if (!uss.findById(id).getRole().toLowerCase().equals("admin")) {
			response.sendRedirect("/LearningJavaWeb/index.jsp");
		}
	}
	%>
	<jsp:include page="fragments/navbar.jsp"></jsp:include>
	<div
		style="display: flex; flex-direction: row; width: 1200px; max-width: 1200px; height: 100%; margin: 42px auto">
		<div class="sidebar"
			style="display: flex; flex-direction: column; justify-content: space-between; min-height: 100%; background-color: black; color: white; padding: 24px">
			<div style="display: flex; flex-direction: column;">
				<div
					style="background-color: #3d3d3d; margin: 16px 0; padding: 8px; border-radius: 8px">
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
			</div>
			<div style="margin: 0 auto">Se déconnecter</div>
		</div>
		<div
			style="background-color: #2e2e2e; color: white; display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 100%; padding: 24px">
			<div
				style="display: flex; flex-direction: column; justify-content: center; align-items: center;background-color: #171717;padding: 16px 96px">
				<h2>Ajouter un utilisateur</h2>
				<form action="UserController" method="post"
					style="display: flex; flex-direction: column; justify-content: space-between;">
					<input type="hidden" name="op" value="add">
					<div style="display: flex; flex-direction: row;">
						<p>Username:</p>
						<input type="text" name="username">
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Email:</p>
						<input type="text" name="email">
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Password:</p>
						<input type="password" name="password">
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Role:</p>
						<select style="width: 177px" name="role">
							<option value="">Select a role</option>
							<option value="admin">Admin</option>
							<option value="client">Client</option>
						</select>
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: center; padding: 8px">
						<input style="padding: 8px;background-color: #212121;color:white;border-radius: 2px;font-weight: bold;" type="submit" value="Ajouter">
					</div>
				</form>
			</div>
			<h2>Liste des Utilisateurs</h2>
			<div style="max-height: 800px; overflow: auto">

				<%
				UserService us = new UserService();
				List<User> users = us.findAll();
				for (User user : users) {
				%>
				<div class="userCard"
					style="display: flex; flex-direction: row; background-color: #616161; margin: 8px 0; padding: 12px">
					<div>Image here</div>
					<div style="display: inline-block;">
						<form action="UserController" method="post"
							style="display: flex; flex-direction: column; justify-content: space-between;">
							<input type="hidden" name="op" value="update"> <input
								type="hidden" name="id" value="<%=user.getId()%>">
							<div style="display: flex; flex-direction: row;">
								<p>Username:</p>
								<input type="text" name="username"
									value="<%=user.getUsername()%>">
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Email:</p>
								<input type="text" name="email" value="<%=user.getEmail()%>">
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Password:</p>
								<input type="password" name="password"
									value="<%=user.getPassword()%>">
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Role:</p>
								<select style="width: 177px" name="role">
									<option value="<%=user.getRole()%>"><%=user.getRole()%></option>
									<option value="admin">Admin</option>
									<option value="client">Client</option>
								</select>
							</div>
							<div style="display: flex; flex-direction: row; margin-top: 6px">

								<input type="submit" value="Modifier">
								<%
								if (us.hasBooking(user)) {
								%>
								<div style="background-color:; padding: 6px">Has a
									reservation</div>
								<%
								} else {
								%>
								<div style="background-color: red; padding: 6px">
									<a style="text-decoration: none; color: white"
										href="UserController?id=<%=user.getId()%>&op=delete">Supprimer</a>
								</div>
								<%
								}
								%>
							</div>
						</form>
					</div>
					<div style="display: flex; flex-direction: row"></div>

				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>