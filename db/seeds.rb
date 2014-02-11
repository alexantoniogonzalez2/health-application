# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Pacientes
puts 'Paciente 1'
P1=PerPersonas.new
P1.rut=10000000
P1.nombre="Juan"
P1.apellido_paterno="Subercaseux"
P1.apellido_materno="Gutierrez"
P1.genero="Masculino"
P1.save

puts 'Paciente 2'
P2=PerPersonas.new
P2.rut=20000000
P2.nombre="Jose"
P2.apellido_paterno="Hurtado"
P2.apellido_materno="Perez"
P2.genero="Masculino"
P2.save

puts 'Paciente 3'
P3=PerPersonas.new
P3.rut=30000000
P3.nombre="Amaranta"
P3.apellido_paterno="Saldivar"
P3.apellido_materno="Matthei"
P3.genero="Femenino"
P3.save

#Profesional (doctor)
puts 'Doctor1'
D1=PerPersonas.new
D1.rut=40000000
D1.nombre="Fabricio"
D1.apellido_paterno="Rio"
D1.apellido_materno="Fontecilla"
D1.genero="Masculino"
D1.save

puts 'Doctor2'
D2=PerPersonas.new
D2.rut=4000004
D2.nombre="Marcela"
D2.apellido_paterno="Cardemil"
D2.apellido_materno="Fontecilla"
D2.genero="Femenino"
D2.save

puts 'Doctor3'
D3=PerPersonas.new
D3.rut=40000040
D3.nombre="Esteban"
D3.apellido_paterno="Quito"
D3.apellido_materno="Roto"
D3.genero="Masculino"
D3.save

puts 'Doctor4'
D4=PerPersonas.new
D4.rut=40000400
D4.nombre="Armando"
D4.apellido_paterno="Casas"
D4.apellido_materno="Del Rio"
D4.genero="Masculino"
D4.save

puts 'Doctor5'
D5=PerPersonas.new
D5.rut=40004000
D5.nombre="Susana"
D5.apellido_paterno="Horias"
D5.apellido_materno="Parada"
D5.genero="Femenino"
D5.save

#Administrativo
puts 'Secretaria'
A=PerPersonas.new
A.rut=50000000
A.nombre="Maricela"
A.apellido_paterno="Santibañez"
A.apellido_materno="Buenavida"
A.genero="Femenino"
A.save

#Prestador (Clinica)
puts 'Prestador 1'
C1=PrePrestadores.new
C1.nombre= "CONSALUD Puente Alto"
C1.rut=109000000
C1.save

puts 'Prestador 2'
C2=PrePrestadores.new
C2.nombre= "Clínica Bicentenario"
C2.rut=109000001
C2.save

puts 'Prestador 3'
C3=PrePrestadores.new
C3.nombre= "Hospital Sótero del Río"
C3.rut=109000002
C3.save

puts 'Prestador 4'
C4=PrePrestadores.new
C4.nombre= "Megasalud Salvador"
C4.rut=109000003
C4.save


#Rol Administrativo
puts 'Rol Administrativo'
R=PreRolAdministrativos.new
R.nombre="Secretaria"
R.save

puts 'Relación Prestador - Administrativo'
PA=PrePrestadorAdministrativos.new
PA.prestador=C1
PA.administrativo=A
PA.rol_administrativo=R
PA.save

#Institucion

puts 'Institución'
I=ProInstituciones.new
I.nombre="Pontificia Universidad Católica de Chile"
I.save

#Especialidad

puts 'Especialidad 1'
E1=ProEspecialidades.new
E1.nombre="Ginecología"
E1.save

puts 'Especialidad 2'
E2=ProEspecialidades.new
E2.nombre="Neurología"
E2.save

puts 'Especialidad 3'
E3=ProEspecialidades.new
E3.nombre="Oftalmología"
E3.save

puts 'Especialidad 4'
E4=ProEspecialidades.new
E4.nombre="Pediatría"
E4.save

puts 'Especialidad 5'
E5=ProEspecialidades.new
E5.nombre="Cardiología"
E5.save

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
P.profesional=D1
P.especialidad=E3
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D2
P.especialidad=E4
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D3
P.especialidad=E1
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D4
P.especialidad=E3
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D5
P.especialidad=E5
P.institucion=I
P.save

P=ProProfesionales.new
P.validado = true
P.profesional=D5
P.especialidad=E1
P.institucion=I
P.save

#Prestador-profesional
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
PP3.especialidad=E4
PP3.save

PP4=PrePrestadorProfesionales.new
PP4.prestador=C1
PP4.profesional=D3
PP4.especialidad=E1
PP4.save

PP5=PrePrestadorProfesionales.new
PP5.prestador=C1
PP5.profesional=D4
PP5.especialidad=E3
PP5.save




# Centro 2
PP6=PrePrestadorProfesionales.new
PP6.prestador=C2
PP6.profesional=D1
PP6.especialidad=E1
PP6.save

PP6=PrePrestadorProfesionales.new
PP6.prestador=C2
PP6.profesional=D5
PP6.especialidad=E5
PP6.save

PP7=PrePrestadorProfesionales.new
PP7.prestador=C2
PP7.profesional=D3
PP7.especialidad=E1
PP7.save


#Centro 3

PP8=PrePrestadorProfesionales.new
PP8.prestador=C3
PP8.profesional=D5
PP8.especialidad=E1
PP8.save

PP9=PrePrestadorProfesionales.new
PP9.prestador=C3
PP9.profesional=D5
PP9.especialidad=E5
PP9.save

PP10=PrePrestadorProfesionales.new
PP10.prestador=C3
PP10.profesional=D4
PP10.especialidad=E3
PP10.save

#Centro 4

PP11=PrePrestadorProfesionales.new
PP11.prestador=C4
PP11.profesional=D2
PP11.especialidad=E4
PP11.save

PP12=PrePrestadorProfesionales.new
PP12.prestador=C4
PP12.profesional=D3
PP12.especialidad=E1
PP12.save

PP13=PrePrestadorProfesionales.new
PP13.prestador=C4
PP13.profesional=D4
PP13.especialidad=E3
PP13.save




#Estado agendamiento
puts 'Estado Agendamiento 1'
S1=AgAgendamientoEstados.new
S1.nombre="Disponible" #Estado inicial cuando un Dr esta disponible en un lugar para ciertas horas
S1.save

puts 'Estado Agendamiento 2'
S2=AgAgendamientoEstados.new
S2.nombre="No Disponible" #Si se marcó como disponible a un Dr pero posteriormente, por X motivo, deja de estar disponible
S2.save

puts 'Estado Agendamiento 3'
S3=AgAgendamientoEstados.new
S3.nombre="Hora Reservada" #Cuando un paciente toma una hora
S3.save

puts 'Estado Agendamiento 4'
S4=AgAgendamientoEstados.new
S4.nombre="Cliente En Espera" #El paciente ya hizo el pago de bono y está en espera a que lo atiendan
S4.save

puts 'Estado Agendamiento 5'
S5=AgAgendamientoEstados.new
S5.nombre="Cliente Atendido" #La atención se realizó por completo
S5.save

puts 'Agendamiento 1'
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


