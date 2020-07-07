class CreateMedMedicamentosTipos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_medicamentos_tipos do |t|
    	t.string :nombre
    	t.string :unidad
    	t.references :medicamento_metatipo #medicamento_metatipo_id
      t.timestamps
    end
  end
end
