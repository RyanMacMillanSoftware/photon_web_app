# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
	
	
	

		
	
	$(document).ready ->

		# Setup on doc load#
		
		currentdate = new Date();
		time = currentdate.getHours()
		$("#time_punch_buddy").append('<option value="Staff">Staff</option>')
	
		
		if (((time>=6)&&(time<8))||(time>=22))
      	$("#green_status").hide()
      	$("#orange_status").show()
      	$("#red_status").hide()
		else if ((time>=8)&&(time<22))
      	$("#green_status").show()
      	$("#orange_status").hide()
      	$("#red_status").hide()		
		else 
      	$("#green_status").hide()
      	$("#orange_status").hide()
      	$("#red_status").show()	
				
		
	
		$("#guest_name_id").hide()	
		$("#guest_buddy_name_id").hide()	
			
			
			
		
		#change dynamically#
	
		select = $("#time_punch_name")
		select.change ->
			selection = select.val()
			if selection is "Guest" 
				$("#guest_name_id").show()
				select2 = $("#time_punch_buddy")
				selection2 = select2.val()
				if selection2 is "Guest" 
      				$("#guest_buddy_name_id").show()
			else 
				$("#guest_name_id").hide()	
	
		select2 = $("#time_punch_buddy")
		select2.change ->
			selection2 = select2.val()
			if selection2 is "Guest" 
      		$("#guest_buddy_name_id").show()
			else 
				$("#guest_buddy_name_id").hide()	
						
				
		
