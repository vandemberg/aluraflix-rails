class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :description
      t.string :title

      t.timestamps
    end
  end
end
