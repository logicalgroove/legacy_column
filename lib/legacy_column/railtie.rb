module LegacyColumn
  if defined?(Rails::Railtie)
    require 'rails'

    class Railtie < Rails::Railtie
      initializer 'legacy_column.extend_active_record' do
        ActiveSupport.on_load(:active_record) do
          LegacyColumn::Railtie.insert
        end
      end
    end
  end

  class Railtie
    def self.insert
      ActiveRecord::Base.send(:include, LegacyColumn)
    end
  end
end
