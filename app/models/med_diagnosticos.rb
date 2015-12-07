class MedDiagnosticos < ActiveRecord::Base

	has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'diagnostico_id'
  has_many :problemas_salud_auge_diagnosticos, :class_name => 'MedProblemasSaludAugeDiagnosticos', :foreign_key => 'diagnostico_id'
  has_many :eno_diagnosticos, :class_name => 'MedEnoDiagnostico', :foreign_key => 'diagnostico_id'
  has_many :causa_muerte, :class_name => 'PerPersonas', :foreign_key => 'diagnostico_muerte_id'
 
  belongs_to :grupo, :class_name => 'MedDiagnosticosGrupos'

  def formato_lista
    { :id => id,:text => codigo_cie10 + ' ' + nombre }
  end  

  def esAuge(p_d)
    esAuge = false
    if problemas_salud_auge_diagnosticos.any?
      
      persona_diagnostico_atencion_salud = FiPersonaDiagnosticosAtencionesSalud.find(p_d)
      persona_diagnostico = persona_diagnostico_atencion_salud.persona_diagnostico
      persona = persona_diagnostico.persona
      fecha_diagnostico = persona_diagnostico.created_at
      edad_al_diagnostico = persona.ageAtDate(fecha_diagnostico)

      tiene_restricciones = false 
      problemas_salud_auge_diagnosticos.each do |psad|
        edad_hasta = psad.problema_salud_auge.edad_hasta
        edad_desde = psad.problema_salud_auge.edad_desde
        
        unless edad_desde.nil?
          esAuge = true if edad_al_diagnostico > edad_desde
          tiene_restricciones = true  
        end
        unless edad_hasta.nil?
          esAuge = true if edad_al_diagnostico < edad_hasta
          tiene_restricciones = true
        end         
        
      end 

      esAuge = true unless tiene_restricciones

    end  

    return esAuge

  end  

  def esENO(p_d)
    esENO = false
     
    eno_diagnosticos.each do |ed| 

      if ed.tipo_vigilancia == 'Centinela'
        persona_diagnostico_atencion_salud = FiPersonaDiagnosticosAtencionesSalud.find(p_d)
        atencion_salud = persona_diagnostico_atencion_salud.atencion_salud
        if atencion_salud
          agendamiento = atencion_salud.agendamiento
          especialidad_prestador_profesional = agendamiento.especialidad_prestador_profesional
          prestador = especialidad_prestador_profesional.prestador
          es_centinela = prestador.es_centinela
          esENO = true if es_centinela
        end              
      else
        esENO = true
      end        
      
    end

    return esENO
    
  end

  def getTextoENO(p_d)

    texto = []
         
    eno_diagnosticos.each do |ed| 

      if ed.tipo_vigilancia == 'Centinela'
        persona_diagnostico_atencion_salud = FiPersonaDiagnosticosAtencionesSalud.find(p_d)
        atencion_salud = persona_diagnostico_atencion_salud.atencion_salud
        if atencion_salud
          agendamiento = atencion_salud.agendamiento
          especialidad_prestador_profesional = agendamiento.especialidad_prestador_profesional
          prestador = especialidad_prestador_profesional.prestador
          es_centinela = prestador.es_centinela
          texto << { 'text' => 'Tipo de vigilancia: ' + ed.tipo_vigilancia + ' | ' + 'Frecuencia de notificación: ' + ed.frecuencia_notificacion } if es_centinela
        end              
      else
        @text_temp = ''
        @text_temp << 'Tipo de vigilancia: ' + ed.tipo_vigilancia + ' | ' unless ed.tipo_vigilancia.nil?
        @text_temp << 'Frecuencia de notificación: ' + ed.frecuencia_notificacion unless ed.frecuencia_notificacion.nil?
        texto << { 'text' => @text_temp }
      end        
      
    end

    return texto
    
  end
  

  private
  def app_params
    params.require(:list).permit(:codigo_cie10,:genero,:descripcion,:frecuente,:nodo_terminal,:grupo,:id,:nombre,:persona_diagnosticos,:problemas_salud_auge_diagnosticos,:eno_diagnosticos,:causa_muerte)
  end
							  
end
