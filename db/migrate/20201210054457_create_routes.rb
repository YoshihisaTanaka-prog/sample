class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|

      t.string        :before_id
      t.string        :next_title_name
      t.string        :table_name
      t.string        :after_id
      t.text          :score
      t.timestamps
    end
  end
end
