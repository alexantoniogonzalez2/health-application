class MedAlergias < ActiveRecord::Base

  has_many :personas_alergias, :class_name => 'FiPersonasAlergias', :foreign_key => 'alergia_id' 

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:personas_alergias, :comun)
  end

end
