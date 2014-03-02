# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
puts 'Paciente 1'
P1=PerPersonas.new
P1.rut=10000000
P1.nombre="Paciente 1"
P1.apellido_paterno="Gutierrez"
P1.apellido_materno="Gutierrez"
P1.genero="Masculino"
P1.user = U1
P1.save

puts 'Paciente 2'
P2=PerPersonas.new
P2.rut=20000000
P2.nombre="Paciente 2"
P2.apellido_paterno="Hurtado"
P2.apellido_materno="Hurtado"
P2.genero="Masculino"
P2.user = U2
P2.save

puts 'Paciente 3'
P3=PerPersonas.new
P3.rut=30000000
P3.nombre="Paciente 3"
P3.apellido_paterno="Saldivar"
P3.apellido_materno="Saldivar"
P3.genero="Femenino"
P3.user = U3
P3.save

#Profesional (doctor)
puts 'Doctor1'
D1=PerPersonas.new
D1.rut=40000000
D1.nombre="Fabricio"
D1.apellido_paterno="Rio"
D1.apellido_materno="Rio"
D1.genero="Masculino"
D1.user = U4
D1.save

puts 'Doctor2'
D2=PerPersonas.new
D2.rut=4000004
D2.nombre="Marcela"
D2.apellido_paterno="Cardemil"
D2.apellido_materno="Cardemil"
D2.genero="Femenino"
D2.user = U5
D2.save

puts 'Doctor3'
D3=PerPersonas.new
D3.rut=40000040
D3.nombre="Esteban"
D3.apellido_paterno="Lopez"
D3.apellido_materno="Lopez"
D3.genero="Masculino"
D3.user = U6
D3.save

puts 'Doctor4'
D4=PerPersonas.new
D4.rut=40000400
D4.nombre="Alex"
D4.apellido_paterno="Lagos"
D4.apellido_materno="Lagos"
D4.genero="Masculino"
D4.user = U7
D4.save

#Administrativo
puts 'Secretaria'
A=PerPersonas.new
A.rut=50000000
A.nombre="Maricela"
A.apellido_paterno="Santibañez"
A.apellido_materno="Santibañez"
A.genero="Femenino"
A.user = U8
A.save

#Administrativo
puts 'Secretaria'
B=PerPersonas.new
B.rut=60000000
B.nombre="Fernanda"
B.apellido_paterno="González"
B.apellido_materno="González"
B.genero="Femenino"
B.user = U9
B.save

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

#Rol Administrativo
puts 'Rol Administrativo'
R1=PreRolAdministrativos.new
R1.nombre="Genera agendamientos"
R1.save

R2=PreRolAdministrativos.new
R2.nombre="Confirma agendamientos"
R2.save

R3=PreRolAdministrativos.new
R3.nombre="Recibe pacientes"
R3.save

R4=PreRolAdministrativos.new
R4.nombre="Genera estadisticas"
R4.save

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
S1=AgAgendamientoEstados.new
S1.nombre="Hora disponible" #Estado inicial cuando un Dr esta disponible en un lugar para ciertas horas
S1.save

S2=AgAgendamientoEstados.new
S2.nombre="Hora no disponible" #Si se marcó como disponible a un Dr pero posteriormente, por X motivo, deja de estar disponible
S2.save

S3=AgAgendamientoEstados.new
S3.nombre="Hora reservada" #Cuando un paciente toma una hora
S3.save

S4=AgAgendamientoEstados.new
S4.nombre="Hora confirmada" #La atención se realizó por completo
S4.save

S5=AgAgendamientoEstados.new
S5.nombre="Paciente en espera" #El paciente ya hizo el pago de bono y está en espera a que lo atiendan
S5.save

S6=AgAgendamientoEstados.new
S6.nombre="Paciente siendo atendido" #El paciente está siendo atendido 
S6.save

S7=AgAgendamientoEstados.new
S7.nombre="Paciente atendido" #La atención se realizó por completo
S7.save

puts 'Agendamientos'
U1= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,24,10,0),
														:fecha_final => DateTime.new(2014,3,24,10,30),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4

U2= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,24,10,30),
														:fecha_final => DateTime.new(2014,3,24,11,00),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4

U3= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,24,11,00),
														:fecha_final => DateTime.new(2014,3,24,11,30),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4	

U4= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,24,11,30),
														:fecha_final => DateTime.new(2014,3,24,12,00),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4	

U5= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,10,0),
														:fecha_final => DateTime.new(2014,3,25,10,30),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4

U6= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,10,30),
														:fecha_final => DateTime.new(2014,3,25,11,00),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4

U7= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,11,00),
														:fecha_final => DateTime.new(2014,3,25,11,30),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4	

U8= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,11,30),
														:fecha_final => DateTime.new(2014,3,25,12,00),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP4

U9= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,10,0),
														:fecha_final => DateTime.new(2014,3,25,10,30),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP1

U10= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,10,30),
														:fecha_final => DateTime.new(2014,3,25,11,00),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP1

U11= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,11,00),
														:fecha_final => DateTime.new(2014,3,25,11,30),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP1	

U12= AgAgendamientos.create! :fecha_comienzo => DateTime.new(2014,3,25,11,30),
														:fecha_final => DateTime.new(2014,3,25,12,00),
														:admin_genera => A,
														:agendamiento_estado => S1,
														:especialidad_prestador_profesional => PP1																																																						

puts 'Examenes'
#Examen
Ex1=MedExamenes.new
Ex1.nombre="Examen1"
Ex1.descripcion="Desc examen 1"
Ex1.indicaciones="Indicaciones 1"
Ex1.codigo_isapre="codigo1"
Ex1.save

Ex2=MedExamenes.new
Ex2.nombre="Examen2"
Ex2.descripcion="Desc examen 2"
Ex2.indicaciones="Indicaciones 2"
Ex2.codigo_isapre="codigo2"
Ex2.save

Ex3=MedExamenes.new
Ex3.nombre="Examen3"
Ex3.descripcion="Desc examen 3"
Ex3.indicaciones="Indicaciones 3"
Ex3.codigo_isapre="codigo3"
Ex3.save

Ex4=MedExamenes.new
Ex4.nombre="Examen4"
Ex4.descripcion="Desc examen 4"
Ex4.indicaciones="Indicaciones 4"
Ex4.codigo_isapre="codigo4"
Ex4.save

Ex5=MedExamenes.new
Ex5.nombre="Examen5"
Ex5.descripcion="Desc examen 5"
Ex5.indicaciones="Indicaciones 5"
Ex5.codigo_isapre="codigo5"
Ex5.save

#Diagnostico
D1 = MedDiagnosticos.create! :nombre => 'Colera debido a vibrio cholerae o1, biotipo cholerae', :descripcion => 'descripcion', :codigo_cie10 => 'A000'
D2 = MedDiagnosticos.create! :nombre => 'Colera debido a vibrio cholerae o1, biotipo el tor', :descripcion => 'descripcion', :codigo_cie10 => 'A001'
D3 = MedDiagnosticos.create! :nombre => 'Colera no especificado', :descripcion => 'descripcion', :codigo_cie10 => 'A009'
D4 = MedDiagnosticos.create! :nombre => 'Fiebres tifoidea y paratifoidea', :descripcion => 'descripcion', :codigo_cie10 => 'A01'
D5 = MedDiagnosticos.create! :nombre => 'Fiebre tifoidea', :descripcion => 'descripcion', :codigo_cie10 => 'A010'
D6 = MedDiagnosticos.create! :nombre => 'Fiebre paratifoidea a', :descripcion => 'descripcion', :codigo_cie10 => 'A011'
D7 = MedDiagnosticos.create! :nombre => 'Fiebre paratifoidea b', :descripcion => 'descripcion', :codigo_cie10 => 'A012'
D8 = MedDiagnosticos.create! :nombre => 'Fiebre paratifoidea c', :descripcion => 'descripcion', :codigo_cie10 => 'A013'
D9 = MedDiagnosticos.create! :nombre => 'Fiebre paratifoidea, no especificada', :descripcion => 'descripcion', :codigo_cie10 => 'A014'
D10 = MedDiagnosticos.create! :nombre => 'Otras infecciones debidas a Salmonella', :descripcion => 'descripcion', :codigo_cie10 => 'A02'
D11 = MedDiagnosticos.create! :nombre => 'Enteritis debida a salmonella', :descripcion => 'descripcion', :codigo_cie10 => 'A020'
D12 = MedDiagnosticos.create! :nombre => 'Septicemia debida a salmonella', :descripcion => 'descripcion', :codigo_cie10 => 'A021'
D13 = MedDiagnosticos.create! :nombre => 'Infecciones localizadas debida a salmonella', :descripcion => 'descripcion', :codigo_cie10 => 'A022'
D14 = MedDiagnosticos.create! :nombre => 'Otras infecciones especificadas como debidas a salmonella', :descripcion => 'descripcion', :codigo_cie10 => 'A028'



#Medicamentos
Di1=MedMedicamentos.new
Di1.nombre="Medicamentos1"
Di1.descripcion="Desc med 1"
Di1.principio_activo="principio activo 1"
Di1.codigo="codigo med 1"
Di1.save

Di2=MedMedicamentos.new
Di2.nombre="Medicamentos2"
Di2.descripcion="Desc med 2"
Di2.principio_activo="principio activo 2"
Di2.codigo="codigo med 2"
Di2.save

Di3=MedMedicamentos.new
Di3.nombre="Medicamentos3"
Di3.descripcion="Desc med 3"
Di3.principio_activo="principio activo 3"
Di3.codigo="codigo med 3"
Di3.save

Di4=MedMedicamentos.new
Di4.nombre="Medicamentos4"
Di4.descripcion="Desc med 4"
Di4.principio_activo="principio activo 4"
Di4.codigo="codigo med 4"
Di4.save

Di5=MedMedicamentos.new
Di5.nombre="Medicamentos5"
Di5.descripcion="Desc med 5"
Di5.principio_activo="principio activo 5"
Di5.codigo="codigo med 5"
Di5.save

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
Metr1.unidad="cms"
Metr1.save

Metr2=FiMetricas.new
Metr2.nombre="Peso"
Metr2.unidad="kg"
Metr2.save

Metr3=FiMetricas.new
Metr3.nombre="Presion"
Metr3.unidad="mb"
Metr3.save

#Tipos Ficha
TF1=FiFichaTipos.new
TF1.nombre="Tipo ficha general"
TF1.save

TF2=FiFichaTipos.new
TF2.nombre="Tipo ficha control infantil"
TF2.save

puts 'Fin Seed'


