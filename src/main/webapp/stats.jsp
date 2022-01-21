<%@page import="services.UserService"%>
<%@page import="services.BookingService"%>
<%@page import="entities.Booking"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Stats</title>
<link href="styles/styles.css" rel="stylesheet" type="text/css" />
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
						style="text-decoration: none; color: white;"> Stats</a>
				</div>
			</div>

			<div style="margin: 0 auto">Se déconnecter</div>
		</div>

		<div
			style="background-color: #2e2e2e; color: white; display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 100%; padding: 24px">
			<div>Statistiques Nombre de réservations par mois</div>
			<div style="display: flex;flex-direction: row" >
				<div
					style="display: flex; flex-direction: column-reverse; height: 400px; justify-content: flex-start; margin-right: 4px">
					<%
					for (int i = 1; i < 7; i++) {
					%>
					<div style="height: 40px">
						<%=i%></div>
					<%
					}
					%>
				</div>
				<div style="display: flex;flex-direction: column;">
				<div
					style="display: flex; flex-direction: row; justify-content: space-around; border-bottom: 1px solid white; border-left: 1px solid white; width: 400px; height: 400px; align-items: flex-end;">
					<%
					BookingService bs = new BookingService();
					int[] stats = bs.stats();

					for (int i = 0; i < 12; i++) {
					%>
					<div
						style="background-color: white;height:<%=40 * stats[i] + "px"%>;width: 10px;bottom:0;left:0"></div>

					<%
					}
					%>
				</div>
				<div style="width: 400px;display: flex;flex-direction: row;margin-top: 30px" >
					<div style="transform:rotate(-90deg);margin-right: -16px;margin-left: -4px" >Janvier</div>
					<div style="transform:rotate(-90deg);margin-right: -4px;" >Fevrier</div>
					<div style="transform:rotate(-90deg)" >Mars</div>
					<div style="transform:rotate(-90deg)" >Avril</div>
					<div style="transform:rotate(-90deg);margin-right: 8px;" >Mai</div>
					<div style="transform:rotate(-90deg)" >Juin</div>
					<div style="transform:rotate(-90deg)" >Juillet</div>
					<div style="transform:rotate(-90deg);margin-right: -15px;" >Aout</div>
					<div style="transform:rotate(-90deg);margin-right: -28px;" >Septembre</div>
					<div style="transform:rotate(-90deg);margin-right: -28px;" >Octobre</div>
					<div style="transform:rotate(-90deg);margin-right: -32px;" >Novembre</div>
					<div style="transform:rotate(-90deg)" >Decembre</div>
				</div>
				</div>
				
			</div>



		</div>
	</div>
</body>
</html>