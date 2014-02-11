class CreateFiCertificados < ActiveRecord::Migration
  def change
    create_table :fi_certificados do |t|
      t.text :motivo
      t.datetime :fecha_inicio
      t.datetime :fecha_final
      t.references :atencion_salud	#atencion_salud_id
      	
      t.timestamps
    end
  end
end
