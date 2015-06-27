//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .

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

	var dragOpts = {
		containment: "document",
		cursor: "move",
		helper: "clone",
		revert: "invalid",
		snap: true,
		snapMode: "inner",
		snapTolerance: 10,
		zIndex: 2
	}
	$("#draggable_group_list li").draggable(dragOpts);
	var dropOpts = {
		accept: "#draggable_group_list li",
		tolerance: "fit",
		activate: function(typ,ui){
			$(this).css("border","1px solid black");
		},
		deactivate: function(typ,ui){
			$(this).css("border","1px solid lightgray");
		},
		over: function(typ,ui){
			$(this).css("border","1px solid green");
		},
		out: function(typ,ui){
			$(this).css("border","1px solid black");
		},
		drop: function(typ,ui){
			$(this).css("border","none");
			var cloneElement = ui.draggable.clone();
			$(cloneElement).appendTo(this);
			//$(this).droppable("destroy");
			$(cloneElement).addClass("dropped_group_list_li");
			$(cloneElement).css({top:"0px",left:"0px",bottom:"0px",right:"0px", display: "block", width:"100%",height:"40px"});
			$(cloneElement).parent().attr("data-group",$(cloneElement).attr("data-group"));
		}
	}
	$(".dropable_trainingsplan_table_cell").droppable(dropOpts);
});

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

function printBill(){
	var restorePage = document.body.innerHTML;
	$("#bill input").remove();
	var printContent = document.getElementById("bill").outerHTML;
	document.body.innerHTML = printContent;
	window.print();
	document.body.innerHTML = restorePage;
}

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