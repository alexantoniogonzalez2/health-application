class CreateMedVacunas < ActiveRecord::Migration[5.0]
  def change
    create_table :med_vacunas do |t|
      t.string :nombre
      t.string :protege_contra
      t.string :tipo

      t.timestamps
    end
  end
end
