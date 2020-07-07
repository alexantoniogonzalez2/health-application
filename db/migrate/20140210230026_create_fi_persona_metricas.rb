class CreateFiPersonaMetricas < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_persona_metricas do |t|
      t.references :persona 	#persona_id
      t.references :metrica 	#metrica_id
      t.references :atencion_salud 	#atencion_salud_id
      t.decimal :valor, :precision => 10, :scale => 2
      t.datetime :fecha
      t.text :caracteristica

      t.timestamps
    end
  end
end
