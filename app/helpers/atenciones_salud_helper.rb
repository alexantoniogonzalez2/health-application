module AtencionesSaludHelper
	def getComentario(id)
		@FiPerDiagAtenSal = FiPersonaDiagnosticosAtencionesSalud.where("persona_diagnostico_id = ?",id).first
		return @FiPerDiagAtenSal.comentario
	end
end
