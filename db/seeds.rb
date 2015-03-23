# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

puts 'Direcciones'
TraRegiones.create! :nombre => "Región Metropolitana"
TraCiudades.create! :nombre => "Santiago"
TraComunas.create! :nombre => "San Miguel"
TraRegionesComunas.create! :region_id => 1, :comuna_id => 1
TraTelefonos.create! :codigo => 2, :numero => 22222222 
TraTelefonos.create! :codigo => 9, :numero => 22222222 
TraDirecciones.create! :calle => "Calle", :numero => 1111, :comuna_id => 1, :ciudad_id => 1, :pais_id => 46
TraDirecciones.create! :calle => "Calle2", :numero => 3333, :comuna_id => 1, :ciudad_id => 1, :pais_id => 46

#Users
puts 'Users'
U1 = User.create! :email => 'paciente1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U2 = User.create! :email => 'paciente2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U3 = User.create! :email => 'paciente3@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U4 = User.create! :email => 'doctor1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U5 = User.create! :email => 'doctor2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U6 = User.create! :email => 'doctor3@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U7 = User.create! :email => 'doctor4@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U8 = User.create! :email => 'secre1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U9 = User.create! :email => 'secre2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U10 = User.create! :email => 'paciente4@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U11 = User.create! :email => 'paciente5@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'

#Pacientes
puts 'Pacientes'
P1 = PerPersonas.create! :rut => 10000000, :digito_verificador => 'K', :nombre => 'Alex', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Masculino', :fecha_nacimiento => '1984-10-23', :fecha_muerte => '2100-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U1
P2 = PerPersonas.create! :rut => 20000000, :digito_verificador => '5', :nombre => 'Camila', :apellido_paterno => 'González', :apellido_materno => 'Aravena', :genero=> 'Femenino', :fecha_nacimiento => '2012-06-28', :user => U2
P3 = PerPersonas.create! :rut => 30000000, :digito_verificador => '2', :nombre => 'Fernando', :apellido_paterno => 'González', :apellido_materno => 'Salazar', :genero=> 'Masculino', :fecha_nacimiento => '1960-10-23', :fecha_muerte => '2100-10-22', :diagnostico_muerte => MedDiagnosticos.find(26), :user => U3

#Profesionales
puts 'Doctores'
D1 = PerPersonas.create! :rut => 40000000, :digito_verificador => '2', :nombre => 'Luis', :apellido_paterno => 'Contreras', :apellido_materno => 'Aravena', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :user => U4
D2 = PerPersonas.create! :rut => 50000000, :digito_verificador => '2', :nombre => 'Marcela', :apellido_paterno => 'Cardemil', :apellido_materno => 'Lobos', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :user => U5
D3 = PerPersonas.create! :rut => 60000000, :digito_verificador => '2', :nombre => 'Esteban', :apellido_paterno => 'López', :apellido_materno => 'Pérez', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :user => U6
D4 = PerPersonas.create! :rut => 70000000, :digito_verificador => '2', :nombre => 'Alex', :apellido_paterno => 'Lagos', :apellido_materno => 'Lagos', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :user => U7

#Administrativo
puts 'Secretarias'
A = PerPersonas.create! :rut => 80000000, :digito_verificador => '2', :nombre => 'Maricela', :apellido_paterno => 'Santibañez', :apellido_materno => 'Santibañez', :genero=> 'Femenino', :fecha_nacimiento => '1984-07-23', :user => U8
B = PerPersonas.create! :rut => 90000000, :digito_verificador => '2', :nombre => 'Fernanda', :apellido_paterno => 'González', :apellido_materno => 'González', :genero=> 'Femenino', :fecha_nacimiento => '1984-07-23', :user => U9

P4 = PerPersonas.create! :rut => 44000000, :digito_verificador => '2', :nombre => 'Andrea', :apellido_paterno => 'Aravena', :apellido_materno => 'Marín', :genero=> 'Femenino', :fecha_nacimiento => '1985-10-23', :fecha_muerte => '2101-10-22', :diagnostico_muerte => MedDiagnosticos.find(27), :user => U10
P5 = PerPersonas.create! :rut => 55000000, :digito_verificador => '2', :nombre => 'María', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Femenino', :fecha_nacimiento => '1952-10-23', :fecha_muerte => '2101-10-22', :diagnostico_muerte => MedDiagnosticos.find(28), :user => U11

puts 'Parentesco'
PerParentescos.create! :hijo => P2, :progenitor => P1
PerParentescos.create! :hijo => P2, :progenitor => P4
PerParentescos.create! :hijo => P1, :progenitor => P3
PerParentescos.create! :hijo => P1, :progenitor => P5
PerParentescos.create! :hijo => B, :progenitor => P3
PerParentescos.create! :hijo => B, :progenitor => P5


puts 'Personas-telefono'
PerPersonasTelefonos.create! :persona_id => 1, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 1, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 2, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 2, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 3, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 3, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 4, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 4, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 5, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 5, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 6, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 6, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 7, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 7, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 8, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 8, :telefono_id => 2
PerPersonasTelefonos.create! :persona_id => 9, :telefono_id => 1
PerPersonasTelefonos.create! :persona_id => 9, :telefono_id => 2

puts 'Personas-direcciones'
PerPersonasDirecciones.create! :persona_id => 1, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 2, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 3, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 4, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 5, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 6, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 7, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 8, :direccion_id => 1
PerPersonasDirecciones.create! :persona_id => 9, :direccion_id => 1

puts 'Previsiones de Salud'
PerPrevisionesSalud.create! :nombre => 'Fonasa'
PerPrevisionesSalud.create! :nombre => 'Isapre 1'
PerPrevisionesSalud.create! :nombre => 'Isapre 2'

puts 'Personas - Previsiones de Salud'
PerPersonasPrevisionesSalud.create! :persona_id => 1, :prevision_salud_id => 1, :fecha_inicio => '2013-01-01', :fecha_termino => '2013-12-31'
PerPersonasPrevisionesSalud.create! :persona_id => 1, :prevision_salud_id => 2, :fecha_inicio => '2014-01-01'
PerPersonasPrevisionesSalud.create! :persona_id => 2, :prevision_salud_id => 2
PerPersonasPrevisionesSalud.create! :persona_id => 3, :prevision_salud_id => 3

#Prestador (Clinica)
puts 'Prestador 1'
C1=PrePrestadores.new
C1.nombre= "Centro Médico 1"
C1.rut=109000000
C1.save

puts 'Prestador 2'
C2=PrePrestadores.new
C2.nombre= "Centro Médico 2"
C2.rut=109000001
C2.save

puts 'Prestador - Direcciones '
PrePrestadoresDirecciones.create! :prestador_id => 1, :direccion_id => 2
PrePrestadoresDirecciones.create! :prestador_id => 2, :direccion_id => 2

puts 'Prestador - Telefonos '
PrePrestadoresTelefonos.create! :prestador_id => 1, :telefono_id => 1
PrePrestadoresTelefonos.create! :prestador_id => 2, :telefono_id => 2

#Rol Administrativo
puts 'Rol Administrativo'
R1=PreRolAdministrativos.new
R1.nombre="Generar agendamientos"
R1.save

R2=PreRolAdministrativos.new
R2.nombre="Confirmar agendamientos"
R2.save

R3=PreRolAdministrativos.new
R3.nombre="Recibir pacientes"
R3.save

R4=PreRolAdministrativos.new
R4.nombre="Bloquear horas"
R4.save

R5=PreRolAdministrativos.new
R5.nombre="Generar estadísticas"
R5.save

R6=PreRolAdministrativos.new
R6.nombre="Tomar horas"
R6.save

puts 'Relación Prestador - Administrativo'
PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R1
PA.save

PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R2
PA.save

PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R3
PA.save

PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R4
PA.save

PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R6
PA.save

PA2=PrePrestadorAdministrativos.new
PA2.prestador=C2
PA2.administrativo=B
PA2.rol_administrativo=R1
PA2.save

#Institucion

puts 'Institución'
I=ProInstituciones.new
I.nombre="Pontificia Universidad Católica de Chile"
I.save

#Especialidad
puts 'Especialidad 1'
E1=ProEspecialidades.new
E1.nombre="Medicina General"
E1.save

puts 'Especialidad 2'
E2=ProEspecialidades.new
E2.nombre="Pediatría"
E2.save

puts 'Especialidad 3'
E3=ProEspecialidades.new
E3.nombre="Cardiología"
E3.save

#Profesionales
puts 'Relación Persona-Profesión'
P=ProProfesionales.new
P.validado = true
P.profesional=D1
P.especialidad=E1
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D2
P.especialidad=E2
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D3
P.especialidad=E3
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D4
P.especialidad=E3
P.institucion=I
P.save

# Centro 1
puts 'Relación Prestador-Profesional'
PP1=PrePrestadorProfesionales.new
PP1.prestador=C1
PP1.profesional=D1
PP1.especialidad=E1
PP1.save

PP3=PrePrestadorProfesionales.new
PP3.prestador=C1
PP3.profesional=D2
PP3.especialidad=E2
PP3.save

PP4=PrePrestadorProfesionales.new
PP4.prestador=C1
PP4.profesional=D4
PP4.especialidad=E3
PP4.save

# Centro 2
PP6=PrePrestadorProfesionales.new
PP6.prestador=C2
PP6.profesional=D2
PP6.especialidad=E2
PP6.save

PP6=PrePrestadorProfesionales.new
PP6.prestador=C2
PP6.profesional=D3
PP6.especialidad=E3
PP6.save

#Estado agendamiento
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

#Estados Diagnóstico
ED1=MedDiagnosticoEstados.new
ED1.nombre="Confirmado"
ED1.save

ED2=MedDiagnosticoEstados.new
ED2.nombre="Sospecha"
ED2.save

ED3=MedDiagnosticoEstados.new
ED3.nombre="Descartado"
ED3.save

#Métricas
Metr1=FiMetricas.new
Metr1.nombre="Estatura"
Metr1.unidad="centimetros"
Metr1.save

Metr2=FiMetricas.new
Metr2.nombre="Peso"
Metr2.unidad="kilogramos"
Metr2.save

Metr3=FiMetricas.new
Metr3.nombre="Presion"
Metr3.unidad="mb"
Metr3.save

Metr4=FiMetricas.new
Metr4.nombre="IMC"
Metr4.unidad="kilogramos/metros2"
Metr4.save

#Tipos Ficha
TF1=FiFichaTipos.new
TF1.nombre="Tipo ficha general"
TF1.save

TF2=FiFichaTipos.new
TF2.nombre="Tipo ficha control infantil"
TF2.save

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
MedVacunas.create! :nombre => 'Anti-Influenza', :protege_contra => 'Influenza', :tipo => 'Campaña'
MedVacunas.create! :nombre => 'dT', :protege_contra => 'Difteria, Tétanos', :tipo => 'Urgencia'
MedVacunas.create! :nombre => 'Antirrabica', :protege_contra => 'Rabia', :tipo => 'Urgencia'
MedVacunas.create! :nombre => 'Contra Hepatitis A', :protege_contra => 'Hepatitis A', :tipo => 'Según Epidemiología'
MedVacunas.create! :nombre => 'Contra Hepatitis B', :protege_contra => 'Hepatitis B', :tipo => 'Según Grupos Específicos'

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

Rake::Task['agendamiento:crear_agendamientos'].invoke

puts 'Fin Seed'


