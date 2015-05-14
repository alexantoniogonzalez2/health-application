class CreateMedProblemasSaludAugeDiagnosticos < ActiveRecord::Migration
  def change
    create_table :med_problemas_salud_auge_diagnosticos do |t|
    	t.references :diagnostico #diagnostico_id
    	t.references :problema_salud_auge #problema_salud_auge_id
    	t.integer :prioridad
      t.timestamps null: false
    end
  end
end
