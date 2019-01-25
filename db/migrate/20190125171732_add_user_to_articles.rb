class AddUserToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :user, :string
  end
end
