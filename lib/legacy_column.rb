# usage:
# include LegacyColumn
# legacy_column :pos_type, :pos_user, message: 'Stop what you doing!'

require "active_support/concern"

module LegacyColumn
  extend ActiveSupport::Concern

  included do
    class_attribute :legacy_column_names, instance_writer: false, default: nil
    class_attribute :legacy_column_message, instance_writer: false, default: nil
  end

  module ClassMethods
    DEFAULT_MESSAGE = 'This column is set as legacy and should not be used anymore.'

    def legacy_column(*columns, message: nil)
      return unless columns

      self.legacy_column_names = columns
      self.legacy_column_message = message || DEFAULT_MESSAGE

      send('before_validation', :legacy_column)
    end
  end

  def legacy_column
    legacy_column_names.each do |column|
      if changed_attributes.key?(column.to_s)
        puts "\n\nUSE of legacy column detected.\n  #{self.class} => #{column}\n  #{legacy_column_message}\n\n"
      end
    end
  end
end

require "legacy_column/railtie"
