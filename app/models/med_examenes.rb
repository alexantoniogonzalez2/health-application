class MedExamenes < ActiveRecord::Base

	has_many :persona_examenes, :class_name => 'FiPersonaExamenes', :foreign_key => 'examen_id' 	

  private
  def app_params
    params.require(:list).permit(:codigo_isapre, :descripcion, :id, :indicaciones, :nombre, :persona_examenes)
  end

end
