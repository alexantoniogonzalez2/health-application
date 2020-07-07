class CreateMedMedicamentosComponentes < ActiveRecord::Migration[5.0]
  def change
    create_table :med_medicamentos_componentes do |t|
    	t.decimal :relacion, :precision => 10, :scale => 2	
    	t.references :medicamento #medicamento_id
      t.references :componente #componente_id

      t.timestamps
    end
  end
end
