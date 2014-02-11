class CreateFiGestas < ActiveRecord::Migration
  def change
    create_table :fi_gestas do |t|
      t.datetime :fecha_inicio		#fecha_inicio
      t.datetime :fecha_termino		#fecha_termino
      t.text :desenlace				#desenlace
      t.references :persona			#persona_id


      t.timestamps
    end
  end
end
