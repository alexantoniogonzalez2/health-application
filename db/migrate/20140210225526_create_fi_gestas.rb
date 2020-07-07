class CreateFiGestas < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_gestas do |t|
      t.datetime :fecha_inicio		#fecha_inicio
      t.datetime :fecha_termino		#fecha_termino
      t.string :desenlace				#desenlace
      t.references :persona			#persona_id
      t.timestamps
    end
  end
end
