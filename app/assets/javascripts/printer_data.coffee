# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->   
		gon.f_users
		alert gon.f_users
		#name dropdown event handler#
		select = $("#printer_data_name")
		select.change ->
			selection = select.val()
			for i in gon.f_users
				if gon.f_users[i].name == selection
					phonenumber = gon.f_users[i].number
					alert phonenumber
			if phonenumber != null
				select.val(phonenumber)