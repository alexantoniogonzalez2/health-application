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
S2.nombre="Hora bloqueada" #Si se marcó como disponible a un Dr pero posteriormente, por X motivo, deja de estar disponible
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

S8=AgAgendamientoEstados.new
S8.nombre="Hora cancelada" 
S8.save

S9=AgAgendamientoEstados.new
S9.nombre="Paciente no llegó" 
S9.save																																																																

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
MTM1 = MedMedicamentosMetatipos.create! :id => 1, :nombre => 'Comprimido'
MTM2 = MedMedicamentosMetatipos.create! :id => 2, :nombre => 'Jarabe'
MTM3 = MedMedicamentosMetatipos.create! :id => 3, :nombre => 'Gotas'
MTM4 = MedMedicamentosMetatipos.create! :id => 4, :nombre => 'Pomadas'

puts 'Tipos de Medicamentos'
TM1 = MedMedicamentosTipos.create! :id => 1, :unidad => 'comprimidos', :medicamento_metatipo_id => 1
TM2 = MedMedicamentosTipos.create! :id => 2, :unidad => 'cápsulas', :medicamento_metatipo_id => 1
TM3 = MedMedicamentosTipos.create! :id => 3, :unidad => 'ml', :medicamento_metatipo_id => 2
TM4 = MedMedicamentosTipos.create! :id => 4, :unidad => 'gotas',:medicamento_metatipo_id => 3
TM5 = MedMedicamentosTipos.create! :id => 5, :unidad => 'crema',:medicamento_metatipo_id => 4

puts 'Laboratorios'
L1 = MedLaboratorios.create! :id => 1, :nombre => 'Laboratorio 1'

puts 'Medicamentos'
M1 = MedMedicamentos.create! :id => 1, :nombre => 'Medicamentos en comprimidos', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 1, :cantidad => 12, :laboratorio_id => 1
M2 = MedMedicamentos.create! :id => 2, :nombre => 'Medicamentos en cápsulas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 2, :cantidad => 20, :laboratorio_id => 1
M3 = MedMedicamentos.create! :id => 3, :nombre => 'Medicamentos en jarabe', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 3, :cantidad => 100, :laboratorio_id => 1
M4 = MedMedicamentos.create! :id => 4, :nombre => 'Medicamentos en gotas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 4, :cantidad => 50, :laboratorio_id => 1
M5 = MedMedicamentos.create! :id => 5, :nombre => 'Medicamentos en cápsulas', :descripcion => 'descripcion', :codigo_isp => 'codigo', :medicamento_tipo_id => 5, :cantidad => 50, :laboratorio_id => 1

puts 'Componente'
C1 = MedComponentes.create! :id => 1, :nombre => 'Componente 1'
C2 = MedComponentes.create! :id => 2, :nombre => 'Componente 2'


puts 'Medicamentos Componente'
C1 = MedMedicamentosComponentes.create! :id => 1, :medicamento_id => 1, :componente_id => 1, :relacion => 500
C2 = MedMedicamentosComponentes.create! :id => 2, :medicamento_id => 1, :componente_id => 2, :relacion => 60

puts 'Fin Seed'


