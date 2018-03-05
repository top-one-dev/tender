class AddLikeToQanswers < ActiveRecord::Migration[5.0]
  def change
    add_column :qanswers, :like, :boolean
    add_column :qanswers, :comments, :text
  end
end
