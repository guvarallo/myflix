class CreateCreateVideos < ActiveRecord::Migration
  def change
    create_table :create_videos do |t|

      t.timestamps
    end
  end
end
