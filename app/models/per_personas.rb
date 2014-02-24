class PerPersonas < ActiveRecord::Base

	has_many :hijos, :class_name => 'PerParentescos', :foreign_key => 'hijo_id'
	has_many :progenitores, :class_name => 'PerParentescos', :foreign_key => 'progenitor_id'	
  has_many :prestador_profesionales, :class_name => 'PrePrestadorProfesionales', :foreign_key => 'profesional_id'	
  has_many :prestador_administrativos, :class_name => 'PrePrestadorAdministrativos', :foreign_key => 'administrativo_id'	
  has_many :profesionales, :class_name => 'ProProfesionales', :foreign_key => 'profesional_id'  
  has_many :persona_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'persona_id'
  has_many :admin_genera_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'administrativo_id'
  has_many :admin_recibe_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'administrativo_id'
  has_many :admin_confirma_agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'administrativo_id'
  has_many :persona_examenes, :class_name => 'FiPersonaExamenes', :foreign_key => 'persona_id' 
  has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'persona_id' 
  has_many :gesta, :class_name => 'FiGestas', :foreign_key => 'persona_id'  
  has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_id'
  has_many :atenciones_medicas, :class_name => 'FiAtencionesMedicas', :foreign_key => 'persona_id'
  has_many :persona_metricas, :class_name => 'FiPersonaMetricas', :foreign_key => 'persona_id'
  belongs_to :user, :class_name => 'User'

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

  def digitoVerificador #Calculo digito verificador
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
                    :gesta,
                    :persona_medicamentos,
                    :persona_metricas,
                    :user)
  end

end
