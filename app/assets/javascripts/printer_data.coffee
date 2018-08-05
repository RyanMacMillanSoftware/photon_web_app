# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->  
	$(document).ready -> 
		users = f_users
		#name dropdown event handler#
		select = $("#printer_datum_name")
		number_field = $("#printer_datum_phonenumber")
		select.change ->
			selection = select.val()
			for index,user of users
				if selection is user.name
					phonenumber = user.number
			if phonenumber != null
				number_field.val(phonenumber)