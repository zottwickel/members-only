class AddSubjectToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :subject, :string
  end
end
