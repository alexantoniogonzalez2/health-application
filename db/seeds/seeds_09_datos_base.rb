puts 'Especialidad 1'
E1 = ProEspecialidades.create! :nombre => "Medicina General"
E2 = ProEspecialidades.create! :nombre => "Pediatría"
E3 = ProEspecialidades.create! :nombre => "Cardiología"
ProEspecialidades.create! :nombre => "Broncopulmonar"
ProEspecialidades.create! :nombre => "Dermatología"
ProEspecialidades.create! :nombre => "Endocrinología"
ProEspecialidades.create! :nombre => "Fonoaudiología"
ProEspecialidades.create! :nombre => "Gastroenterología"
ProEspecialidades.create! :nombre => "Geriatría"
ProEspecialidades.create! :nombre => "Ginecología"
ProEspecialidades.create! :nombre => "Nefrología"
ProEspecialidades.create! :nombre => "Neurología"
ProEspecialidades.create! :nombre => "Nutrición"
ProEspecialidades.create! :nombre => "Odontología"
ProEspecialidades.create! :nombre => "Oftalmología"
ProEspecialidades.create! :nombre => "Oncología"
ProEspecialidades.create! :nombre => "Otorrinolaringología"
ProEspecialidades.create! :nombre => "Psicología"
ProEspecialidades.create! :nombre => "Psiquiatría"
ProEspecialidades.create! :nombre => "Reumatología"
ProEspecialidades.create! :nombre => "Traumatología"
ProEspecialidades.create! :nombre => "Urología"


puts 'Rol Administrativo'
R1 = PreRolAdministrativos.create! :nombre => "Generar agendamientos"
R2 = PreRolAdministrativos.create! :nombre => "Confirmar agendamientos"
R3 = PreRolAdministrativos.create! :nombre => "Recibir pacientes"
R4 = PreRolAdministrativos.create! :nombre => "Bloquear horas"
R5 = PreRolAdministrativos.create! :nombre => "Generar estadísticas"
R6 = PreRolAdministrativos.create! :nombre => "Tomar horas"

puts 'Institución'
I = ProInstituciones.create! :nombre => "Pontificia Universidad Católica de Chile"

puts 'Estados Agendamientos'
AgAgendamientoEstados.create! :nombre => "Hora disponible" #Estado inicial cuando un Dr esta disponible en un lugar para ciertas horas
AgAgendamientoEstados.create! :nombre => "Hora bloqueada" #Si se marcó como disponible a un Dr pero posteriormente, por X motivo, deja de estar disponible 
AgAgendamientoEstados.create! :nombre => "Hora reservada" #Cuando un paciente toma una hora 
AgAgendamientoEstados.create! :nombre => "Hora confirmada" #La atención se realizó por completo 
AgAgendamientoEstados.create! :nombre => "Paciente en espera" #El paciente ya hizo el pago de bono y está en espera a que lo atiendan 
AgAgendamientoEstados.create! :nombre => "Paciente siendo atendido" #El paciente está siendo atendido  
AgAgendamientoEstados.create! :nombre => "Paciente atendido" #La atención se realizó por completo  
AgAgendamientoEstados.create! :nombre => "Hora cancelada"
AgAgendamientoEstados.create! :nombre => "Paciente no llegó"
AgAgendamientoEstados.create! :nombre => "Hora reabierta"  

puts 'Estados Diagnóstico'
ED1 = MedDiagnosticoEstados.create! :nombre => "Confirmado"
ED2 = MedDiagnosticoEstados.create! :nombre => "Sospecha"
ED3 = MedDiagnosticoEstados.create! :nombre => "Descartado"

puts 'Métricas'
Metr1 = FiMetricas.create! :nombre => "Estatura", :unidad => "centimetros"
Metr2 = FiMetricas.create! :nombre => "Peso", :unidad => "kilogramos"
Metr3 = FiMetricas.create! :nombre => "Presion", :unidad => "mb"
Metr4 = FiMetricas.create! :nombre => "IMC", :unidad => "kilogramos/metros2"

puts 'Tipos Ficha'
TF1=FiFichaTipos.create! :nombre => "Tipo ficha general"
TF2=FiFichaTipos.create! :nombre => "Tipo ficha control infantil"

puts 'Metatipos de Medicamentos'
MedMedicamentosMetatipos.create! :nombre => 'Comprimido'
MedMedicamentosMetatipos.create! :nombre => 'Jarabe'
MedMedicamentosMetatipos.create! :nombre => 'Gotas'
MedMedicamentosMetatipos.create! :nombre => 'Pomadas'
MedMedicamentosMetatipos.create! :nombre => 'Vacunas'

puts 'Tipos de Medicamentos'
MedMedicamentosTipos.create! :unidad => 'comprimidos', :medicamento_metatipo_id => 1
MedMedicamentosTipos.create! :unidad => 'cápsulas', :medicamento_metatipo_id => 1
MedMedicamentosTipos.create! :unidad => 'ml', :medicamento_metatipo_id => 2
MedMedicamentosTipos.create! :unidad => 'gotas',:medicamento_metatipo_id => 3
MedMedicamentosTipos.create! :unidad => 'crema',:medicamento_metatipo_id => 4
MedMedicamentosTipos.create! :unidad => '', :medicamento_metatipo_id => 5

puts 'Laboratorios'
MedLaboratorios.create! :nombre => 'Laboratorio 1'

puts 'Vacunas'
MedVacunas.create! :nombre => 'BCG', :protege_contra => 'Tuberculosis', :tipo => 'pni'
MedVacunas.create! :nombre => 'Pentavalente', :protege_contra => 'Hepatitis B, Difteria, Tétanos, Tos Convulsiva, H. Influenza B', :tipo => 'pni'
MedVacunas.create! :nombre => 'Polio oral', :protege_contra => 'Poliomelitis', :tipo => 'pni'
MedVacunas.create! :nombre => 'Neumocócica conjugada', :protege_contra => 'Enfermedades por Neumococo', :tipo => 'pni'
MedVacunas.create! :nombre => 'Antimeningocócica', :protege_contra => 'Enfermedad Meningocócica', :tipo => 'pni'
MedVacunas.create! :nombre => 'Tres vírica', :protege_contra => 'Sarampión, Rubéola, Paperas', :tipo => 'pni'
MedVacunas.create! :nombre => 'dTp (acelular)', :protege_contra => 'Difteria, Tétanos, Tos convulsiva', :tipo => 'pni'
MedVacunas.create! :nombre => 'VPH', :protege_contra => 'Infección Virus Papiloma Humano', :tipo => 'pni'
MedVacunas.create! :nombre => 'Neumocócica Polivalente', :protege_contra => 'Enfermedades por Neumococo', :tipo => 'pni'
MedVacunas.create! :nombre => 'Anti-Influenza', :protege_contra => 'Influenza', :tipo => 'Campaña 2014'
MedVacunas.create! :nombre => 'dT', :protege_contra => 'Difteria, Tétanos', :tipo => 'Urgencia'
MedVacunas.create! :nombre => 'Antirrabica', :protege_contra => 'Rabia', :tipo => 'Urgencia'
MedVacunas.create! :nombre => 'Contra Hepatitis A', :protege_contra => 'Hepatitis A', :tipo => 'Según Epidemiología'
MedVacunas.create! :nombre => 'Contra Hepatitis B', :protege_contra => 'Hepatitis B', :tipo => 'Según Grupos Específicos'
MedVacunas.create! :nombre => 'Anti-Influenza', :protege_contra => 'Influenza', :tipo => 'Campaña 2015'

puts 'Medicamentos'
MedMedicamentos.create! :nombre => 'Medicamentos en comprimidos', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 1, :cantidad => 12, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en cápsulas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 2, :cantidad => 20, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en jarabe', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 3, :cantidad => 100, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en gotas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 4, :cantidad => 50, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en crema', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 5, :cantidad => 50, :laboratorio_id => 1

puts 'Calendario Vacunas 2014'
FiCalendarioVacunas.create! :edad => 'Recién nacido', :agno => 2014, :vacuna_id => 1
FiCalendarioVacunas.create! :edad => '2 meses', :agno => 2014, :vacuna_id => 2, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '2 meses', :agno => 2014, :vacuna_id => 3, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '2 meses', :agno => 2014, :vacuna_id => 4, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '4 meses', :agno => 2014, :vacuna_id => 2, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '4 meses', :agno => 2014, :vacuna_id => 3, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '4 meses', :agno => 2014, :vacuna_id => 4, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '6 meses', :agno => 2014, :vacuna_id => 2, :numero_vacuna => 3
FiCalendarioVacunas.create! :edad => '6 meses', :agno => 2014, :vacuna_id => 3, :numero_vacuna => 3
FiCalendarioVacunas.create! :edad => '12 meses', :agno => 2014, :vacuna_id =>	5
FiCalendarioVacunas.create! :edad => '12 meses', :agno => 2014, :vacuna_id => 6, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '12 meses', :agno => 2014, :vacuna_id =>	4, :numero_vacuna => 3
FiCalendarioVacunas.create! :edad => '18 meses', :agno => 2014, :vacuna_id =>	2, :numero_vacuna => 4
FiCalendarioVacunas.create! :edad => '18 meses', :agno => 2014, :vacuna_id =>	3, :numero_vacuna => 4
FiCalendarioVacunas.create! :edad => '1° básico', :agno => 2014, :vacuna_id =>	6, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '1° básico', :agno => 2014, :vacuna_id =>	7, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '4° básico', :agno => 2014, :vacuna_id =>	8
FiCalendarioVacunas.create! :edad => '8° básico', :agno => 2014, :vacuna_id => 7, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => 'Adulto de 65 años', :agno => 2014, :vacuna_id => 9

puts 'Componente'
C1 = MedComponentes.create! :id => 1, :nombre => 'Componente 1'
C2 = MedComponentes.create! :id => 2, :nombre => 'Componente 2'

puts 'Medicamentos Componente'
C1 = MedMedicamentosComponentes.create! :id => 1, :medicamento_id => 1, :componente_id => 1, :relacion => 500
C2 = MedMedicamentosComponentes.create! :id => 2, :medicamento_id => 1, :componente_id => 2, :relacion => 60

puts 'Alergias'
MedAlergias.create! :nombre => 'Polvo', :comun => 1
MedAlergias.create! :nombre => 'Polen', :comun => 1
MedAlergias.create! :nombre => 'Latex', :comun => 1
MedAlergias.create! :nombre => 'Picadura de insecto', :comun => 1
MedAlergias.create! :nombre => 'Leche', :comun => 1
MedAlergias.create! :nombre => 'Huevo', :comun => 1
MedAlergias.create! :nombre => 'Pescado', :comun => 1
MedAlergias.create! :nombre => 'Marisco', :comun => 1
MedAlergias.create! :nombre => 'Alimento: maní', :comun => 1
MedAlergias.create! :nombre => 'Alimento: soja', :comun => 1
MedAlergias.create! :nombre => 'Alimento: nueces', :comun => 1
MedAlergias.create! :nombre => 'Alimento: trigo', :comun => 1
MedAlergias.create! :nombre => 'Medicamento: penicilina', :comun => 1
MedAlergias.create! :nombre => 'Medicamento: aspirina', :comun => 1
MedAlergias.create! :nombre => 'Medicamento: ibuprofeno', :comun => 1
MedAlergias.create! :nombre => 'Medicamento: anestesia', :comun => 1