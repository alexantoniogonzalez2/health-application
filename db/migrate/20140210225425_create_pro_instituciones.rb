class CreateProInstituciones < ActiveRecord::Migration
  def change
    create_table :pro_instituciones do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
