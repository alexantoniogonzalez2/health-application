class CreateMedProblemasSaludAugeDiagnosticos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_problemas_salud_auge_diagnosticos do |t|
    	t.references :diagnostico #diagnostico_id
    	t.references :problema_salud_auge , index: { name: :problema_salud_auge_index }#problema_salud_auge_id
    	t.integer :prioridad
      t.timestamps null: false
    end
  end
end
