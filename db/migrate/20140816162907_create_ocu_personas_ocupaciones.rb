class CreateOcuPersonasOcupaciones < ActiveRecord::Migration[5.0]
  def change
    create_table :ocu_personas_ocupaciones do |t|
    	t.datetime :fecha_inicio
    	t.datetime :fecha_termino
    	t.references :persona #persona_id
    	t.references :ocupacion #ocupacion_id
    	t.boolean :es_actual
      t.timestamps
    end
  end
end
