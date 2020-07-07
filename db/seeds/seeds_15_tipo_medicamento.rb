puts 'Metatipos de Medicamentos'
MedMedicamentosMetatipos.create! :nombre => 'Unidad'
MedMedicamentosMetatipos.create! :nombre => 'Líquido'
MedMedicamentosMetatipos.create! :nombre => 'Gotas'
MedMedicamentosMetatipos.create! :nombre => 'Vacuna'
MedMedicamentosMetatipos.create! :nombre => 'Aplicación'
MedMedicamentosMetatipos.create! :nombre => 'Otro'

puts 'Tipos de Medicamentos'
tipos_medicamentos_list = [
['Comprimido','comprimidos',1],
['Pastilla','pastillas',1],
['Tableta','tabletas',1],
['Tableta dispersable','tabletas',1],
['Gránulo','gránulos',1],
['Óvulo','óvulos',1],
['Gragea','grageas',1],
['Cápsula','cápsulas',1],
['Supositorio','supositorios',1],
['Glóbulo','glóbulos',1],
['Aerosol para inhalación','dosis',1],
['Parche','parches',1],
['Ampolla','ampollas',1],
['Inhalador','dosis',1],
['Sobre','sobres',1],
['Sachet','sachets',1],
['Suspensión inyectable','dosis',1],
['Goma de mascar','unidades',1],
['Otro','unidades',1],
['Jalea','unidades',1],
['Suspensión','ml',2],
['Jarabe','ml',2],
['Solución','ml',2],
['Emulsión','ml',2],
['Gotas','gotas',3],
['Vacuna','',4],
['Crema','',5],
['Solución tópica','',5],
['Loción capilar','',5],
['Gel','',5],
['Loción tópica','',5],
['Ungüento','',5],
['Pomada','',5],
['Polvo tópico','',5],
['Loción dérmica','',5],
['Polvo dérmico','',5],
['Ungüento dérmico','',5],
['Loción','',5],
['Shampoo','',5],
['Colutorio','',5],
['Pasta dentífrica','',5],
['Talco','',5],
['Polvo efervescente','',6],
['Polvo','',6],
['Granulado','',6],
['Enema','',6],
['Anillo','',6],
['Implante','',6],
['Dispositivo','',6]
]

ActiveRecord::Base.transaction do
	tipos_medicamentos_list.each do |nombre, unidad, medicamento_metatipo |
	  MedMedicamentosTipos.create! nombre: nombre, unidad: unidad, medicamento_metatipo: MedMedicamentosMetatipos.find(medicamento_metatipo)
	end
end	