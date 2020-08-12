module Entities
  module Errors
    class Base < Grape::Entity
      expose :success, documentation: { type: FalseClass }
      expose :errors, documentation: { type: Array[String], is_array: true }

      private

      def success
        false
      end

      def errors
        object.errors.messages
      end
    end
  end
end
