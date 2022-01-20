<%@page import="services.UserService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entities.Room"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="styles/styles.css" rel="stylesheet" type="text/css" />
<title>Results</title>
</head>
<body>
	<jsp:include page="fragments/navbar.jsp"></jsp:include>
	<div class="homeContainer"
		style="background-color: #1b1d21; color: white">

		<div
			style="display: flex; flex-direction: row; padding: 12px; flex-wrap: wrap;">
			<%
			List<Room> rooms = (ArrayList<Room>) request.getAttribute("results");

			for (Room room : rooms) {
			%>

			<div
				style="margin: 6px; width: 300px; height: 500px; display: flex; flex-direction: column; background-color: #5c5c5c; box-shadow: 5px 5px 5px black">
				<img alt="No image found for this room"
					src=<%="images/rooms/room-" + room.getNum()%>
					style="width: 300px; height: 250px; box-shadow: 3px 3px 3px black">
				<div
					style="display: flex; flex-direction: column; padding: 16px; align-items: center; justify-content: center;">
					<div
						style="display: flex; flex-direction: row; width: 70%; justify-content: space-between; padding: 0 12px; color: white; font-weight: bold; font-size: large; background-color: #383838; margin-top: 4px; border-bottom: 3px; border-right: 3px; border-color: #828282; border-style: solid; border-top: 0px; border-left: 0px">
						<p>Numero:</p>
						<p><%=room.getNum()%></p>
					</div>
					<div
						style="display: flex; flex-direction: row; width: 70%; justify-content: space-between; padding: 0 12px; color: white; font-weight: bold; font-size: large; background-color: #383838; margin-top: 4px; border-bottom: 3px; border-right: 3px; border-color: #828282; border-style: solid; border-top: 0px; border-left: 0px">
						<p>Type:</p>
						<p><%=room.getType()%></p>
					</div>
					<div
						style="display: flex; flex-direction: row; width: 70%; justify-content: space-between; padding: 0 12px; color: white; font-weight: bold; font-size: large; background-color: #383838; margin-top: 4px; border-bottom: 3px; border-right: 3px; border-color: #828282; border-style: solid; border-top: 0px; border-left: 0px">
						<p>Prix:</p>
						<p><%=room.getPrice() + " Dh"%></p>
					</div>

					<div style="margin-top: 6px">
						<form action="BookingController" method="post">
							<input type="hidden" name="room" value="<%=room.getId()%>">
							<input type="hidden" name="op" value="add"> <input
								type="hidden" name="from" value="client"> <input
								type="hidden" name="client"
								value="<%=session.getAttribute("userId") == null ? "" : session.getAttribute("userId").toString()%>">
							<input type="hidden" name="startDate"
								value="<%=request.getParameter("startDate").toString().replace("-", "/")%>">
							<input type="hidden" name="endDate"
								value="<%=request.getParameter("endDate").toString().replace("-", "/")%>">
							<%
							if (session.getAttribute("userId") == null) {
							%>
							<a
								style="text-decoration: none; color: white; text-align: center; background-color: #303030; padding: 6px; margin: 8px"
								href="/LearningJavaWeb/login.jsp?src=SearchController&startDate=<%=request.getParameter("startDate")%>&endDate=<%=request.getParameter("endDate")%>">Connectez-vous
								pour réserver</a>
							<%
							} else {
							UserService us = new UserService();
							if (us.isVerified(us.findById(Integer.parseInt(session.getAttribute("userId").toString())))) {
							%>

							<input
								style="background-color: #333333; padding: 8px; color: white; cursor: pointer;"
								type="submit" value="Réserver">
							<%
							} else {
							%>
							<a
								style="color: white; text-align: center; background-color: #303030; padding: 6px; margin: 8px"
								href="/LearningJavaWeb/RegisterController?action=send&id=<%=session.getAttribute("userId").toString()%>">
								Verify your email </a>
							<%
							}
							}
							%>
						</form>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<div>
</body>
</html>



