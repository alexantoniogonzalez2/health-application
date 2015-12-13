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
P1 = PerPersonas.create! :rut => 10000000, :digito_verificador => 'K', :nombre => 'Alex', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Masculino', :fecha_nacimiento => '1984-10-23', :fecha_muerte => '2100-10-23', :diagnostico_muerte => MedDiagnosticos.find(25), :user => U1
P2 = PerPersonas.create! :rut => 20000000, :digito_verificador => '5', :nombre => 'Camila', :apellido_paterno => 'González', :apellido_materno => 'Aravena', :genero=> 'Femenino', :fecha_nacimiento => '2012-05-28', :user => U2
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
B = PerPersonas.create! :rut => 90000000, :digito_verificador => '2', :nombre => 'Fernanda', :apellido_paterno => 'González', :apellido_materno => 'González', :genero=> 'Femenino', :fecha_nacimiento => '1993-01-27', :user => U9

P4 = PerPersonas.create! :rut => 44000000, :digito_verificador => '2', :nombre => 'Andrea', :apellido_paterno => 'Aravena', :apellido_materno => 'Marín', :genero=> 'Femenino', :fecha_nacimiento => '1985-12-03', :fecha_muerte => '2101-10-22', :diagnostico_muerte => MedDiagnosticos.find(27), :user => U10
P5 = PerPersonas.create! :rut => 55000000, :digito_verificador => '2', :nombre => 'María', :apellido_paterno => 'González', :apellido_materno => 'Tobar', :genero=> 'Femenino', :fecha_nacimiento => '1952-01-10', :fecha_muerte => '2101-10-22', :diagnostico_muerte => MedDiagnosticos.find(28), :user => U11

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
PerPrevisionesSalud.create! :nombre => 'Sin información'

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
C1.es_centinela = true
C1.save

puts 'Prestador 2'
C2=PrePrestadores.new
C2.nombre= "Centro Médico 2"
C2.rut=109000001
C2.es_centinela = false
C2.save

puts 'Prestador - Direcciones '
PrePrestadoresDirecciones.create! :prestador_id => 1, :direccion_id => 2
PrePrestadoresDirecciones.create! :prestador_id => 2, :direccion_id => 2

puts 'Prestador - Telefonos '
PrePrestadoresTelefonos.create! :prestador_id => 1, :telefono_id => 1
PrePrestadoresTelefonos.create! :prestador_id => 2, :telefono_id => 2

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

PreReglaPagos.create! :tipo => 'prestador', :prestador => C1, :porcentaje => 0.3 , :fecha_inicio => '2014-01-01'
PreReglaPagos.create! :tipo => 'profesional', :especialidad_prestador_profesional => PP1 , :porcentaje => 0.4, :fecha_inicio => '2014-01-01' 
PreReglaPagos.create! :tipo => 'prestador', :prestador => C2, :porcentaje => 0.4 , :fecha_inicio => '2014-01-01'
