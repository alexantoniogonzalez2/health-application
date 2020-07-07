class CreateMedDiagnosticosCapitulos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_diagnosticos_capitulos do |t|    	    	
    	t.string :nombre
    	t.string :codigo
    	t.string :descripcion
      t.timestamps
    end
  end
end
