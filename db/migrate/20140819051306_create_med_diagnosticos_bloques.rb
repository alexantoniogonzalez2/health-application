class CreateMedDiagnosticosBloques < ActiveRecord::Migration
  def change
    create_table :med_diagnosticos_bloques do |t|
    	t.text :nombre
    	t.text :codigo
    	t.references :capitulo #capitulo_id    	
      t.timestamps
    end
  end
end
