# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
		users = users
		console.log(JSON.parse(users))
		#name dropdown event handler#
		select = $("#printer_data_name")
		select.change ->
			selection = select.val()
			console.log(JSON.parse(users))