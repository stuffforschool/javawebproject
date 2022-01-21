<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="styles/styles.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="container">
		<%
		//String userId = session.getAttribute("userId").toString();
		if (session.getAttribute("userId") == null) {
			response.sendRedirect("login.jsp");
		}
		%>
		<jsp:include page="fragments/navbar.jsp"></jsp:include>
		<div
			style="max-width: 1200px; margin-left: auto; margin-right: auto; height: 95vh; display: flex; justify-content: center; align-items: center;">
			<form action="ContactController" method="post">

				<div
					style="width: 500px; height: 400px; display: flex; flex-direction: column; background-color: rgba(33, 33, 33, 1); box-shadow: 3px 3px 3px black">
					<div
						style="color: #d6d6d6; font-weight: bold; text-align: center; padding: 12px; border: 1px;; border-color: #575757; font-size: large;">
						Contacter le support</div>
					<div
						style="height: 100%; background-color: #333333; display: flex; justify-content: center; align-items: center; flex-direction: column">
						<div
							style="display: flex; flex-direction: column; justify-content: space-between; width: 70%; margin: 10px 0">

							<textarea
								style=" border-radius: 6px; background-color: rgba(33, 33, 33, 1); color: #d6d6d6;height: 200px"
								type="text" name="msg" ; ></textarea>
						</div>
					


						


						<input
							style="width: 70%; margin: 4px auto; padding: 8px 0; background-color: #383838; color: #d6d6d6; cursor: pointer; margin-top: 12px"
							type="submit" value="Envoyer">

					
					</div>

				</div>
			</form>



		</div>
	</div>
</body>
</html>