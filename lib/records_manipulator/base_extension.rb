module RecordsManipulator
  module BaseExtension

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def manipulate(&block)
        relation.manipulate(&block)
      end
    end

  end
end
