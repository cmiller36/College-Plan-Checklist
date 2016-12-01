class CreateColleges < ActiveRecord::Migration[5.0]
  def change
    create_table :colleges do |t|
      t.string :name
      t.boolean :pay_app_fee, default: false
      t.boolean :submit_application, default: false
      t.datetime :college_visit
      t.boolean :complete, default: false
      t.integer :user_id
    end
  end
end
