class CreateFiInterconsultas < ActiveRecord::Migration
  def change
    create_table :fi_interconsultas do |t|
      t.text :motivo
      t.references :prestador_destino 	#prestador_destino_id
      t.references :atencion_salud 	#atencion_salud_id	
      
      t.timestamps
    end
  end
end
