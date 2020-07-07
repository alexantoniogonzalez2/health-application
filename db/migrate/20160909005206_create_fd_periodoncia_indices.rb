class CreateFdPeriodonciaIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_periodoncia_indices do |t|
    	t.references :periodoncia
    	t.references :pieza_dental
      t.integer :vestibular
      t.integer :mesial
      t.integer :palatino
      t.integer :distal
      t.string :indice
      t.timestamps null: false
    end
  end
end
