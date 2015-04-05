class PerParentescos < ActiveRecord::Base

  belongs_to :hijo, :class_name => 'PerPersonas'
  belongs_to :progenitor, :class_name => 'PerPersonas'
  belongs_to :gesta, :class_name => 'FiGestas'
 	
	private
  def app_params
    params.require(:list).permit(:id,:gesta,:hijo,:progenitor)
  end
			  					
end
