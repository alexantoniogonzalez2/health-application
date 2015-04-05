class FiGestas < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
	has_many :parentesco, :class_name => 'PerParentescos', :foreign_key => 'gesta_id'
  has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'gesta_id'	

	private
  def app_params
    params.require(:list).permit(:desenlace, :fecha_inicio, :fecha_termino, :id, :parentesco,	:persona,	:persona_diagnosticos)
  end
								
end
