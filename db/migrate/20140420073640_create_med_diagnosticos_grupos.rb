class CreateMedDiagnosticosGrupos < ActiveRecord::Migration
  def change
    create_table :med_diagnosticos_grupos do |t|
    	t.text :nombre
    	t.text :codigo
    	t.references :bloque #bloque_id    	
      t.timestamps
    end
  end
end
