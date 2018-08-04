# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
	
	
	

		
	
	$(document).ready ->
	
		#name dropdown event handler#
		select = $("#printer_data_name")
		select.change ->
			selection = select.val()
			$.ajax({
				url:"fabrication_users",
				dataType: "json",
				data: { name: $(selection)},
				success: function(data){
					$("#printer_data_phonenumber").val(data)
				}
			});

		
