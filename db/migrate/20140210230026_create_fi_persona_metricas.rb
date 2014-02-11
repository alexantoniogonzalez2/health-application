class CreateFiPersonaMetricas < ActiveRecord::Migration
  def change
    create_table :fi_persona_metricas do |t|
      t.references :persona 	#persona_id
      t.references :metrica 	#metrica_id
      t.references :atencion_salud 	#atencion_salud_id

      t.timestamps
    end
  end
end
