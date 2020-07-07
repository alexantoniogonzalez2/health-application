class FdEndodoncias < ActiveRecord::Base
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales', optional: true
	belongs_to :diagnostico, :class_name => 'FdDiagnosticos', optional: true
	has_many :test_diagnostico, :class_name => 'FdTestDiagnostico', :foreign_key => 'endodoncia_id'

	def getDiagnosis
		@diagnosis = []
    test_diagnostico.each do |test|
      @diagnosis << test.getEstado
    end

    return @diagnosis
	end

	def app_params
    params.require(:list).permit(:id,:atencion_salud,:pieza_dental,:comienzo_dolor,:dolor,:intensidad,:es_pulsatil,:cede_con_analgesicos,:duele_al_acostarse,:es_posible_senalar,:se_genera_con_calor,:se_genera_con_frio,:se_genera_con_dulce,:se_genera_al_masticar,:informacion_adicional,:examen_extraoral,:examen_intraoral,:examen_radiologico,:comentario,:diagnostico,:test_diagnostico)
  end

end
