class CreatePerPersonasPrevisionesSalud < ActiveRecord::Migration[5.0]
  def change
    create_table :per_personas_previsiones_salud do |t|
    	t.references :persona #persona_id
    	t.references :prevision_salud #prevision_salud_id
    	t.datetime :fecha_inicio
    	t.datetime :fecha_termino

      t.timestamps
    end
  end
end
