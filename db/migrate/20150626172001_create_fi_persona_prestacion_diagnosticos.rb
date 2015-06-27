class CreateFiPersonaPrestacionDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fi_persona_prestacion_diagnosticos do |t|
    	t.references :persona_prestacion #persona_prestacion_id
    	t.references :persona_diagnostico_atencion_salud #persona_diagnostico_atencion_salud_id
    	t.boolean :para_interconsulta
      t.timestamps null: false
    end
  end
end
