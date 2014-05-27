class CreateMedMedicamentosTipos < ActiveRecord::Migration
  def change
    create_table :med_medicamentos_tipos do |t|
    	t.text :unidad
    	t.references :medicamento_metatipo #medicamento_metatipo_id

      t.timestamps
    end
  end
end
