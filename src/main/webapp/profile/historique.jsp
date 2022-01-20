<%@page import="services.BookingService"%>
<%@page import="entities.Booking"%>
<%@page import="java.util.List"%>
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
	BookingService bs = new BookingService();
	List<Booking> myBookings = bs.findAllByclientId(id);
	%>
	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<div
		style="display: flex; flex-direction: row; width: 1200px; max-width: 1200px; height: 100%; margin: 42px auto">
		<div
			style="display: flex; flex-direction: column; justify-content: space-between; min-height: 100%; background-color: black; color: white; padding: 24px">
			<div style="display: flex; flex-direction: column;">
				<div
					style="background-color: #616161; margin: 16px 0; padding: 8px; border-radius: 8px">
					<a href="/LearningJavaWeb/profile.jsp"
						style="text-decoration: none; color: white;">Mes Informations</a>
				</div>
				<div
					style="background-color: #3d3d3d; margin: 16px 0; padding: 8px; border-radius: 8px">
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
			style="background-color: #292929; width: 100%; height: 100%;min-height:600px; display: flex; flex-direction: column; padding: 0 24px">
			<div
				style="color: white; font-size: x-large; margin-top: 48px; margin-left: 86px; margin-bottom: 48px">Mes
				réservations</div>
		<%
		if (myBookings.isEmpty()) {
		%>
		<div
			style="background-color: #292929; width: 100%; height: 600px; display: flex; flex-direction: column; color: white; font-size: x-large; padding-top: 48px; padding: 86px; padding: 48px">
			Vous n'avez pas encore effectué une réservation.</div>


		<%
		} else {
		for (Booking booking : myBookings) {
		%>
		
			<div
				style="background-color: #292929; display: flex; flex-direction: column;margin: 12px 0px">
				<div
					style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 1px;">
					<p style="font-weight: bold; width: 100px; margin-right: 36px;">Booking
						Id:</p>
					<p><%=booking.getId()%></p>
				</div>
				<div
					style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 1px;">
					<p style="font-weight: bold; width: 100px; margin-right: 36px;">
						Room:</p>
					<p><%=booking.getRoom().getNum()%></p>
				</div>
				<div
					style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 1px;">
					<p style="font-weight: bold; width: 100px; margin-right: 36px;">
						De:</p>
					<p><%=booking.getStartDate()%></p>
				</div>
				<div
					style="display: flex; flex-direction: row; color: white; padding: 0 72px; background-color: #1c1c1c; margin-top: 1px;">
					<p style="font-weight: bold; width: 100px; margin-right: 36px;">
						De:</p>
					<p><%=booking.getEndDate()%></p>
				</div>
			</div>

	
		<%
		}
		}
		%>
			</div>
	</div>






</body>

</html>