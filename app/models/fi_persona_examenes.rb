class FiPersonaExamenes < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :examen, :class_name => 'MedExamenes'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  private
  def app_params
    params.require(:list).permit(:id,
  								:persona,
  								:examen,
  								:atencion_salud)
  end
								

end
