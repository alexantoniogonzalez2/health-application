class CreateFiPersonaPrestacionDiagnosticos < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_persona_prestacion_diagnosticos do |t|
    	t.references :persona_prestacion, index: { name: :persona_prestacion_index } #persona_prestacion_id
    	t.references :persona_diagnostico_atencion_salud, index: { name: :persona_diagnostico_at_sal_fippd } #persona_diagnostico_atencion_salud_id
    	t.boolean :para_interconsulta
      t.timestamps null: false
    end
  end
end
