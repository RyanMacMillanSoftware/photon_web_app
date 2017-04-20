class JavascriptsController < ApplicationController
	def dynamic_users
		@users=User.find(:all)
	end
end
