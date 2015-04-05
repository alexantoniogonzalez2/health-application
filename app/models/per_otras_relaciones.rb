class PerOtrasRelaciones < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
  belongs_to :persona_relacion, :class_name => 'PerPersonas'
 	
	private
  def app_params
    params.require(:list).permit(:id,:persona,:persona_relacion,:relacion)
  end
			
end
