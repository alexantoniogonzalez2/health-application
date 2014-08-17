class CreatePerPersonasProfesionesOficios < ActiveRecord::Migration
  def change
    create_table :per_personas_profesiones_oficios do |t|
    	t.datetime :fecha_inicio
    	t.datetime :fecha_termino
    	t.references :persona #persona_id
    	t.references :profesion_oficio #profesion_oficio_id
      t.timestamps
    end
  end
end
