# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->  
	$(document).ready -> 
		alert "ready"
		#users = window.f_users
		#alert window.f_users
		#name dropdown event handler#
		select = $("#printer_datum_name")
		select.change ->
			alert "change"
			selection = select.val()
			phonenumber = "3"
			#for i in f_users
			#	if selection is f_users[i].name
			#		phonenumber = f_users[i].number
			#		alert phonenumber
			if phonenumber != null
				select.val(phonenumber)