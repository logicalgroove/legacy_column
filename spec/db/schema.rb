ActiveRecord::Schema.define(:version => 0) do

  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
    t.string :old_email
    t.string :old_phone_number
  end
end
