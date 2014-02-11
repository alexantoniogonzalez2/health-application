class CreatePerParentescos < ActiveRecord::Migration
  def change
    create_table :per_parentescos do |t|
      t.references :hijo		#hijo_id	
      t.references :progenitor	#progenitor_id
      t.references :gesta		#gesta_id

      t.timestamps
    end
  end
end
