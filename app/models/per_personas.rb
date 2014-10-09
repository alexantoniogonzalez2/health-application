class PerPersonas < ActiveRecord::Base 
  include ActionView::Helpers::NumberHelper

	has_many :hijos, :class_name => 'PerParentescos', :foreign_key => 'hijo_id'
	has_many :progenitores, :class_name => 'PerParentescos', :foreign_key => 'progenitor_id'	
  has_many :prestador_profesionales, :class_name => 'PrePrestadorProfesionales', :foreign_key => 'profesional_id'	
  has_many :prestador_administrativos, :class_name => 'PrePrestadorAdministrativos', :foreign_key => 'administrativo_id'	
  has_many :profesionales, :class_name => 'ProProfesionales', :foreign_key => 'profesional_id'  
  has_many :persona_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'persona_id'
  has_many :responsable_agendamientos, :class_name => 'AgAgendamientoLogEstados', :foreign_key => 'responsable_id'
  has_many :persona_examenes, :class_name => 'FiPersonaExamenes', :foreign_key => 'persona_id' 
  has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'persona_id' 
  has_many :gesta, :class_name => 'FiGestas', :foreign_key => 'persona_id'  
  has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_id'
  has_many :atenciones_medicas, :class_name => 'FiAtencionesMedicas', :foreign_key => 'persona_id'
  has_many :persona_metricas, :class_name => 'FiPersonaMetricas', :foreign_key => 'persona_id'
  has_many :personas_direcciones, :class_name => 'PerPersonasDirecciones', :foreign_key => 'persona_id'
  has_many :personas_previsiones_salud, :class_name => 'PerPersonasPrevisionesSalud', :foreign_key => 'persona_id'
  has_many :personas_telefonos, :class_name => 'PerPersonasTelefonos', :foreign_key => 'persona_id'
  has_many :personas_profesiones_oficios, :class_name => 'PerPersonasProfesionesOficios', :foreign_key => 'persona_id'
  has_many :personas_alergias, :class_name => 'FiPersonasAlergias', :foreign_key => 'persona_id'
  has_many :personas_habitos_tabaco, :class_name => 'FiHabitosTabaco', :foreign_key => 'persona_id'
  has_many :personas_habitos_drogas, :class_name => 'FiHabitosDrogas', :foreign_key => 'persona_id'
  has_many :personas_habitos_alcohol, :class_name => 'FiHabitosAlcohol', :foreign_key => 'persona_id'
  has_many :personas_vacunas, :class_name => 'FiPersonasVacunas', :foreign_key => 'persona_id'
  has_many :personas_conocimiento_ges, :class_name => 'FiNotificacionesGes', :foreign_key => 'persona_conocimiento_id'
  has_many :personas_conocimiento_int, :class_name => 'FiInterconsultas', :foreign_key => 'persona_conocimiento_id'

  belongs_to :user, :class_name => 'User'

  def formato_personas

  {
    'id'        => id,
    'text'      => number_with_delimiter(rut, delimiter: ".").to_s<<'-'<<digito_verificador<<' '<<nombre<<' '<<apellido_paterno<<' '<<apellido_materno     
  }

  end

  def getGrupoEtareo(fecha_atencion_salud)
    if fecha_nacimiento

      limite_recien_nacido = fecha_nacimiento + 28.days
      limite_lactante = fecha_nacimiento + 2.years
      limite_pediatria = fecha_nacimiento + 10.years
      limite_adolescente = fecha_nacimiento + 18.years
      limite_adulto = fecha_nacimiento + 65.years

      if fecha_atencion_salud < limite_recien_nacido 
        'Recién nacido'
      elsif fecha_atencion_salud < limite_lactante
        'Lactante'
      elsif fecha_atencion_salud < limite_pediatria
        'Pediatria'
      elsif fecha_atencion_salud < limite_adolescente
        'Adolescente'
      elsif fecha_atencion_salud < limite_adulto 
        'Adulto'
      else
        'Adulto mayor'
      end   
    else
      'Sin fecha nacimiento'
    end  
  end  


  def esProfesional(prestador_id)
    #Tomará sentido siempre que no exista un "deleted"
    @prestador=prestador_profesionales.where("prestador_id = ?", prestador_id).first
    if @prestador
      true
    else
      false
    end    
  end

  def showName(format)
    if format.length%2 != 0 or format.split("%").count != format.length/2+1
      ""
    else
      tmp=format.split("%")
      ret=[]
      tmp.each do |c|
        if c == "n" #nombre
          ret << nombre
        elsif c == "p" #apellido_paterno
          ret << apellido_paterno
        elsif c == "m" #apellido_materno
          ret << apellido_materno
        elsif c== "d" #dr/dra
          if genero=="Masculino"
            ret << "Dr."
          else
            ret << "Dra."
          end
        elsif c== "s" #o/a
          if genero=="Masculino"
            ret << "o"
          else
            ret << "a"
          end
        end
      end

      ret.join(" ")
    end
  end

  def showSexo
    return genero 
  end 

  def showRut
    return number_with_delimiter(rut, delimiter: ".").to_s<<'-'<<digito_verificador 
  end 

  def getPrevision
    persona_prevision = personas_previsiones_salud.where('fecha_termino > ? OR fecha_termino IS NULL', DateTime.current).first
    nombre_prevision = persona_prevision.nil? ? "Sin información" : persona_prevision.prevision.nombre
    return nombre_prevision
  end  

  def getDomicilio
    domicilio = personas_direcciones.where('fecha_termino > ? OR fecha_termino IS NULL', DateTime.current).first
    return domicilio.direccion.calle + ' ' + domicilio.direccion.numero.to_s + ', ' + domicilio.direccion.comuna.nombre + ', '+ domicilio.direccion.ciudad.nombre
  end 

  def getTelefonoFijo
    telefono_fijo = personas_telefonos.joins(:telefono).select('tra_telefonos.codigo, tra_telefonos.numero').where('tra_telefonos.codigo != 9').first
    return telefono_fijo.codigo.to_s << ' ' << telefono_fijo.numero.to_s
  end 

  def getCelular
    celular = personas_telefonos.joins(:telefono).select('tra_telefonos.codigo, tra_telefonos.numero').where('tra_telefonos.codigo = 9').first
    return celular.codigo.to_s << ' ' << celular.numero.to_s
  end 

  def revisarDigitoVerificador #Calculo digito verificador
    t=rut
    v=1
    s=0
    for i in (2..9)
      if i == 8
        v=2
      else 
        v+=1
      end
      s+=v*(t%10)
      t=t/10
    end

    s = 11 - s%11
    if s == 11
      0
    elsif s == 10
      "K"
    else
      s
    end
  end

  

  private
  def app_params
    params.require(:persona).permit(:apellido_materno,
                                    :apellido_paterno, 
                                    :fecha_muerte, 
                                    :fecha_nacimiento, 
                                    :genero, 
                                    :nombre, 
                                    :rut,
                                    :digito_verificador,
                                    :hijos,
                                    :progenitores,
                                    :prestador_profesionales,
                                    :prestador_administrativos,
                                    :profesionales,
                                    :profesional_agendamientos,
                                    :persona_agendamientos,
                                    :admin_genera_agendamientos,
                                    :admin_confirma_agendamientos,
                                    :admin_recibe_agendamientos,
                                    :persona_examenes,
                                    :persona_diagnosticos,
                                    :responsable_agendamientos,
                                    :gesta,
                                    :persona_medicamentos,
                                    :persona_metricas,
                                    :user,
                                    :personas_previsiones_salud,
                                    :personas_telefonos,
                                    :personas_profesiones_oficios,
                                    :personas_alergias,
                                    :personas_habitos_tabaco,
                                    :personas_habitos_drogas,
                                    :personas_habitos_alcohol,
                                    :personas_vacunas,
                                    :personas_conocimiento_ges,
                                    :personas_conocimiento_int)
  end

end
