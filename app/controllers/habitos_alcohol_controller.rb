class HabitosAlcoholController < ApplicationController
	def new 
	end
	def create
		@test_audit = FiHabitosAlcohol.new
		@test_audit.save!

		#render :js => "window.location = '/habitos_alcohol/show'"<<@test_audit.id

		#redirect_to :action => "show", :id => @test_audit.id
	end
	def show

	end	
end
