class CreateFiPersonaMedicamentoDiagnosticos < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_persona_medicamento_diagnosticos do |t|
    	t.references :persona_medicamento, index: { name: :persona_medicamento_index } #persona_prestacion_id
    	t.references :persona_diagnostico_atencion_salud, index: { name: :persona_diagnostico_at_sal_fipmd }  #persona_diagnostico_atencion_salud_id
      t.timestamps null: false
    end
  end
end
