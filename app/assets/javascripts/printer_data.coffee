# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->  
	$(document).ready -> 
		users = f_users
		console.log users
		#name dropdown event handler#
		select = $("#printer_datum_name")
		select.change ->
			selection = select.val()
			phonenumber = ""
			for index,user of users
				if selection is user.name
					phonenumber = user.number
					alert phonenumber
			if phonenumber != null
				select.val(phonenumber)