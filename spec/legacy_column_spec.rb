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
end
