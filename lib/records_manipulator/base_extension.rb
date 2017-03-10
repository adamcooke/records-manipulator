module RecordsManipulator
  module BaseExtension

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def manipulate(&block)
        where('').manipulate(&block)
      end
    end

  end
end
