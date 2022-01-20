<%@page import="entities.Booking"%>
<%@page import="services.BookingService"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Room"%>
<%@page import="services.RoomService"%>
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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
	//String userId = session.getAttribute("userId").toString();
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
					style="background-color: #3d3d3d; margin: 16px 0; padding: 8px; border-radius: 8px">
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
				style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
				<h2>Créer une Réservation</h2>
				<form action="BookingController" method="post"
					style="display: flex; flex-direction: column; justify-content: space-between;">
					<input type="hidden" name="op" value="check">
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Date Début:</p>
						<input type="text" id="datepicker" name="startDate"
							value="<%=(String) request.getAttribute("start") == null ? "" : (String) request.getAttribute("start")%>">
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Date Fin:</p>
						<input type="text" id="datepicker2" name="endDate"
							value="<%=(String) request.getAttribute("end") == null ? "" : (String) request.getAttribute("end")%>">
					</div>


					<div
						style="display: flex; flex-direction: row; justify-content: center; padding: 8px">
						<input style="padding: 8px" type="submit" value="Rechercher">
					</div>
				</form>
				<%
				List<Room> rooms = (ArrayList<Room>) request.getAttribute("rooms");
				String startDate = (String) request.getAttribute("start");
				String endDate = (String) request.getAttribute("end");
				//System.out.println("start: "+startDate + "End : "+endDate);
				if (startDate != null && endDate != null && rooms != null && !rooms.isEmpty()) {
				%>
				<form action="BookingController" method="post">
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<input type="hidden" name="op" value="add"> <input
							type="hidden" name="startDate" value="<%=startDate%>"> <input
							type="hidden" name="endDate" value="<%=endDate%>">
						<p>Client:</p>
						<select style="width: 170px" name="client">
							<option value="">Select a client</option>
							<%
							UserService us = new UserService();
							List<User> users = us.findAll();
							for (User user : users) {
							%>
							<option value="<%=user.getId()%>"><%=user.getUsername()%></option>
							<%
							}
							%>
						</select>
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Chambre:</p>
						<select style="width: 170px" name="room">
							<option value="">Select a room</option>
							<%
							for (Room room : rooms) {
							%>
							<option value="<%=room.getId()%>"><%=room.getNum()%></option>
							<%
							}
							%>
						</select>
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: center; padding: 8px">
						<input style="padding: 8px" type="submit" value="Créer">
					</div>
				</form>

				<%
				}
				%>


			</div>
			<h2>Liste des Réservations</h2>
			<div style=" display: flex; flex-wrap: wrap; flex-direction: column;">
				<form action="BookingController" method="get">
					<input type="radio" id="all" name="criteria" value="all"> <label for="all">All</label>
					<input type="radio" id="past" name="criteria" value="past"> <label for="past">Past</label>
					<input type="radio" id="current" name="criteria" value="current"> <label for="current">Current</label>
					<input type="radio" id="upcoming" name="criteria" value="upcoming"> <label for="upcoming">Upcoming</label>
					<input type="submit" value="Search" >
					<input type="hidden"  name="op" value="filter">
				</form>
				<%
				BookingService bs = new BookingService();
				
				List<Booking> bookings = new ArrayList<Booking>();
				if(request.getParameter("criteria") == null){
					bookings = bs.findAll();
				}else if(request.getParameter("criteria").equals("current")){
					bookings = bs.findCurrent();
				}else if(request.getParameter("criteria").equals("upcoming")){
					bookings = bs.findUpcoming();
				}else if(request.getParameter("criteria").equals("all")){
					bookings = bs.findAll();
				}else if(request.getParameter("criteria").equals("past")){
					bookings = bs.findPast();
				}
							
				for (Booking booking : bookings) {
				%>
				<div class="BookingCard"
					style="display: flex; flex-direction: row; background-color: #616161; margin: 8px 0; padding: 12px">

					<div style="display: inline-block;">
						<form action="BookingController" method="post"
							style="display: flex; flex-direction: column; justify-content: space-between;">
							<input type="hidden" name="op" value="update"> <input
								type="hidden" name="id" value="<%=booking.getId()%>">

							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Date Début:</p>
								<input readonly="readonly" type="text" id="datepicker"
									name="startDate" value="<%=booking.getStartDate()%>">
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Date Fin:</p>
								<input readonly="readonly" type="text" id="datepicker2"
									name="endDate" value="<%=booking.getEndDate()%>">
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Client:</p>
								<select style="width: 177px" name="client">
									<option value="<%=booking.getClient().getId()%>"><%=booking.getClient().getUsername()%></option>
									<%
									UserService us = new UserService();
									List<User> users = us.findAll();
									for (User user : users) {
									%>
									<option value="<%=user.getId()%>"><%=user.getUsername()%></option>
									<%
									}
									%>
								</select>
							</div>

							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Room:</p>
								<select style="width: 177px" name="room">
									<option value="<%=booking.getRoom().getId()%>"><%=booking.getRoom().getNum()%></option>
									<%
									RoomService rs = new RoomService();
									List<Room> roomsAvailablePerBooking = rs.findAvailableRooms(booking.getStartDate(), booking.getEndDate());

									for (Room room : roomsAvailablePerBooking) {
									%>
									<option value="<%=room.getId()%>"><%=room.getNum()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Prix:</p>
								<input readonly="readonly" type="text" name="price"
									value="<%=booking.getPrice()%>">
							</div>
							<div style="display: flex; flex-direction: row; margin-top: 6px;margin-left: 88px">

								<input type="submit" value="Modifier">

								<div style="background-color: red; padding: 6px">
									<a style="text-decoration: none; color: white"
										href="BookingController?id=<%=booking.getId()%>&op=delete">Annuler</a>
								</div>

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
<script>
	$(function() {
		$.datepicker.setDefaults({
			onClose : function(date, inst) {
				$("#selectedDtaeVal").html(date);
			},
			minDate : 0,
			maxDate : +15,
			dateFormat : "yy/mm/dd"
		});

		$("#datepicker").datepicker();

	});
	$(function() {
		$.datepicker.setDefaults({
			onClose : function(date, inst) {
				$("#selectedDtaeVal").html(date);
			},
			minDate : 0,
			maxDate : +15,
			dateFormat : "yy/mm/dd"
		});

		$("#datepicker2").datepicker();

	});
</script>
</html>