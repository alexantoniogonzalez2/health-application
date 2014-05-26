class CreateMedMedicamentosComponentes < ActiveRecord::Migration
  def change
    create_table :med_medicamentos_componentes do |t|
    	t.decimal :relacion 	
    	t.references :medicamento #medicamento_id
      t.references :componente #componente_id

      t.timestamps
    end
  end
end
