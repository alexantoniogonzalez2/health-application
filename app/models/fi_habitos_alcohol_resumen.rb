class FiHabitosAlcoholResumen < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'

	private
  def app_params
    params.require(:list).permit(:id,:frecuencia,:tipo,:cantidad)
  end
end
