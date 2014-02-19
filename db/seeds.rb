# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Users 

puts 'User 1'
U1= User.create! :email => 'paciente1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234'


puts 'User 2'
U2=User.new
U2.email = "paciente2@gmail.com"
U2.password = "alex1234"
U2.password_confirmation = "alex1234"
U2.save!

U3=User.new
U3.email = "paciente3@gmail.com"
U3.password = "alex1234"
U3.password_confirmation = "alex1234"
U3.save!

U4=User.new
U4.email = "doctor1@gmail.com"
U4.password = "alex1234"
U4.password_confirmation = "alex1234"
U4.save!

U5=User.new
U5.email = "doctor2@gmail.com"
U5.password = "alex1234"
U5.password_confirmation = "alex1234"
U5.save!

U6=User.new
U6.email = "doctor3@gmail.com"
U6.password = "alex1234"
U6.password_confirmation = "alex1234"
U6.save!

U7=User.new
U7.email = "doctor4@gmail.com"
U7.password = "alex1234"
U7.password_confirmation = "alex1234"
U7.save!

U8=User.new
U8.email = "secre1@gmail.com"
U8.password = "alex1234"
U8.password_confirmation = "alex1234"
U8.save!

U9=User.new
U9.email = "secre2@gmail.com"
U9.password = "alex1234"
U9.password_confirmation = "alex1234"
U9.save!

#Pacientes
puts 'Paciente 1'
P1=PerPersonas.new
P1.rut=10000000
P1.nombre="Juan"
P1.apellido_paterno="Gutierrez"
P1.apellido_materno="Gutierrez"
P1.genero="Masculino"
P1.user = U1
P1.save

puts 'Paciente 2'
P2=PerPersonas.new
P2.rut=20000000
P2.nombre="Jose"
P2.apellido_paterno="Hurtado"
P2.apellido_materno="Hurtado"
P2.genero="Masculino"
P2.user = U2
P2.save

puts 'Paciente 3'
P3=PerPersonas.new
P3.rut=30000000
P3.nombre="Paula"
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
R=PreRolAdministrativos.new
R.nombre="Administrador de agenda"
R.save

R2=PreRolAdministrativos.new
R2.nombre="Administrador de pagos"
R2.save

puts 'Relación Prestador - Administrativo'
PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R
PA.save

PA2=PrePrestadorAdministrativos.new
PA2.prestador=C2
PA2.administrativo=B
PA2.rol_administrativo=R
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
P.profesional=D1
P.especialidad=E2
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

PP2=PrePrestadorProfesionales.new
PP2.prestador=C1
PP2.profesional=D1
PP2.especialidad=E2
PP2.save

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
puts 'Estado Agendamiento 1'
S1=AgAgendamientoEstados.new
S1.nombre="Disponible" #Estado inicial cuando un Dr esta disponible en un lugar para ciertas horas
S1.save

puts 'Estado Agendamiento 2'
S2=AgAgendamientoEstados.new
S2.nombre="No disponible" #Si se marcó como disponible a un Dr pero posteriormente, por X motivo, deja de estar disponible
S2.save

puts 'Estado Agendamiento 3'
S3=AgAgendamientoEstados.new
S3.nombre="Hora reservada" #Cuando un paciente toma una hora
S3.save

puts 'Estado Agendamiento 4'
S4=AgAgendamientoEstados.new
S4.nombre="Paciente en espera" #El paciente ya hizo el pago de bono y está en espera a que lo atiendan
S4.save

puts 'Estado Agendamiento 5'
S5=AgAgendamientoEstados.new
S5.nombre="Paciente atendido" #La atención se realizó por completo
S5.save

=begin puts 'Agendamiento 1'
A1=AgAgendamientos.new
A1.fecha_comienzo=DateTime.new(2014,1,17,17,0) #año,mes,dia,hora,minuto
A1.fecha_final=DateTime.new(2014,1,17,17,30)
A1.especialidad_prestador_profesional=PP1
#A1.profesional=D1
A1.administrativo=A
A1.agendamiento_estado=S1
#A1.prestador=C1
A1.save


puts 'Agendamiento 2'
A2=AgAgendamientos.new
A2.fecha_comienzo=DateTime.new(2014,1,17,17,30)
A2.fecha_final=DateTime.new(2014,1,17,18,0)
A2.especialidad_prestador_profesional=PP2
#A2.profesional=D1
A2.administrativo=A
A2.agendamiento_estado=S2
#A2.prestador=C1
A2.save

puts 'Agendamiento 3'
A3=AgAgendamientos.new
A3.fecha_comienzo=DateTime.new(2014,1,17,18,0)
A3.fecha_final=DateTime.new(2014,1,17,18,30)
A3.especialidad_prestador_profesional=PP3
#A3.profesional=D1
A3.administrativo=A
A3.agendamiento_estado=S3
#A3.prestador=C1
A3.persona=P1
A3.save

puts 'Agendamiento 4'
A4=AgAgendamientos.new
A4.fecha_comienzo=DateTime.new(2014,1,12,12,0)
A4.fecha_final=DateTime.new(2014,1,12,12,30)
A4.especialidad_prestador_profesional=PP4
#A4.profesional=D1
A4.administrativo=A
A4.agendamiento_estado=S4
#A4.prestador=C1
A4.persona=P2
A4.save

puts 'Agendamiento 5'
A5=AgAgendamientos.new
A5.fecha_comienzo=DateTime.new(2014,1,12,11,0)
A5.fecha_final=DateTime.new(2014,1,12,11,30)
A5.especialidad_prestador_profesional=PP5
#A5.profesional=D1
A5.administrativo=A
A5.agendamiento_estado=S5
#A5.prestador=C1
A5.persona=P3
A5.fecha_comienzo_real=DateTime.now
A5.fecha_final_real=DateTime.now + 23.minutes + 15.seconds
A5.save
=end

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
Di1=MedDiagnosticos.new
Di1.nombre="Diagnostico1"
Di1.descripcion="Desc diag 1"
Di1.codigo_cie10="codigo_cie_1"
Di1.save

Di2=MedDiagnosticos.new
Di2.nombre="Diagnostico2"
Di2.descripcion="Desc diag 2"
Di2.codigo_cie10="codigo_cie_2"
Di2.save

Di3=MedDiagnosticos.new
Di3.nombre="Diagnostico3"
Di3.descripcion="Desc diag 3"
Di3.codigo_cie10="codigo_cie_3"
Di3.save

Di4=MedDiagnosticos.new
Di4.nombre="Diagnostico4"
Di4.descripcion="Desc diag 4"
Di4.codigo_cie10="codigo_cie_4"
Di4.save

Di5=MedDiagnosticos.new
Di5.nombre="Diagnostico5"
Di5.descripcion="Desc diag 5"
Di5.codigo_cie10="codigo_cie_5"
Di5.save

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


