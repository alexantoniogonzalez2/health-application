class CreateFiCertificados < ActiveRecord::Migration
  def change
    create_table :fi_certificados do |t|
      t.string :tipo_reposo
      t.integer :dias_reposo
      t.datetime :control
      t.datetime :alta
      t.references :atencion_salud #atencion_salud_id
      t.boolean :para_trabajo
      t.boolean :para_colegio
      t.boolean :para_juzgado
      t.boolean :para_carabinero
      t.boolean :para_otros      	
      t.timestamps
    end
  end
end
