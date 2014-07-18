module AtencionesSaludHelper

	def getComentario(id)
		@FiPerDiagAtenSal = FiPersonaDiagnosticosAtencionesSalud.where("atencion_salud_id = ?",id).first
		return @FiPerDiagAtenSal.comentario
	end
	
end
