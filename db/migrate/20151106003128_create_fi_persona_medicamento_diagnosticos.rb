class CreateFiPersonaMedicamentoDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fi_persona_medicamento_diagnosticos do |t|
    	t.references :persona_medicamento #persona_prestacion_id
    	t.references :persona_diagnostico_atencion_salud #persona_diagnostico_atencion_salud_id
      t.timestamps null: false
    end
  end
end
