module RecordsManipulator
  module RelationExtension

    def self.included(base)
      base.class_eval do
        alias_method :exec_queries_without_manipulator, :exec_queries
        alias_method :exec_queries, :exec_queries_with_manipulator
        private :exec_queries_with_manipulator
        private :exec_queries_without_manipulator
      end
    end

    def manipulate(&block)
      @manipulators ||= []
      @manipulators << block
      self
    end

    def exec_queries_with_manipulator(&block)
      @records = exec_queries_without_manipulator(&block)
      if @manipulators
        @manipulators.each do |m|
          m.call(@records)
        end
      end
      @records
    end

  end
end
