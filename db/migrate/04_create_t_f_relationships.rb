class CreateTFRelationships < ActiveRecord::Migration
  def change
    create_table :tfrelationships do |t|
      t.integer :title_id
      t.integer :figure_id
    end
  end
end