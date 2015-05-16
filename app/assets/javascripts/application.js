//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function printTrainingTable(){
	var restorePage = document.body.innerHTML;
	$("#trainings_table").find("td").each(function(){
		if($(this).text().trim() == "Training löschen"){
			$(this).html("");
		}
	});
	$("#trainings_table").find("th").each(function(){
		if($(this).text().trim() == "Aktionen"){
			$(this).html("");
		}
	});
	var printContent = document.getElementById("trainings_table").outerHTML;
	document.body.innerHTML = printContent;
	window.print();
	document.body.innerHTML = restorePage;
}

$(document).ready(function(){
	if(window.location.pathname == "/dashboard"){
		setInterval("updateDateTile();", 1000);
	}
});

function updateDateTile(){
	$.ajax({
		type: "GET",
      	url: "/time_status",
      	dataType: "html",
      	success: function(data){
      		$("#time_status").html(data);
      	}
	});
	$.ajax({
		type: "GET",
      	url: "/date_status",
      	dataType: "html",
      	success: function(data){
      		$("#date_status").html(data);
      	}
	});
}