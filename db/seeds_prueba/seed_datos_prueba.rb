puts 'Direcciones'
Te1 = TraTelefonos.create! :codigo => 2, :numero => 22222222 
Te2 = TraTelefonos.create! :codigo => 9, :numero => 22222222 
Di1 = TraDirecciones.create! :calle => "Calle", :numero => 1111, :comuna => TraCo1, :ciudad => TraCi1, :pais => P46
Di2 = TraDirecciones.create! :calle => "Calle2", :numero => 3333, :comuna => TraCo1, :ciudad => TraCi1, :pais => P46

#Users
puts 'Users'
U1 = User.create! :email => 'paciente1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U2 = User.create! :email => 'paciente2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U3 = User.create! :email => 'paciente3@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U4 = User.create! :email => 'doctor1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U5 = User.create! :email => 'doctor2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U6 = User.create! :email => 'doctor3@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U7 = User.create! :email => 'doctor4@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U8 = User.create! :email => 'secre1@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U9 = User.create! :email => 'secre2@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U10 = User.create! :email => 'paciente4@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
U11 = User.create! :email => 'paciente5@gmail.com', :password => 'alex1234', :password_confirmation => 'alex1234' , :confirmed_at => '2015-03-31'
 
#Pacientes
puts 'Pacientes'
P1 = PerPersonas.create! :rut => 10000000, :digito_verificador => 'K', :nombre => 'Alex', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Masculino', :fecha_nacimiento => '1984-10-23', :fecha_muerte => '2100-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U1, :pais_nacionalidad => P46 
P2 = PerPersonas.create! :rut => 20000000, :digito_verificador => '5', :nombre => 'Camila', :apellido_paterno => 'González', :apellido_materno => 'Aravena', :genero=> 'Femenino', :fecha_nacimiento => '2012-05-28', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U2, :pais_nacionalidad => P46 
P3 = PerPersonas.create! :rut => 30000000, :digito_verificador => '2', :nombre => 'Fernando', :apellido_paterno => 'González', :apellido_materno => 'Salazar', :genero=> 'Masculino', :fecha_nacimiento => '1960-10-23', :fecha_muerte => '2100-10-22', :diagnostico_muerte => MedDiagnosticos.find(26), :user => U3, :pais_nacionalidad => P46 

#Profesionales
puts 'Doctores'
D1 = PerPersonas.create! :rut => 40000000, :digito_verificador => '2', :nombre => 'Luis', :apellido_paterno => 'Contreras', :apellido_materno => 'Aravena', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U4, :pais_nacionalidad => P46 
D2 = PerPersonas.create! :rut => 50000000, :digito_verificador => '2', :nombre => 'Marcela', :apellido_paterno => 'Cardemil', :apellido_materno => 'Lobos', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U5, :pais_nacionalidad => P46 
D3 = PerPersonas.create! :rut => 60000000, :digito_verificador => '2', :nombre => 'Esteban', :apellido_paterno => 'López', :apellido_materno => 'Pérez', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U6, :pais_nacionalidad => P46 
D4 = PerPersonas.create! :rut => 70000000, :digito_verificador => '2', :nombre => 'Alex', :apellido_paterno => 'Lagos', :apellido_materno => 'Lagos', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25),:user => U7, :pais_nacionalidad => P46 

#Administrativo
puts 'Secretarias'
A = PerPersonas.create! :rut => 80000000, :digito_verificador => '2', :nombre => 'Maricela', :apellido_paterno => 'Santibañez', :apellido_materno => 'Santibañez', :genero=> 'Femenino', :fecha_nacimiento => '1984-07-23', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U8, :pais_nacionalidad => P46 
B = PerPersonas.create! :rut => 90000000, :digito_verificador => '2', :nombre => 'Fernanda', :apellido_paterno => 'González', :apellido_materno => 'González', :genero=> 'Femenino', :fecha_nacimiento => '1993-01-27', :fecha_muerte => '2200-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U9, :pais_nacionalidad => P46 

P4 = PerPersonas.create! :rut => 44000000, :digito_verificador => '2', :nombre => 'Andrea', :apellido_paterno => 'Aravena', :apellido_materno => 'Marín', :genero=> 'Femenino', :fecha_nacimiento => '1985-12-03', :fecha_muerte => '2101-10-22', :diagnostico_muerte => MedDiagnosticos.find(27), :user => U10, :pais_nacionalidad => P46 
P5 = PerPersonas.create! :rut => 55000000, :digito_verificador => '2', :nombre => 'María', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Femenino', :fecha_nacimiento => '1952-01-10', :fecha_muerte => '2101-10-22', :diagnostico_muerte => MedDiagnosticos.find(28), :user => U11, :pais_nacionalidad => P46 

puts 'Parentesco'
#PerParentescos.create! :hijo => P2, :progenitor => P1
#PerParentescos.create! :hijo => P2, :progenitor => P4
#PerParentescos.create! :hijo => P1, :progenitor => P3
#PerParentescos.create! :hijo => P1, :progenitor => P5
#PerParentescos.create! :hijo => B, :progenitor => P3
#PerParentescos.create! :hijo => B, :progenitor => P5

puts 'Personas-telefono'
PerPersonasTelefonos.create! :persona => P1, :telefono => Te1
PerPersonasTelefonos.create! :persona => P1, :telefono => Te2
PerPersonasTelefonos.create! :persona => P2, :telefono => Te1
PerPersonasTelefonos.create! :persona => P2, :telefono => Te2
PerPersonasTelefonos.create! :persona => P3, :telefono => Te1
PerPersonasTelefonos.create! :persona => P3, :telefono => Te2
PerPersonasTelefonos.create! :persona => D1, :telefono => Te1
PerPersonasTelefonos.create! :persona => D1, :telefono => Te2
PerPersonasTelefonos.create! :persona => D2, :telefono => Te1
PerPersonasTelefonos.create! :persona => D2, :telefono => Te2
PerPersonasTelefonos.create! :persona => D3, :telefono => Te1
PerPersonasTelefonos.create! :persona => D3, :telefono => Te2
PerPersonasTelefonos.create! :persona => D4, :telefono => Te1
PerPersonasTelefonos.create! :persona => D4, :telefono => Te2
PerPersonasTelefonos.create! :persona => A, :telefono => Te1
PerPersonasTelefonos.create! :persona => A, :telefono => Te2
PerPersonasTelefonos.create! :persona => B, :telefono => Te1
PerPersonasTelefonos.create! :persona => B, :telefono => Te2

puts 'Personas-direcciones'
PerPersonasDirecciones.create! :persona => P1, :direccion => Di1
PerPersonasDirecciones.create! :persona => P2, :direccion => Di1
PerPersonasDirecciones.create! :persona => P3, :direccion => Di1
PerPersonasDirecciones.create! :persona => D1, :direccion => Di1
PerPersonasDirecciones.create! :persona => D2, :direccion => Di1
PerPersonasDirecciones.create! :persona => D3, :direccion => Di1
PerPersonasDirecciones.create! :persona => D4, :direccion => Di1
PerPersonasDirecciones.create! :persona => A, :direccion => Di1
PerPersonasDirecciones.create! :persona => B, :direccion => Di1

puts 'Previsiones de Salud'
PPS1 = PerPrevisionesSalud.create! :nombre => 'Fonasa'
PPS2 = PerPrevisionesSalud.create! :nombre => 'Isapre 1'
PPS3 = PerPrevisionesSalud.create! :nombre => 'Isapre 2'
PPS4 = PerPrevisionesSalud.create! :nombre => 'Sin información'

puts 'Personas - Previsiones de Salud'
PerPersonasPrevisionesSalud.create! :persona => P1, :prevision_salud => PPS1, :fecha_inicio => '2013-01-01', :fecha_termino => '2013-12-31'
PerPersonasPrevisionesSalud.create! :persona => P1, :prevision_salud => PPS2, :fecha_inicio => '2014-01-01'
PerPersonasPrevisionesSalud.create! :persona => P2, :prevision_salud => PPS2
PerPersonasPrevisionesSalud.create! :persona => P3, :prevision_salud => PPS3

#Prestador (Clinica)
puts 'Prestador 1'
C1=PrePrestadores.new
C1.nombre= "Centro Médico 1"
C1.rut=109000000
C1.es_centinela = true
C1.save

puts 'Prestador 2'
C2=PrePrestadores.new
C2.nombre= "Centro Médico 2"
C2.rut=109000001
C2.es_centinela = false
C2.save

puts 'Prestador - Direcciones '
PrePrestadoresDirecciones.create! :prestador => C1, :direccion => Di2
PrePrestadoresDirecciones.create! :prestador => C2, :direccion => Di2

puts 'Prestador - Telefonos '
PrePrestadoresTelefonos.create! :prestador => C1, :telefono => Te1
PrePrestadoresTelefonos.create! :prestador => C2, :telefono => Te2

puts 'Relación Prestador - Administrativo'
PrePrestadorAdministrativos.create! :prestador=> C1, :administrativo => A, :rol_administrativo => R1
PrePrestadorAdministrativos.create! :prestador=> C1, :administrativo => A, :rol_administrativo => R2
PrePrestadorAdministrativos.create! :prestador=> C1, :administrativo => A, :rol_administrativo => R3
PrePrestadorAdministrativos.create! :prestador=> C1, :administrativo => A, :rol_administrativo => R4
PrePrestadorAdministrativos.create! :prestador=> C1, :administrativo => A, :rol_administrativo => R5
PrePrestadorAdministrativos.create! :prestador=> C1, :administrativo => A, :rol_administrativo => R6
PrePrestadorAdministrativos.create! :prestador=> C2, :administrativo => B, :rol_administrativo => R1
PrePrestadorAdministrativos.create! :prestador=> C2, :administrativo => B, :rol_administrativo => R3

#Profesionales
puts 'Relación Persona-Profesión'
ProProfesionales.create! :validado => true, :profesional => D1, :especialidad => E1, :institucion => I
ProProfesionales.create! :validado => true, :profesional => D2, :especialidad => E2, :institucion => I
ProProfesionales.create! :validado => true, :profesional => D3, :especialidad => E3, :institucion => I
ProProfesionales.create! :validado => true, :profesional => D4, :especialidad => E3, :institucion => I

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
PP5=PrePrestadorProfesionales.new
PP5.prestador=C2
PP5.profesional=D2
PP5.especialidad=E2
PP5.save

PP6=PrePrestadorProfesionales.new
PP6.prestador=C2
PP6.profesional=D3
PP6.especialidad=E3
PP6.save

PreReglaPagos.create! :tipo => 'prestador', :prestador => C1, :porcentaje => 0.3 , :fecha_inicio => '2014-01-01', :especialidad_prestador_profesional => PP1
PreReglaPagos.create! :tipo => 'profesional', :especialidad_prestador_profesional => PP1 , :porcentaje => 0.4, :fecha_inicio => '2014-01-01', :prestador => C1  
PreReglaPagos.create! :tipo => 'prestador', :prestador => C2, :porcentaje => 0.4 , :fecha_inicio => '2014-01-01', :especialidad_prestador_profesional => PP1
