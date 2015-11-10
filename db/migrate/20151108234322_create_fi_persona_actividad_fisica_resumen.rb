class CreateFiPersonaActividadFisicaResumen < ActiveRecord::Migration
  def change
    create_table :fi_persona_actividad_fisica_resumen do |t|
    	t.references :persona #persona_id
    	t.string :frecuencia
    	t.string :tiempo
    	t.string :intensidad
      t.timestamps null: false
    end
  end
end
