class FdPiezasDentales < ActiveRecord::Base
  belongs_to :persona, :class_name => 'PerPersonas'
  belongs_to :tipo_diente, :class_name => 'FdTiposDientes'
  has_many :diagnosticos, :class_name => 'FdDiagnosticos', :foreign_key => 'pieza_dental_id'
  has_many :test_diagnostico, :class_name => 'FdTestDiagnostico', :foreign_key => 'pieza_dental_id'
  has_many :endodoncia, :class_name => 'FdEndodoncias', :foreign_key => 'pieza_dental_id'
  has_many :periodoncia_indices, :class_name => 'FdPeriodonciaIndices', :foreign_key => 'pieza_dental_id'

  def getEstadoIndice(tipo,periodoncia)
    estado_indice = periodoncia_indices.where('indice = ? AND periodoncia_id = ?',tipo,periodoncia).first
    unless estado_indice
      estado_indice = FdPeriodonciaIndices.new
      estado_indice.periodoncia_id = periodoncia
      estado_indice.pieza_dental_id = id
      estado_indice.indice = tipo
      estado_indice.save!
    end

    return {
      id: tipo_diente.nomenclatura,
      grupo: tipo_diente.grupo,
      vestibular: estado_indice.vestibular,
      mesial: estado_indice.mesial,
      palatino: estado_indice.palatino,
      distal: estado_indice.distal,
    }

  end

  def getDiagnostico(cara)
  	diagnostico = 'sano'
  	diag = diagnosticos.where('zona = ?',cara).order('fecha').first
  	textos = {1 => 'sano', 2 => 'caries', 3 => 'composite', 4 => 'sellante', 5 => 'amalgama', 6 => 'incrustacion', 7 => 'corona'}

  	if diag 
  		diagnostico = textos[diag.tipo_diagnostico.id]
  	end

  	return diagnostico

  end

  def getCaracteristica
  	caracteristica = 'normal'
  	carac = diagnosticos.where('zona is null AND tipo_diagnostico_id IN (8,9,10,11,12)').order('fecha').first
  	textos = { 8 => 'normal', 9 => 'ausente', 10 => 'endodoncia', 11 => 'extraccion', 12 => 'implante'}

  	if carac
  		caracteristica = textos[carac.tipo_diagnostico.id]
  	end

  	return caracteristica
  	
  end

  def getEstado(tipo)
    if tipo == 'default'
       return {
          name: tipo_diente.nomenclatura,
          descripcion: tipo_diente.descripcion,
          cara_dental: [1,2,3].include?(tipo_diente.segundo_digito) ? true : false ,
          image: ActionController::Base.helpers.asset_path('dental/od_'<<tipo_diente.primer_digito.to_s<<'/'<<tipo_diente.nomenclatura<<'.jpg'),
        }
    else
      return {
          name: tipo_diente.nomenclatura,
          descripcion: tipo_diente.descripcion,
          cara_dental: [1,2,3].include?(tipo_diente.segundo_digito) ? true : false ,
          image: ActionController::Base.helpers.asset_path('dental/od_'<<tipo_diente.primer_digito.to_s<<'/'<<tipo_diente.nomenclatura<<'.jpg'),
          diag_distal: getDiagnostico('distal'),
          diag_vestibular: getDiagnostico('vestibular'),
          diag_mesial: getDiagnostico('mesial'),
          diag_palatina: getDiagnostico('palatina'),
          diag_central: getDiagnostico('central'),
          caracteristica: getCaracteristica, 
        }
    end
  end

  def app_params
    params.require(:list).permit(:id,:persona,:tipo_diente,:diagnosticos,:test_diagnostico,:endodoncia,:periodoncia_indices)
  end
end
