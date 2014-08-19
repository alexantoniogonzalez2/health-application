class CreateMedDiagnosticosCapitulos < ActiveRecord::Migration
  def change
    create_table :med_diagnosticos_capitulos do |t|    	    	
    	t.text :nombre
    	t.text :codigo
    	t.text :descripcion
      t.timestamps
    end
  end
end
