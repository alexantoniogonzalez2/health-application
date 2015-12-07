puts 'Prestaciones para atención'
MPG = MedPrestacionesGrupos.create! :nombre => 'Grupo atenciones de salud', :descripcion => ''
MPS = MedPrestacionesSubgrupos.create! :grupo => MPG, :nombre => 'Subgrupo atenciones de salud', :descripcion => ''
MP1 = MedPrestaciones.create! :codigo_fonasa => '00001', :subgrupo => MPS, :nombre => 'Atención de Salud: Medicina General'
MP2 = MedPrestaciones.create! :codigo_fonasa => '00002', :subgrupo => MPS, :nombre => 'Atención de Salud: Pediatría'
MP3 = MedPrestaciones.create! :codigo_fonasa => '00003', :subgrupo => MPS, :nombre => 'Atención de Salud: Cardiología'
MP4 = MedPrestaciones.create! :codigo_fonasa => '00004', :subgrupo => MPS, :nombre => 'Atención de Salud: Broncopulmonar" '
MP5 = MedPrestaciones.create! :codigo_fonasa => '00005', :subgrupo => MPS, :nombre => 'Atención de Salud: Dermatología'
MP6 = MedPrestaciones.create! :codigo_fonasa => '00006', :subgrupo => MPS, :nombre => 'Atención de Salud: Endocrinología'
MP7 = MedPrestaciones.create! :codigo_fonasa => '00007', :subgrupo => MPS, :nombre => 'Atención de Salud: Fonoaudiología'
MP8 = MedPrestaciones.create! :codigo_fonasa => '00008', :subgrupo => MPS, :nombre => 'Atención de Salud: Gastroenterología'
MP9 = MedPrestaciones.create! :codigo_fonasa => '00009', :subgrupo => MPS, :nombre => 'Atención de Salud: Geriatría'
MP10 = MedPrestaciones.create! :codigo_fonasa => '00010', :subgrupo => MPS, :nombre => 'Atención de Salud: Ginecología'
MP11 = MedPrestaciones.create! :codigo_fonasa => '00011', :subgrupo => MPS, :nombre => 'Atención de Salud: Nefrología'
MP12 = MedPrestaciones.create! :codigo_fonasa => '00012', :subgrupo => MPS, :nombre => 'Atención de Salud: Neurología'
MP13 = MedPrestaciones.create! :codigo_fonasa => '00013', :subgrupo => MPS, :nombre => 'Atención de Salud: Nutrición'
MP14 = MedPrestaciones.create! :codigo_fonasa => '00014', :subgrupo => MPS, :nombre => 'Atención de Salud: Odontología'
MP15 = MedPrestaciones.create! :codigo_fonasa => '00015', :subgrupo => MPS, :nombre => 'Atención de Salud: Oftalmología'
MP16 = MedPrestaciones.create! :codigo_fonasa => '00016', :subgrupo => MPS, :nombre => 'Atención de Salud: Oncología'
MP17 = MedPrestaciones.create! :codigo_fonasa => '00017', :subgrupo => MPS, :nombre => 'Atención de Salud: Otorrinolaringología'
MP18 = MedPrestaciones.create! :codigo_fonasa => '00018', :subgrupo => MPS, :nombre => 'Atención de Salud: Psicología'
MP19 = MedPrestaciones.create! :codigo_fonasa => '00019', :subgrupo => MPS, :nombre => 'Atención de Salud: Psiquiatría'
MP20 = MedPrestaciones.create! :codigo_fonasa => '00020', :subgrupo => MPS, :nombre => 'Atención de Salud: Reumatología'
MP21 = MedPrestaciones.create! :codigo_fonasa => '00021', :subgrupo => MPS, :nombre => 'Atención de Salud: Traumatología'
MP22 = MedPrestaciones.create! :codigo_fonasa => '00022', :subgrupo => MPS, :nombre => 'Atención de Salud: Urología'

puts 'Especialidad 1'
E1 = ProEspecialidades.create! :nombre => "Medicina General", :prestacion => MP1
E2 = ProEspecialidades.create! :nombre => "Pediatría", :prestacion => MP2
E3 = ProEspecialidades.create! :nombre => "Cardiología", :prestacion => MP3
ProEspecialidades.create! :nombre => "Broncopulmonar" , :prestacion => MP4
ProEspecialidades.create! :nombre => "Dermatología", :prestacion => MP5
ProEspecialidades.create! :nombre => "Endocrinología", :prestacion => MP6
ProEspecialidades.create! :nombre => "Fonoaudiología", :prestacion => MP7
ProEspecialidades.create! :nombre => "Gastroenterología", :prestacion => MP8
ProEspecialidades.create! :nombre => "Geriatría", :prestacion => MP9
ProEspecialidades.create! :nombre => "Ginecología", :prestacion => MP10
ProEspecialidades.create! :nombre => "Nefrología", :prestacion => MP11
ProEspecialidades.create! :nombre => "Neurología", :prestacion => MP12
ProEspecialidades.create! :nombre => "Nutrición", :prestacion => MP13
ProEspecialidades.create! :nombre => "Odontología", :prestacion => MP14
ProEspecialidades.create! :nombre => "Oftalmología", :prestacion => MP15
ProEspecialidades.create! :nombre => "Oncología", :prestacion => MP16
ProEspecialidades.create! :nombre => "Otorrinolaringología", :prestacion => MP17
ProEspecialidades.create! :nombre => "Psicología", :prestacion => MP18
ProEspecialidades.create! :nombre => "Psiquiatría", :prestacion => MP19
ProEspecialidades.create! :nombre => "Reumatología", :prestacion => MP20
ProEspecialidades.create! :nombre => "Traumatología", :prestacion => MP21
ProEspecialidades.create! :nombre => "Urología", :prestacion => MP22


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
AgAgendamientoEstados.create! :nombre => "Atención reabierta"  

puts 'Estados Diagnóstico'
ED1 = MedDiagnosticoEstados.create! :nombre => "Confirmado"
ED2 = MedDiagnosticoEstados.create! :nombre => "Sospecha"
ED3 = MedDiagnosticoEstados.create! :nombre => "Descartado"

puts 'Métricas'
FiMetricas.create! :nombre => "Estatura", :unidad => "cm"
FiMetricas.create! :nombre => "Peso", :unidad => "kg"
FiMetricas.create! :nombre => "Presión arterial media", :unidad => "mm Hg"
FiMetricas.create! :nombre => "IMC", :unidad => "k/m2"
FiMetricas.create! :nombre => "Frecuencia cardiaca", :unidad => "latidos por minuto"
FiMetricas.create! :nombre => "Frecuencia respiratoria", :unidad => "respiraciones por minuto"
FiMetricas.create! :nombre => "Temperatura", :unidad => "C°"
FiMetricas.create! :nombre => "Saturación", :unidad => "%"
FiMetricas.create! :nombre => "Presión arterial sistólica", :unidad => "mm Hg"
FiMetricas.create! :nombre => "Presión arterial diastólica", :unidad => "mm Hg"

puts 'Tipos Ficha'
TF1=FiFichaTipos.create! :nombre => "Tipo ficha general"
TF2=FiFichaTipos.create! :nombre => "Tipo ficha control infantil"

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
MedComponentes.create! :id => 1, :nombre => 'Componente 1'
MedComponentes.create! :id => 2, :nombre => 'Componente 2'

puts 'Medicamentos Componente'
MedMedicamentosComponentes.create! :id => 1, :medicamento_id => 1, :componente_id => 1, :relacion => 500
MedMedicamentosComponentes.create! :id => 2, :medicamento_id => 1, :componente_id => 2, :relacion => 60

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