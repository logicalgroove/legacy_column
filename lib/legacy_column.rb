# usage:
# include LegacyColumn
# legacy_column :pos_type, :pos_user, message: 'Stop what you doing!'

require "active_support/concern"

module LegacyColumn
  extend ActiveSupport::Concern

  included do
    class_attribute :legacy_column_names, instance_writer: false, default: nil
    class_attribute :legacy_column_message, instance_writer: false, default: nil
    class_attribute :legacy_column_detect_reads, instance_writer: false, default: false
  end

  module ClassMethods
    DEFAULT_MESSAGE = 'This column is set as legacy and should not be used anymore.'

    def legacy_column(*columns, message: nil, detect_reads: false)
      return unless columns

      self.legacy_column_names = columns
      self.legacy_column_message = message || DEFAULT_MESSAGE
      self.legacy_column_detect_reads = detect_reads

      send('before_validation', :legacy_column)
      
      if detect_reads
        setup_read_detection(columns)
      end
    end

    private

    def setup_read_detection(columns)
      mod = Module.new do
        columns.each do |column|
          define_method(column) do
            # Log read access
            if defined?(Rails) && Rails.logger
              Rails.logger.warn "\n\nREAD of legacy column detected.\n  #{self.class} => #{column}\n  #{legacy_column_message}\n\n"
            else
              puts "\n\nREAD of legacy column detected.\n  #{self.class} => #{column}\n  #{legacy_column_message}\n\n"
            end
            super()  # Call original getter
          end
        end
      end
      prepend(mod)
    end
  end

  def legacy_column
    legacy_column_names.each do |column|
      if changes_to_save.key?(column.to_s)
        if defined?(Rails) && Rails.logger
          Rails.logger.warn "\n\nUSE of legacy column detected.\n  #{self.class} => #{column}\n  #{legacy_column_message}\n\n"
        else
          puts "\n\nUSE of legacy column detected.\n  #{self.class} => #{column}\n  #{legacy_column_message}\n\n"
        end
      end
    end
  end
end

require "legacy_column/railtie"
