puts 'Direcciones'
Tel1 = TraTelefonos.create! :codigo => 2, :numero => 25530432
Tel2 = TraTelefonos.create! :codigo => 9, :numero => 27894546
Dir1 = TraDirecciones.create! :calle => "Avenida Vecinal", :numero => 4745, :comuna_id => 2, :ciudad_id => 1, :pais_id => 46
Dir2 = TraDirecciones.create! :calle => "Calle2", :numero => 3333, :comuna_id => 1, :ciudad_id => 1, :pais_id => 46

#Users
puts 'Users'
UD1 = User.create! :email => 'paciente_dental@gmail.com', :password => '123456', :password_confirmation => '123456' , :confirmed_at => '2015-03-31'
UD2 = User.create! :email => 'dental1@gmail.com', :password => '123456', :password_confirmation => '123456' , :confirmed_at => '2015-03-31'
UD3 = User.create! :email => 'dental2@gmail.com', :password => '123456', :password_confirmation => '123456' , :confirmed_at => '2015-03-31'
UD4 = User.create! :email => 'administrativo_dental@gmail.com', :password => '123456', :password_confirmation => '123456' , :confirmed_at => '2015-03-31'

#Pacientes
puts 'Pacientes'
PD1 = PerPersonas.create! :rut => 10000000, :digito_verificador => 'K', :nombre => 'Juan José', :apellido_paterno => 'Zamur', :apellido_materno => 'Zamur', :genero=> 'Masculino', :fecha_nacimiento => '1984-10-23', :user => UD1

#Profesionales
puts 'Doctores'
DD1 = PerPersonas.create! :rut => 40000000, :digito_verificador => '2', :nombre => 'Óscar', :apellido_paterno => 'Lagos', :apellido_materno => 'Yañez', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :user => UD2
DD2 = PerPersonas.create! :rut => 50000000, :digito_verificador => '2', :nombre => 'Marcela', :apellido_paterno => 'Dubó', :apellido_materno => 'Lobos', :genero=> 'Masculino', :fecha_nacimiento => '1984-07-23', :user => UD3

#Administrativo
puts 'Secretarias'
SD = PerPersonas.create! :rut => 80000000, :digito_verificador => '2', :nombre => 'Bernarda', :apellido_paterno => 'Santibañez', :apellido_materno => 'Santibañez', :genero=> 'Femenino', :fecha_nacimiento => '1984-07-23', :user => UD4


puts 'Personas-telefono'
PerPersonasTelefonos.create! :persona => PD1, :telefono => Tel1
PerPersonasTelefonos.create! :persona => DD1, :telefono => Tel1
PerPersonasTelefonos.create! :persona => DD2, :telefono => Tel1
PerPersonasTelefonos.create! :persona => SD, :telefono => Tel1

puts 'Personas-direcciones'
PerPersonasDirecciones.create! :persona => PD1, :direccion => Dir1
PerPersonasDirecciones.create! :persona => DD1, :direccion => Dir1
PerPersonasDirecciones.create! :persona => DD2, :direccion => Dir1
PerPersonasDirecciones.create! :persona => SD, :direccion => Dir1


#Prestador (Clinica)
puts 'Prestador 1'
CLG = PrePrestadores.create! :nombre => "Centro Médico Los Galenos", :rut => 109000000, :es_centinela => false

puts 'Prestador - Direcciones '
PrePrestadoresDirecciones.create! :prestador => CLG, :direccion => Dir1

puts 'Prestador - Telefonos '
PrePrestadoresTelefonos.create! :prestador => CLG, :telefono => Tel1

puts 'Relación Prestador - Administrativo'
PrePrestadorAdministrativos.create! :prestador=> CLG, :administrativo => SD, :rol_administrativo => R1
PrePrestadorAdministrativos.create! :prestador=> CLG, :administrativo => SD, :rol_administrativo => R2
PrePrestadorAdministrativos.create! :prestador=> CLG, :administrativo => SD, :rol_administrativo => R3
PrePrestadorAdministrativos.create! :prestador=> CLG, :administrativo => SD, :rol_administrativo => R4
PrePrestadorAdministrativos.create! :prestador=> CLG, :administrativo => SD, :rol_administrativo => R5
PrePrestadorAdministrativos.create! :prestador=> CLG, :administrativo => SD, :rol_administrativo => R6

#Profesionales
puts 'Relación Persona-Profesión'
ProProfesionales.create! :validado => true, :profesional => D1, :especialidad => EDen, :institucion => IDen
ProProfesionales.create! :validado => true, :profesional => D2, :especialidad => EDen, :institucion => IDen
ProProfesionales.create! :validado => true, :profesional => D3, :especialidad => EDen, :institucion => IDen
ProProfesionales.create! :validado => true, :profesional => D4, :especialidad => EDen, :institucion => IDen

# Centro 1
puts 'Relación Prestador-Profesional'
RPDen1 =PrePrestadorProfesionales.create! :prestador => CLG, :profesional => DD1, :especialidad => EDen
RPDen2 = PrePrestadorProfesionales.create! :prestador => CLG, :profesional => DD2, :especialidad => EDen

PreReglaPagos.create! :tipo => 'profesional', :especialidad_prestador_profesional => RPDen1, :porcentaje => 0.4, :fecha_inicio => '2014-01-01'
PreReglaPagos.create! :tipo => 'profesional', :especialidad_prestador_profesional => RPDen2, :porcentaje => 0.35, :fecha_inicio => '2014-01-01' 

