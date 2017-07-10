# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
	
	
	

		
	
	$(document).ready ->

		# Setup on doc load#
		
		currentdate = new Date();
		time = currentdate.getHours()

		#The staff option is appended. In the future this option could become a MicroFabUser that is hidden from the index. This would make it alphabetically sorted. Another improvement would be appending to the start of the list (still below the blank default#
		$('#time_punch_buddy').prepend($('<option>', {
			value: 'Guest',
			text: 'Guest'
		}));
		$('#time_punch_buddy').prepend($('<option>', {
			value: 'Staff',
			text: 'Staff'
		}));
		$('#time_punch_buddy').prepend($('<option>', {
			value: '',
			text: ''
		}));
		$('#time_punch_name').prepend($('<option>', {
			value: 'Guest',
			text: 'Guest'
		}));
		$('#time_punch_name').prepend($('<option>', {
			value: '',
			text: ''
		}));

		$('#time_punch_name').val('')
		$('#time_punch_buddy').val('')

		#shows the status of the lab dependant on chemistry guidelines as of June 2017#
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
				
		
		#hide the guest text entry fields#
		$("#guest_name_id").hide()	
		$("#guest_buddy_name_id").hide()	
			
			
			
		
		#the visibility of guest entry fields changes dynamically. only show guest entry fields when guest is selected from the corresponding dropdown#
	
		#name dropdown event handler#
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
		
		#buddy dropdown event handler#
		select2 = $("#time_punch_buddy")
		select2.change ->
			selection2 = select2.val()
			if selection2 is "Guest" 
      		$("#guest_buddy_name_id").show()
			else 
				$("#guest_buddy_name_id").hide()	
						
				
		
