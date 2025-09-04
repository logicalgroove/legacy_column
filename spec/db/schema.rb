ActiveRecord::Schema.define(:version => 0) do

  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
    t.string :old_email
    t.string :old_phone_number
  end

  create_table :products, :force => true do |t|
    t.decimal :old_price
    t.string :old_name
  end

  create_table :items, :force => true do |t|
    t.string :old_status
  end

  create_table :orders, :force => true do |t|
    t.decimal :old_total
  end

  create_table :accounts, :force => true do |t|
    t.decimal :old_balance
  end
end
