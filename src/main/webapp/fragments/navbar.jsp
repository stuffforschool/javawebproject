<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<link href="../styles/styles.css" rel="stylesheet" type="text/css" />

<div class="navbarContainer">
	<div class="navbar">
		<div style="display: flex; flex-direction: row;">
			<a style="text-decoration: none; color: white"
				href="/LearningJavaWeb">Home</a> <a
				style="text-decoration: none; color: white; margin-left: 24px"
				href="/LearningJavaWeb/admin.jsp">Admin?</a>
		</div>
		<div class="navItemsContainer">
			<%
			//String userId = session.getAttribute("userId").toString();
			if (session.getAttribute("userId") != null) {
				UserService us = new UserService();
				User user = us.findById((int) session.getAttribute("userId"));
			%>
			<div style="display: flex; flex-direction: row; align-items: center;">
				<div style="text-align: center; margin-right: 4px">
					<a href="/LearningJavaWeb/profile.jsp"
						style="text-decoration: none; color: white;"><%=user.getUsername()%></a>

				</div>
				<form action="LogoutController" method="post">
					<input style="width: auto; margin: 4px auto;" type="submit"
						value="Se déconnecter">
				</form>
			</div>

		</div>
		<%
		} else {
		%>

		<div
			style="margin-right: 4px; background-color: #fafafa; padding: 4px 8px; border-radius: 8px;">
			<a style="text-decoration: none; color: #1b1d21; font-size: large;"
				href="login.jsp"> login</a>
		</div>
		<div
			style="margin-right: 4px; background-color: #fafafa; padding: 4px 8px; border-radius: 8px;">
			<a style="text-decoration: none; color: #1b1d21; font-size: large;"
				href="register.jsp"> register</a>
		</div>
		<%
		}
		%>
	</div>
</div>

</div>