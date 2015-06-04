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

	if($(".status_messages_wrapper").length > 0){
		$("#main_wrapper").animate({
			marginTop: "120px"
		},500);
		$(".status_messages_wrapper").animate({
			height: "50px"
		},500);

		$(".status_messages_wrapper img").click(function(){
			$("#main_wrapper").animate({
				marginTop: "70px"
			},500);
			$(".status_messages_wrapper").slideToggle(500);
		});
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