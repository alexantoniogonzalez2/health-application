class CreateMedDiagnosticosGrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_diagnosticos_grupos do |t|
    	t.string :nombre
    	t.string :codigo
    	t.references :bloque #bloque_id    	
      t.timestamps
    end
  end
end
