module AtencionesSaludHelper
	def getComentario(id)
		@FiPerDiagAtenSal = FiPersonaDiagnosticosAtencionesSalud.where("persona_diagnostico_id = ?",id).first
		return @FiPerDiagAtenSal.comentario
	end
	def getPersona(atencion_salud_id)
		@FiAtencionesSalud = FiAtencionesSalud.where("id = ?",atencion_salud_id).first
		return @FiAtencionesSalud.persona_id
	end
end
