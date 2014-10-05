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
U1= User.create! :email => 'paciente1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U2= User.create! :email => 'paciente2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U3= User.create! :email => 'paciente3@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U4= User.create! :email => 'doctor1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U5= User.create! :email => 'doctor2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U6= User.create! :email => 'doctor3@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U7= User.create! :email => 'doctor4@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U8= User.create! :email => 'secre1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'
U9= User.create! :email => 'secre2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'

#Pacientes
puts 'Pacientes'
P1 = PerPersonas.create! :rut => 10000000, :digito_verificador => 'K', :nombre => 'Alex', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Masculino', :fecha_nacimiento => '1984-10-23', :user => U1
P2 = PerPersonas.create! :rut => 20000000, :digito_verificador => '5', :nombre => 'Camila', :apellido_paterno => 'González', :apellido_materno => 'Aravena', :genero=> 'Femenino', :fecha_nacimiento => '2012-06-28', :user => U2
P3 = PerPersonas.create! :rut => 30000000, :digito_verificador => '2', :nombre => 'Luis', :apellido_paterno => 'González', :apellido_materno => 'Salazar', :genero=> 'Masculino', :fecha_nacimiento => '1934-10-23', :user => U3

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

puts 'GruposPrestaciones'
G1 = MedPrestacionesGrupos.create! :id => 3 , :nombre => 'EXAMENES DE LABORATORIO', :descripcion => ''
G2 = MedPrestacionesGrupos.create! :id => 4 , :nombre => 'IMAGENOLOGIA', :descripcion => ''
G3 = MedPrestacionesGrupos.create! :id => 5 , :nombre => 'MEDICINA NUCLEAR Y RADIOTERAPIA', :descripcion => ''
G4 = MedPrestacionesGrupos.create! :id => 7 , :nombre => 'MEDICINA TRANSFUSIONAL', :descripcion => 'Transfusión de hemocomponentes. Cobro de acto transfusional por cada 4 unidades de glóbulos rojos o plasma, y por cada 6 unidades de crioprecipitados o plaquetas. Incluye el tratamiento de las complicaciones medicas inmediatas. No incluye preparación de hemocomponentes ni estudios previos, salvo que el procedimiento transfusional así lo explicite.'
G5 = MedPrestacionesGrupos.create! :id => 8 , :nombre => 'ANATOMIA PATOLOGICA', :descripcion => ''
G6 = MedPrestacionesGrupos.create! :id => 9 , :nombre => 'PSIQUIATRIA Y SALUD MENTAL', :descripcion => ''
G7 = MedPrestacionesGrupos.create! :id => 11 , :nombre => 'NEUROLOGIA Y NEUROCIRUGIA', :descripcion => ''
G8 = MedPrestacionesGrupos.create! :id => 12 , :nombre => 'CIRUGIA OFTALMOLOGICA', :descripcion => 'Además, véase Cirugía Plástica y Reparadora, y Cirugía de Cabeza y Cuello. Todas las intervenciones se refieren a un ojo y sus anexos, salvo que se especifique otra cosa.'
G9 = MedPrestacionesGrupos.create! :id => 13 , :nombre => 'CIRUGIA OTORRINOLARINGOLOGICA', :descripcion => 'En los casos de realización de técnicas endoscópicas y en ausencia de códigos para ellos, se aplicarán los correspondientes a las técnicas convencionales. Para el código adicional se aplicará en estos casos, el correspondiente a la intervención convencional aumentado en dos dígitos. Véase, además, Cirugía Plástica y Reparadora y Cirugía de Cabeza y Cuello. Todas las intervenciones sobre el oído se refieren a un lado.'
G10 = MedPrestacionesGrupos.create! :id => 14 , :nombre => 'CIRUGIA DE CABEZA Y CUELLO', :descripcion => 'Además, véase intervenciones quirúrgicas de Oftalmología, Otorrinolaringología y Cirugía Plástica y Reparadora.'
G11 = MedPrestacionesGrupos.create! :id => 15 , :nombre => 'CIRUGIA PLASTICA Y REPARADORA', :descripcion => ''
G12 = MedPrestacionesGrupos.create! :id => 16 , :nombre => 'DERMATOLOGIA Y TEGUMENTOS', :descripcion => 'CIRUGIAS. En sala de procedimientos o pabellón quirúrgico.'
G13 = MedPrestacionesGrupos.create! :id => 17 , :nombre => 'CARDIOLOGIA', :descripcion => ''
G14 = MedPrestacionesGrupos.create! :id => 18 , :nombre => 'GASTROENTEROLOGIA', :descripcion => ''
G15 = MedPrestacionesGrupos.create! :id => 19 , :nombre => 'UROLOGIA Y NEFROLOGIA', :descripcion => ''
G16 = MedPrestacionesGrupos.create! :id => 20 , :nombre => 'GINECOLOGIA Y OBSTETRICIA', :descripcion => ''
G17 = MedPrestacionesGrupos.create! :id => 21 , :nombre => 'TRAUMATOLOGIA', :descripcion => ''
G18 = MedPrestacionesGrupos.create! :id => 22 , :nombre => 'ANESTESIA', :descripcion => ''
G19 = MedPrestacionesGrupos.create! :id => 24 , :nombre => 'RESCATES, TRASLADOS Y RONDAS RURALES', :descripcion => ''
G20 = MedPrestacionesGrupos.create! :id => 25 , :nombre => 'PAGO ASOCIADO A DIAGNOSTICO (PAD)', :descripcion => ''
G21 = MedPrestacionesGrupos.create! :id => 27 , :nombre => 'ATENCION ODONTOLOGICA', :descripcion => 'Incluye el valor del derecho a pabellón cuando corresponde'
G22 = MedPrestacionesGrupos.create! :id => 30 , :nombre => 'GRUPO DE PRESTACIONES: lentes, audífonos, PNDA y TBC.', :descripcion => ''

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

puts 'Medicamentos'
MedMedicamentos.create! :nombre => 'BCG', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Pentavalente', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Polio oral', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Neumocócica conjugada', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Antimeningocócica', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Tres vírica', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'dTp (acelular)', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'VPH', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Neumocócica Polivalente', :medicamento_tipo_id => 6, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en comprimidos', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 1, :cantidad => 12, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en cápsulas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 2, :cantidad => 20, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en jarabe', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 3, :cantidad => 100, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en gotas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 4, :cantidad => 50, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en cápsulas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 5, :cantidad => 50, :laboratorio_id => 1
MedMedicamentos.create! :nombre => 'Medicamentos en cápsulas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 6, :cantidad => 50, :laboratorio_id => 1

puts 'Calendario Vacunas 2014'
FiCalendarioVacunas.create! :edad => 'Recién nacido', :protege_contra => 'Tuberculosis', :agno => 2014, :vacuna_id => 1
FiCalendarioVacunas.create! :edad => '2 meses', :protege_contra => 'Hepatitis B<br/>Difteria, Tétanos, Tos Convulsiva<br/>H. Influenza B', :agno => 2014, :vacuna_id => 2, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '2 meses', :protege_contra => 'Poliomelitis', :agno => 2014, :vacuna_id => 3, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '2 meses', :protege_contra => 'Enfermedades por Neumococo', :agno => 2014, :vacuna_id => 4, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '4 meses', :protege_contra => 'Hepatitis B<br/>Difteria, Tétanos, Tos Convulsiva<br/>H. Influenza B', :agno => 2014, :vacuna_id => 2, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '4 meses', :protege_contra => 'Poliomelitis', :agno => 2014, :vacuna_id => 3, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '4 meses', :protege_contra => 'Enfermedades por Neumococo', :agno => 2014, :vacuna_id => 4, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '6 meses', :protege_contra => 'Hepatitis B<br/>Difteria, Tétanos, Tos Convulsiva<br/>H. Influenza B', :agno => 2014, :vacuna_id => 2, :numero_vacuna => 3
FiCalendarioVacunas.create! :edad => '6 meses', :protege_contra => 'Poliomelitis', :agno => 2014, :vacuna_id => 3, :numero_vacuna => 3
FiCalendarioVacunas.create! :edad => '12 meses', :protege_contra => 'Enfermedad Meningocócica', :agno => 2014, :vacuna_id =>	5
FiCalendarioVacunas.create! :edad => '12 meses', :protege_contra => 'Sarampión, Rubéola, Paperas', :agno => 2014, :vacuna_id => 6, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '12 meses', :protege_contra => 'Enfermedades por Neumococo', :agno => 2014, :vacuna_id =>	4, :numero_vacuna => 3
FiCalendarioVacunas.create! :edad => '18 meses', :protege_contra => 'Hepatitis B<br/>Difteria, Tétanos, Tos Convulsiva<br/>H. Influenza B', :agno => 2014, :vacuna_id =>	2, :numero_vacuna => 4
FiCalendarioVacunas.create! :edad => '18 meses', :protege_contra => 'Poliomelitis', :agno => 2014, :vacuna_id =>	3, :numero_vacuna => 4
FiCalendarioVacunas.create! :edad => '1° básico', :protege_contra => 'Sarampión, Rubéola, Paperas', :agno => 2014, :vacuna_id =>	6, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => '1° básico', :protege_contra => 'Difteria, Tétanos, Tos convulsiva', :agno => 2014, :vacuna_id =>	7, :numero_vacuna => 1
FiCalendarioVacunas.create! :edad => '4° básico', :protege_contra => 'Infección Virus Papiloma Humano', :agno => 2014, :vacuna_id =>	8
FiCalendarioVacunas.create! :edad => '8° básico', :protege_contra => 'Difteria, Tétanos, Tos convulsiva', :agno => 2014, :vacuna_id => 7, :numero_vacuna => 2
FiCalendarioVacunas.create! :edad => 'Adulto de 65 años', :protege_contra => 'Enfermedades por Neumococo', :agno => 2014, :vacuna_id => 9

puts 'Componente'
C1 = MedComponentes.create! :id => 1, :nombre => 'Componente 1'
C2 = MedComponentes.create! :id => 2, :nombre => 'Componente 2'

puts 'Medicamentos Componente'
C1 = MedMedicamentosComponentes.create! :id => 1, :medicamento_id => 1, :componente_id => 1, :relacion => 500
C2 = MedMedicamentosComponentes.create! :id => 2, :medicamento_id => 1, :componente_id => 2, :relacion => 60

puts 'Capítulos'
MedDiagnosticosCapitulos.create! :nombre => 'Ciertas enfermedades infecciosas y parasitarias'
MedDiagnosticosCapitulos.create! :nombre => 'Neoplasias'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades de la sangre y de los organos hematopoyeticos'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades endocrinas, nutricionales y metabolicas'
MedDiagnosticosCapitulos.create! :nombre => 'Trastornos mentales y del comportamiento'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del sistema nervioso'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del ojo y sus anexos'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del oido y de la apofisis mastoides'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del sistema circulatorio'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del sistema respiratorio'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del aparato digestivo'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades de la piel y el tejido subcutaneo'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del sistema osteomuscular y del tejido conectivo'
MedDiagnosticosCapitulos.create! :nombre => 'Enfermedades del aparato genitourinario'
MedDiagnosticosCapitulos.create! :nombre => 'Embarazo, parto y puerperio'
MedDiagnosticosCapitulos.create! :nombre => 'Ciertas afecciones originadas en el periodo perinatal'
MedDiagnosticosCapitulos.create! :nombre => 'Malformaciones congenitas, deformidades y anomalias cromosomicas'
MedDiagnosticosCapitulos.create! :nombre => 'Sintomas, signos y hallazgos anormales clinicos y de laboratorio'
MedDiagnosticosCapitulos.create! :nombre => 'Traumatismos, envenenamientos y algunas otras consecuencias de causa externa'
MedDiagnosticosCapitulos.create! :nombre => 'Causas extremas de morbilidad y de mortalidad'
MedDiagnosticosCapitulos.create! :nombre => 'Factores que influyen en el estado de salud y contacto con los servicios de salud'
MedDiagnosticosCapitulos.create! :nombre => 'Codigos para situaciones especiales'

puts 'Alergias'
MedAlergias.create! :nombre => 'Polvo'
MedAlergias.create! :nombre => 'Polen'


puts 'Fin Seed'


