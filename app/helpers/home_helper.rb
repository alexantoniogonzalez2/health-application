module HomeHelper
	def getPersona(id)
		@persona = PerPersonas.find(id)
		return @persona.showName('%n%p%m') 
	end
end
