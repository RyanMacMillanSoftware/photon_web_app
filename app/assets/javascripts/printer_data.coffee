# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
		users = f_users
		alert users
		console.log users
		console.log "hello"
		console.log f_users
		#name dropdown event handler#
		select = $("#printer_datum_name")
		select.change ->
			selection = select.val()
			for i in f_users
				if f_users[i].name == selection
					phonenumber = f_users[i].number
					alert phonenumber
			if phonenumber != null
				select.val(phonenumber)