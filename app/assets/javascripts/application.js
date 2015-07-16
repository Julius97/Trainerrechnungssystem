//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.turbolinks
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
			$(this).css("border","1px solid orange");
		},
		out: function(typ,ui){
			$(this).css("border","1px solid black");
		},
		drop: function(typ,ui){
			$(this).css("border","none");
			var cloneElement = ui.draggable.clone();
			$(cloneElement).appendTo(this);
			//$(this).droppable("destroy");
			$(cloneElement).addClass("dropped_group_list_li").on("click",removeDroppedObj).on("mousemove",showInformationBox).on("mouseout",hideInformationBox);
			$(cloneElement).css({top:"0px",left:"0px",bottom:"0px",right:"0px", display: "block", width:"100%",height:"40px"});
			existent_groups = ""
			if($(cloneElement).parent().attr("data-group") != -1){
				existent_groups = $(cloneElement).parent().attr("data-group");
			}
			$(cloneElement).parent().attr("data-group",existent_groups+$(cloneElement).attr("data-group")+";");
		}
	}
	$(".droppable_trainingsplan_table_cell").droppable(dropOpts);
	$(".dropped_group_list_li").on("click",removeDroppedObj);
	$(".dropped_group_list_li").on("mousemove",showInformationBox);
	$(".dropped_group_list_li").on("mouseout",hideInformationBox);
});

function showInformationBox(e){
	//alert("Test");
	$("#information_box").show();
	$("#information_box").css("top",e.pageY+10+"px");
	$("#information_box").css("left",e.pageX+10+"px");
}

function hideInformationBox(){
	$("#information_box").hide();
}

function removeDroppedObj(){
	if(confirm($(this).text() + " - Eintrag entfernen?")){
		oldGroupIds = $(this).parent().attr("data-group");
		newGroupIds = oldGroupIds.replace($(this).attr("data-group") + ";", "");
		if(newGroupIds == "") newGroupIds = "-1";
		$(this).parent().attr("data-group",newGroupIds);
		$(this).remove();
	}
}

function saveTrainingsPlan(){
	if(confirm("Kompletter Trainingsplan wird überschrieben! Wirklich speichern?")){
		$.post("/clean_trainingsplan_before_update").done(function(){
			$(".droppable_trainingsplan_table_cell").each(function(){
				if($(this).attr("data-group") != "-1"){
					var group_ids_value = $(this).attr("data-group");
					var wday = parseInt($(this).attr("data-wday"));
					var start = parseInt($(this).attr("data-start"));
					var end = parseInt($(this).attr("data-end"));
					group_ids = group_ids_value.split(";");
					for(var i = 0; i < group_ids.length; i++){
						if(group_ids[i] != ""){
							group_id = parseInt(group_ids[i]);
							$.post("/trainingsplan",{group_id:group_id, wday:wday, start:start, end:end});
						}
					}
				}
			});
		});
	}
}

function resetTrainingsPlan(){
	if(confirm("Wirklich zurücksetzen ohne zu speichern?")) location.reload();
}

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

function printBill(partialId){
	var restorePage = document.body.innerHTML;
	$(".bill input").remove();
	var printContent = document.getElementById(partialId).outerHTML;
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