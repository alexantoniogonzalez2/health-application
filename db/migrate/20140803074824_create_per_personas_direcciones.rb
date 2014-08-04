class CreatePerPersonasDirecciones < ActiveRecord::Migration
  def change
    create_table :per_personas_direcciones do |t|
    	t.references :persona #persona_id
    	t.references :direccion #direcion_id
    	t.datetime :fecha_inicio
    	t.datetime :fecha_termino

      t.timestamps
    end
  end
end
