class CreateMedDiagnosticosBloques < ActiveRecord::Migration
  def change
    create_table :med_diagnosticos_bloques do |t|
    	t.string :nombre
    	t.string :codigo
    	t.references :capitulo #capitulo_id    	
      t.timestamps
    end
  end
end
