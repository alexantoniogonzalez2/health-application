class PerPersonas < ActiveRecord::Base 
  include ActionView::Helpers::NumberHelper

	has_many :hijos, :class_name => 'PerParentescos', :foreign_key => 'hijo_id'
	has_many :progenitores, :class_name => 'PerParentescos', :foreign_key => 'progenitor_id'	
  has_many :prestador_profesionales, :class_name => 'PrePrestadorProfesionales', :foreign_key => 'profesional_id'	
  has_many :prestador_administrativos, :class_name => 'PrePrestadorAdministrativos', :foreign_key => 'administrativo_id'	
  has_many :profesionales, :class_name => 'ProProfesionales', :foreign_key => 'profesional_id'  
  has_many :persona_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'persona_id'
  has_many :quien_pide_hora_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'quien_pide_hora_id'
  has_many :responsable_agendamientos, :class_name => 'AgAgendamientoLogEstados', :foreign_key => 'responsable_id'
  has_many :responsable_boletas, :class_name => 'PreBoletas', :foreign_key => 'responsable_id'
  has_many :responsable_accion_masiva, :class_name => 'AgAccionMasiva', :foreign_key => 'responsable_id'
  has_many :persona_examenes, :class_name => 'FiPersonaExamenes', :foreign_key => 'persona_id' 
  has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'persona_id' 
  has_many :gesta, :class_name => 'FiGestas', :foreign_key => 'persona_id'  
  has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_id'
  has_many :atenciones_salud, :class_name => 'FiAtencionesSalud', :foreign_key => 'persona_id'
  has_many :persona_metricas, :class_name => 'FiPersonaMetricas', :foreign_key => 'persona_id'
  has_many :personas_direcciones, :class_name => 'PerPersonasDirecciones', :foreign_key => 'persona_id'
  has_many :personas_previsiones_salud, :class_name => 'PerPersonasPrevisionesSalud', :foreign_key => 'persona_id'
  has_many :personas_telefonos, :class_name => 'PerPersonasTelefonos', :foreign_key => 'persona_id'
  has_many :personas_ocupaciones, :class_name => 'PerPersonasOcupaciones', :foreign_key => 'persona_id'
  has_many :personas_alergias, :class_name => 'FiPersonasAlergias', :foreign_key => 'persona_id'
  has_many :personas_habitos_tabaco, :class_name => 'FiHabitosTabaco', :foreign_key => 'persona_id'
  has_many :personas_habitos_drogas, :class_name => 'FiHabitosDrogas', :foreign_key => 'persona_id'
  has_many :personas_habitos_alcohol, :class_name => 'FiHabitosAlcohol', :foreign_key => 'persona_id'
  has_many :personas_habitos_alcohol_resumen, :class_name => 'FiHabitosAlcoholResumen', :foreign_key => 'persona_id'
  has_many :personas_vacunas, :class_name => 'FiPersonasVacunas', :foreign_key => 'persona_id'
  has_many :personas_conocimiento_ges, :class_name => 'FiNotificacionesGes', :foreign_key => 'persona_conocimiento_id'
  has_many :personas_conocimiento_int, :class_name => 'FiInterconsultas', :foreign_key => 'persona_conocimiento_id'
  has_one :persona_actividad_fisica, :class_name => 'FiPersonaActividadFisica', :foreign_key => 'persona_id'
  has_one :persona_actividad_fisica_resumen, :class_name => 'FiPersonaActividadFisica', :foreign_key => 'persona_id'
  has_one :persona_antecedentes_ginecologicos, :class_name => 'FiPersonaAntecedentesGinecologicos', :foreign_key => 'persona_id'
  has_many :personas, :class_name => 'PerOtrasRelaciones', :foreign_key => 'persona_id'
  has_many :personas_relaciones, :class_name => 'PerOtrasRelaciones', :foreign_key => 'persona_relacion_id' 
  has_many :persona_piezas_dentales, :class_name => 'FdPiezasDentales', :foreign_key => 'persona_id'
  has_many :responsable_diagnosticos, :class_name => 'FdDiagnosticos', :foreign_key => 'responsable_id' 
  has_many :responsable_pagos, :class_name => 'FdPagos', :foreign_key => 'responsable_id' 

  belongs_to :user, :class_name => 'User'
  belongs_to :diagnostico_muerte, :class_name => 'MedDiagnosticos'
  belongs_to :pais_nacionalidad, :class_name => 'TraPaises'

  def formato_personas
  {
    'id'        => id,
    'text'      => showRutParaListado<<' '<<nombre<<' '<<apellido_paterno<<' '<<apellido_materno     
  }
  end

  def misPacientes(especialidad_prestador_profesional)
    @id_paciente = []
    @id_pacientes = FiAtencionesSalud.select('distinct(fi_atenciones_salud.persona_id)')
      .joins('JOIN ag_agendamientos as ag on fi_atenciones_salud.agendamiento_id = ag.id')
      .where('especialidad_prestador_profesional_id = ?', especialidad_prestador_profesional )

    @id_pacientes.each do |id_paciente|
      @paciente = PerPersonas.find(id_paciente.persona_id)
      @id_paciente << { 
        'id' => id_paciente.persona_id,
        'rut' => @paciente.showRut, 
        'nombre' => @paciente.showName('%n%p%m')
      }  
    end 

    return @id_paciente 

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
      'Sin información'
    end  
  end 

  def getSegmentoActividadFisica
    if fecha_nacimiento
      edad = age
      if edad < 5  
        'Niño menor a 5 años'
      elsif edad >= 5 and edad < 18  
        'Niño'
      elsif edad >= 18 and edad < 65 
        'Adulto' 
      elsif edad >= 65
        'Adulto mayor'
      end    
    else
      'Sin información'
    end 
  end

  def getNivelEscolaridad
    texto_niv_esc = 'Sin información'
    case nivel_escolaridad
      when '1' 
        texto_niv_esc = 'Sin información'
      when '2'
        texto_niv_esc = 'Educación Básica Incompleta' 
      when '3'
        texto_niv_esc = 'Educación Básica Completa'
      when '4'
        texto_niv_esc = 'Educación Media Incompleta'
      when '5' 
        texto_niv_esc = 'Educación Media Completa' 
      when '6' 
        texto_niv_esc = 'Educación Técnica o Profesional Incompleta' 
      when '7' 
        texto_niv_esc = 'Educación Técnica o Profesional Completa' 
      when '8' 
        texto_niv_esc = 'Educación Superior Incompleta' 
      when '9' 
        texto_niv_esc = 'Educación Superior Completa'      
    end
    return texto_niv_esc
  end  

  def age
    if fecha_nacimiento
      dob = fecha_nacimiento 
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    else
      'Sin información' 
    end 
  end

  def ageAtDate(date)
    if fecha_nacimiento
      dob = fecha_nacimiento 
      date.year - dob.year - ((date.month > dob.month || (date.month == dob.month && date.day >= dob.day)) ? 0 : 1)
    else
      'Sin información' 
    end 
  end

  def age_text
    edad = age
    dob = fecha_nacimiento 
    now = Time.now.utc.to_date
    meses =  now.month > dob.month ?  now.month - dob.month : 12 - dob.month + now.month   
    meses =  meses - 1 if dob.day >= now.day
    texto_edad = edad == 1 ? ' año' : ' años'
    texto_meses = meses == 1 ? ' mes' : ' meses'
    edad.to_s << texto_edad << ' ' << meses.to_s << texto_meses
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

  def showName(format) #showName('%n%p%m')
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
        end
      end

      ret.join(" ")
    end
  end

  def showSexo
    return genero 
  end 

  def showRut
    texto_rut = "Sin información"
    texto_rut = number_with_delimiter(rut, delimiter: ".").to_s<<'-'<<digito_verificador if rut
    return texto_rut
  end 

  def showRutParaListado
    texto_rut = "Sin RUT"
    texto_rut = number_with_delimiter(rut, delimiter: ".").to_s<<'-'<<digito_verificador if rut
    return texto_rut
  end 

  def getPrevision
    persona_prevision = personas_previsiones_salud.where('fecha_termino > ? OR fecha_termino IS NULL', DateTime.current).first
    nombre_prevision = persona_prevision.nil? ? "Sin información" : persona_prevision.prevision_salud.nombre
    return nombre_prevision
  end

  def getPrevisionSalud
    persona_prevision = personas_previsiones_salud.where('fecha_termino > ? OR fecha_termino IS NULL', DateTime.current).first
    #A falta de I-Med, se agrega una previsión "Sin información"
    unless persona_prevision
      persona_prevision = PerPersonasPrevisionesSalud.create! :persona_id => id, :prevision_salud_id => 3
    end
    return persona_prevision.prevision_salud
  end

  def getDomicilio
    domicilio = personas_direcciones.where('fecha_termino > ? OR fecha_termino IS NULL', DateTime.current).first
    texto_domicilio = domicilio.nil? ? 'Sin información' : domicilio.direccion.calle + ' ' + domicilio.direccion.numero.to_s + ', ' + domicilio.direccion.comuna.nombre + ', '+ domicilio.direccion.ciudad.nombre
    return texto_domicilio
  end 

  def getTelefonoFijo
    telefono_fijo = personas_telefonos.joins(:telefono).select('tra_telefonos.codigo, tra_telefonos.numero').where('tra_telefonos.codigo != 9').first
    texto_telefono_fijo = telefono_fijo.nil? ? 'Sin información' : telefono_fijo.codigo.to_s << ' ' << telefono_fijo.numero.to_s
    return texto_telefono_fijo
  end 

  def getCelular
    celular = personas_telefonos.joins(:telefono).select('tra_telefonos.codigo, tra_telefonos.numero').where('tra_telefonos.codigo = 9').first
    texto_celular = celular.nil? ? 'Sin información' : celular.numero.to_s 
    return texto_celular
  end 

  def getCorreo
    correo = user.email
    if correo.include? "@medracer.com"
      correo = "Sin información"
    end   
    return correo
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

  def getAntecedentesDecesos
    @familiares = getFamiliares
    @decesos = []
    @familiares.each do |familiar|
      @decesos_familiares = PerPersonas.where('id = ? and diagnostico_muerte_id is not null',familiar[0])
      @decesos_familiares.each do |deceso_familiar|
        @decesos << { 
          'id' => familiar[0],
          'persona' => deceso_familiar.showName('%n%p%m'),
          'parentesco' => familiar[1],
          'diagnostico' => deceso_familiar.diagnostico_muerte.nombre,
          'fecha_deceso' => deceso_familiar.fecha_muerte.try(:strftime,'%Y-%m-%d')
        }  
      end  
    end  

    return @decesos
  end 

  def getAntecedentesEnfermedadesCronicas
    @familiares = getFamiliares
    @enfermedades_cronicas = []
    @familiares.each do |familiar|
    @enfermedades= FiPersonaDiagnosticos
    .joins(:persona_diagnosticos_atencion_salud)
    .select("fi_persona_diagnosticos_atenciones_salud.id,
            fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
            fi_persona_diagnosticos_atenciones_salud.fecha_termino,
            fi_persona_diagnosticos.diagnostico_id,
            fi_persona_diagnosticos.persona_id,
            fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
            fi_persona_diagnosticos_atenciones_salud.comentario,
            fi_persona_diagnosticos_atenciones_salud.es_cronica,
            fi_persona_diagnosticos_atenciones_salud.es_antecedente,              
            fi_persona_diagnosticos_atenciones_salud.atencion_salud_id")
    .where('persona_id = ? AND (fi_persona_diagnosticos_atenciones_salud.es_cronica = 1 OR fi_persona_diagnosticos_atenciones_salud.es_antecedente = true)', familiar[0]) 
      @enfermedades.each do |enfermedad|
        @enfermedades_cronicas << { 'datos' => enfermedad , 'parentesco' => familiar[1] }          
      end  
    end  

    return @enfermedades_cronicas
  end

  def getEnfermedadesCronicas
    @antecedentes = FiPersonaDiagnosticos.where('persona_id = ? and es_cronica = 1', id)
    return @antecedentes 
  end 

  def getFamiliares
    @familiares = Hash.new    
    @hijos = PerParentescos.where('progenitor_id = ?',id)
    @hijos.each do |hijo|
      @genero = hijo.hijo.genero == 'Masculino' ? 'Hijo' : 'Hija'
      @familiares[hijo.hijo.id] = @genero
    end 
    @padres = PerParentescos.where('hijo_id = ?',id)
    @padres.each do |padre|
      @genero = padre.progenitor.genero == 'Masculino' ? 'Padre' : 'Madre'
      @familiares[padre.progenitor.id] = @genero

      @hermanos = PerParentescos.where('progenitor_id = ? AND hijo_id != ?',padre.progenitor.id,id)
      @hermanos.each do |hermano|
        @genero = hermano.hijo.genero == 'Masculino' ? 'Hermano' : 'Hermana'
        @familiares[hermano.hijo.id] = @genero
      end 

    end
    return @familiares
  end 

  def getCercanos
    @cercanos = getFamiliares
    @otras_relaciones = PerOtrasRelaciones.where('persona_id = ?',id)
    @otras_relaciones.each do |otra_relacion|
      @cercanos[otra_relacion.persona_relacion.id] = otra_relacion.relacion
    end
    return @cercanos
  end 

  def getOdontograma(tipo)

    @odontograma = []

    generateOdontogram unless persona_piezas_dentales.present?

    piezas_dentales = persona_piezas_dentales.where('tipo_diente_id BETWEEN 1 AND 32')
    piezas_dentales.each do |pieza_dental|
      @odontograma << pieza_dental.getEstado(tipo)
    end

    return @odontograma

  end

  def getIndice(tipo,periodoncia)

    @indice = []

    generateOdontogram unless persona_piezas_dentales.present?

    piezas_dentales = persona_piezas_dentales.where('tipo_diente_id BETWEEN 1 AND 32')
    piezas_dentales.each do |pieza_dental|
      @indice<< pieza_dental.getEstadoIndice(tipo,periodoncia)
    end

    return @indice

  end

  def generateOdontogram

    tipos_dientes = FdTiposDientes.where('tipo_denticion = "permanente"')
    ActiveRecord::Base.transaction do
      tipos_dientes.each do |tipo_diente|
        FdPiezasDentales.create! :persona_id => id, :tipo_diente => tipo_diente
      end
    end
    
  end

  private
  def app_params
    params.require(:persona).permit(:id,
                                    :apellido_materno,
                                    :apellido_paterno, 
                                    :fecha_muerte, 
                                    :fecha_nacimiento, 
                                    :genero, 
                                    :nombre, 
                                    :rut,
                                    :digito_verificador,
                                    :nivel_escolaridad,
                                    :numero_personas_familia,
                                    :causa_muerte,
                                    :diagnostico_muerte,
                                    :hijos,
                                    :progenitores,
                                    :prestador_profesionales,
                                    :prestador_administrativos,
                                    :profesionales,
                                    :profesional_agendamientos,
                                    :persona_agendamientos,
                                    :quien_pide_hora_agendamientos,
                                    :admin_genera_agendamientos,
                                    :admin_confirma_agendamientos,
                                    :admin_recibe_agendamientos,
                                    :persona_examenes,
                                    :persona_diagnosticos,
                                    :responsable_agendamientos,
                                    :responsable_accion_masiva,
                                    :responsable_boletas,
                                    :gesta,
                                    :persona_medicamentos,
                                    :persona_metricas,
                                    :user,
                                    :personas_previsiones_salud,
                                    :personas_telefonos,
                                    :personas_ocupaciones,
                                    :personas_alergias,
                                    :personas_habitos_tabaco,
                                    :personas_habitos_drogas,
                                    :personas_habitos_alcohol,
                                    :personas_habitos_alcohol_resumen,
                                    :personas_vacunas,
                                    :personas_conocimiento_ges,
                                    :personas_conocimiento_int,
                                    :persona_actividad_fisica,
                                    :persona_actividad_fisica_resumen,
                                    :personas,
                                    :personas_relaciones,
                                    :pais_nacionalidad,
                                    :persona_antecedentes_ginecologicos,
                                    :persona_piezas_dentales,
                                    :responsable_diagnosticos,
                                    :responsable_pagos)
  end

end
