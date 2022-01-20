<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Home page</title>
<link href="styles/styles.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body style="margin: 0px">

	<jsp:include page="fragments/navbar.jsp"></jsp:include>
	<div class="homeContainer">
		<div class="hero">
			<div class="heroText">Calme,Pacifique et meilleur choix pour
				vos vacances.</div>
			<div>
				<img alt="hero image" src="images/heroImg.png">
			</div>
		</div>



		<form action="SearchController" method="get">
		<div style="margin: 0  auto;margin-top: 48px ;width: max-content;font-weight: bolder;font-size: larger " >Trouvez une chambre a réserver.</div>
			<div
				style="display: flex; flex-direction: row; align-items: center; width: 0 auto; justify-content: center;padding:24px 0"
				class="searchBar">
				<p style="margin: 20px 1px;font-weight: bold;font-size: larger;" >
					De: <input style="padding: 8px" type="text" id="datepicker" name="startDate"
						required="required">
				</p>
				<p style="margin: 0 1px;font-weight: bold;font-size: larger;">
					Jusqu'à: <input style="padding: 8px" type="text" id="datepicker2" name="endDate"
						required="required">
				</p>
				<p style="margin: 0 1px;font-weight: bold;font-size: larger;">
					Type: <select style="width: 170px;padding: 8px" name="type">
						<option value="all" >All</option>	
						<option value="single" >Single</option>
						<option value="Double">Double</option>
						<option value="Suite">Suite</option>
						<option value="King">King</option>
						<option value="Queen">Queen</option>
						<option value="Studio">Studio</option>
					</select>
				</p>
				<p style="margin: 0 1px;font-weight: bold;font-size: larger;">
					Prix: <input style="padding: 8px" type="number" name="price" required="required">
				</p>
				<input type="submit" value="Rechercher" class="searchButton">
			</div>
		</form>



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