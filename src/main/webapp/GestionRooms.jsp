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
					style="background-color: #3d3d3d; margin: 16px 0; padding: 8px; border-radius: 8px">
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
				<h2>Ajouter une Chambre</h2>
				<form action="RoomController" method="post"
					enctype="multipart/form-data"
					style="display: flex; flex-direction: column; justify-content: space-between;">
					<input type="hidden" name="op" value="add">
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Numero:</p>
						<input type="text" name="num">
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Type:</p>
						<select style="width: 177px" name="type">
							<option value="">Select a type</option>
							<option value="Single">Single</option>
							<option value="Double">Double</option>
							<option value="Suite">Suite</option>
							<option value="King">King</option>
							<option value="Queen">Queen</option>
							<option value="Studio">Studio</option>
						</select>
					</div>
					<div
						style="display: flex; flex-direction: row; justify-content: space-between;">
						<p>Prix:</p>
						<input type="number" name="price">
					</div>

					<div
						style="display: flex; flex-direction: row; justify-content: space-between; align-items: center;">
						<p>Photo:</p>
						<label for="uploadBtn" style="border: 1px solid #ccc;display: inline-block;padding: 6px 12px; cursor: pointer;width: 150px;text-align: center;" >Upload</label>
						<input id="uploadBtn" style="display: none;"  type="file" name="file">
					</div>

					<div
						style="display: flex; flex-direction: row; justify-content: center; padding: 8px;">
						<input style="padding: 8px;background-color: #212121;color:white;border-radius: 2px;font-weight: bold;" type="submit" value="Ajouter">
					</div>
				</form>
			</div>
			<h2>Liste des Chambres</h2>
			<div
				style=" display: flex; flex-wrap: wrap; flex-direction: column;">

				<%
				RoomService rs = new RoomService();
				List<Room> rooms = rs.findAll();
				for (Room room : rooms) {
				%>
				<div class="RoomCard"
					style="display: flex; flex-direction: row; background-color: #616161; margin: 8px auto; padding: 12px;border-radius: 6px;">
					<div style="padding: 12px">
						<img alt="No image found for this room"
							src=<%="images/rooms/room-" + room.getNum()%>
							style="width: 250px; height: 200px">
					</div>
					<div style="display: inline-block;padding: 12px">
						<form action="RoomController" method="post"
							style="display: flex; flex-direction: column; justify-content: space-between;">
							<input type="hidden" name="op" value="update"> <input
								type="hidden" name="id" value="<%=room.getId()%>">
							<div style="display: flex; flex-direction: row;">
								<p style="margin-right: 6px" >Numero:</p>
								<input type="text" name="num" value="<%=room.getNum()%>">
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Type:</p>
								<select style="width: 74%" name="type">
									<option value="<%=room.getType()%>"><%=room.getType()%></option>

									<option value="Single">Single</option>
									<option value="Double">Double</option>
									<option value="Suite">Suite</option>
									<option value="King">King</option>
									<option value="Queen">Queen</option>
									<option value="Studio">Studio</option>
								</select>
							</div>
							<div
								style="display: flex; flex-direction: row; justify-content: space-between;">
								<p>Prix:</p>
								<input type="number" name="price" value="<%=room.getPrice()%>">
							</div>

							<div style="display: flex; flex-direction: row; margin-top: 6px">

								<input style="font-weight: bold;text-align: center;" type="submit" value="Modifier">
								<%
								if (rs.hasBooking(room)) {
								%>
								<div style="background-color:; padding: 6px">Is booked</div>
								<%
								} else {
								%>
								<div style="background-color: red; padding: 6px">
									<a style="text-decoration: none; color: white;font-weight: bold;display: flex;text-align: center;align-items: center;"
										href="RoomController?id=<%=room.getId()%>&op=delete">Supprimer</a>
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