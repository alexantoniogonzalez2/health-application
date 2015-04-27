class AppMailer < ActionMailer::Base
  default from: "contacto@medracer.com"

  def contact_email(nombre,correo,telefono,mensaje)
    @nombre = nombre
    @correo = correo
    @telefono = telefono
    @mensaje = mensaje
    mail(to: @correo, subject: 'MedRacer - Hemos recibido su mensaje')
  end
end
