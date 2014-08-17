class FiPersonasAlergias < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :alergia, :class_name => 'MedAlergias' 
	
	private
  def app_params
    params.require(:list).permit(:id,:persona,:alergia)
  end

end
