# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
	
	
	
	select = $("#time_punch_name")

	select2 = $("#time_punch_buddy")	
	
	$(document).ready ->
		
		select = $("#time_punch_name")

		select2 = $("#time_punch_buddy")	
		selection = select.val()
		selection2 = select2.val()
		if selection is "Guest" 
      	$("#guest_name_id").show()
		else 
			$("#guest_name_id").hide()	
		if selection2 is "Guest" 
      	$("#guest_buddy_name_id").show()
		else 
			$("#guest_buddy_name_id").hide()	
		
	select.change ->
		selection = select.val()
		if selection is "Guest" 
      	$("#guest_name_id").show()
		else 
			$("#guest_name_id").hide()	
	
	
	select2.change ->
		selection2 = select2.val()
		if selection2 is "Guest" 
      	$("#guest_buddy_name_id").show()
		else 
			$("#guest_buddy_name_id").hide()				
				
		
