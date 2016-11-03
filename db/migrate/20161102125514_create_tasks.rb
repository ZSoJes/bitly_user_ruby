class CreateTasks < ActiveRecord::Migration
  def change
    create_table :users do |us|
        us.string :name
        us.string :email
        us.string :password
    end

    create_table :urls do |u|
        u.belongs_to :users, index: true # indica a quien pertenece la creacion de la url
        u.string :long_url
        u.string :short_url
        u.integer :click_count, :default => 0
    end
  end
end
