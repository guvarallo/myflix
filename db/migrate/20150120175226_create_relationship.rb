class CreateRelationship < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id, :relation_id
      t.timestamps
    end
  end
end
