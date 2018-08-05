# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->  
	$(document).ready -> 
		users = window.f_users
		#name dropdown event handler#
		select = $("#printer_datum_name")
		select.change ->
			selection = select.val()
			phonenumber = ""
			for i in users
				if selection is users[i].name
					phonenumber = users[i].number
					alert phonenumber
			if phonenumber != null
				select.val(phonenumber)