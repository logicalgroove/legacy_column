RSpec.describe LegacyColumn do
  context 'default message' do
    before do
      class User < ActiveRecord::Base
        legacy_column :old_email, :old_phone_number
      end
    end

    it 'should recognize all legacy columns' do
      expect(User.legacy_column_names).to eq([:old_email, :old_phone_number])
    end

    it 'should recognize default message' do
      expect(User.legacy_column_message).to eq('This column is set as legacy and should not be used anymore.')
    end

    describe 'output' do
      let(:user) { User.create }

      it 'prints awesome things' do
        expect {
          user.update(old_email: 'something')
        }.to output("\n\nUSE of legacy column detected.\n  User => old_email\n  This column is set as legacy and should not be used anymore.\n\n").to_stdout
      end
    end
  end

  context 'custom message' do
    before do
      class User < ActiveRecord::Base
        legacy_column :old_email, :old_phone_number, message: 'Dont do it!!!'
      end
    end

    it 'should recognize all legacy columns' do
      expect(User.legacy_column_names).to eq([:old_email, :old_phone_number])
    end

    it 'should recognize default message' do
      expect(User.legacy_column_message).to eq('Dont do it!!!')
    end

    describe 'output' do
      let(:user) { User.create }

      it 'prints awesome things' do
        expect {
          user.update(old_email: 'something')
        }.to output("\n\nUSE of legacy column detected.\n  User => old_email\n  Dont do it!!!\n\n").to_stdout
      end
    end
  end

  context 'read detection enabled' do
    before do
      class Product < ActiveRecord::Base
        legacy_column :old_price, :old_name, detect_reads: true
      end
    end

    it 'should recognize detect_reads setting' do
      expect(Product.legacy_column_detect_reads).to eq(true)
    end

    describe 'read access detection' do
      let(:product) do
        # Create product without triggering write detection by using update_attribute
        p = Product.create
        p.update_attribute(:old_price, 100)
        p.update_attribute(:old_name, 'Test Product')
        p
      end

      it 'detects read access to legacy columns' do
        expect {
          product.old_price
        }.to output(/READ of legacy column detected.*Product => old_price.*This column is set as legacy and should not be used anymore/m).to_stdout
      end

      it 'detects read access to multiple legacy columns' do
        expect {
          product.old_name
        }.to output(/READ of legacy column detected.*Product => old_name.*This column is set as legacy and should not be used anymore/m).to_stdout
      end

      it 'still returns the actual attribute value' do
        # Capture output but test return value
        value = nil
        expect {
          value = product.old_price
        }.to output(/READ of legacy column detected/).to_stdout
        expect(value).to eq(100)
      end
    end
  end

  context 'read detection with custom message' do
    before do
      class Item < ActiveRecord::Base  
        legacy_column :old_status, message: 'Stop reading this!', detect_reads: true
      end
    end

    describe 'read access detection with custom message' do
      let(:item) do
        i = Item.create
        i.update_attribute(:old_status, 'active')
        i
      end

      it 'shows custom message for read access' do
        expect {
          item.old_status
        }.to output(/READ of legacy column detected.*Item => old_status.*Stop reading this!/m).to_stdout
      end
    end
  end

  context 'read detection disabled (default)' do
    before do
      class Order < ActiveRecord::Base
        legacy_column :old_total  # detect_reads defaults to false
      end
    end

    it 'should not detect reads when disabled' do
      expect(Order.legacy_column_detect_reads).to eq(false)
    end

    describe 'no read access detection' do
      let(:order) do
        o = Order.create
        o.update_attribute(:old_total, 50)
        o
      end

      it 'does not detect read access when disabled' do
        expect {
          order.old_total
        }.to_not output.to_stdout
      end

      it 'still returns the actual attribute value' do
        expect(order.old_total).to eq(50)
      end
    end
  end

  context 'combined read and write detection' do
    before do
      class Account < ActiveRecord::Base
        legacy_column :old_balance, message: 'Legacy account field!', detect_reads: true
      end
    end

    describe 'both read and write detection' do
      let(:account) { Account.create }

      it 'detects write access' do
        expect {
          account.update(old_balance: 1000)
        }.to output("\n\nUSE of legacy column detected.\n  Account => old_balance\n  Legacy account field!\n\n").to_stdout
      end

      it 'detects read access' do
        account.update_attribute(:old_balance, 1000)  # Set without triggering write detection
        expect {
          account.old_balance
        }.to output(/READ of legacy column detected.*Account => old_balance.*Legacy account field!/m).to_stdout
      end
    end
  end
end
