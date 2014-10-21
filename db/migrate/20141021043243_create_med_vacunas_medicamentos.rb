class CreateMedVacunasMedicamentos < ActiveRecord::Migration
  def change
    create_table :med_vacunas_medicamentos do |t|
    	t.references :vacuna #vacuna_id
    	t.references :medicamento #medicamento_id
      t.timestamps
    end
  end
end
