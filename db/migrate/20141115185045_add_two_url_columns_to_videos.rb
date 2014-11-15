class AddTwoUrlColumnsToVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :url,             :string
    add_column    :videos, :small_cover_url, :string
    add_column    :videos, :large_cover_url, :string
  end
end
