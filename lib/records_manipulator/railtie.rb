module RecordsManipulator
  class Railtie < Rails::Railtie #:nodoc:

    initializer 'records_manipulator.initialize' do |app|
      ActiveSupport.on_load(:active_record) do
        require 'records_manipulator/relation_extension'
        ::ActiveRecord::Relation.send :include, RecordsManipulator::RelationExtension

        require 'records_manipulator/base_extension'
        ::ActiveRecord::Base.send :include, RecordsManipulator::BaseExtension
      end
    end

  end
end
