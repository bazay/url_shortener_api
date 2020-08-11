module UrlShortenerApi
  module Helpers
    module ApiResponseHelper
      def say_ok
        status :no_content
      end

      def say_not_found
        status :not_found
      end

      def say_unprocessable_entity
        status :unprocessable_entity
      end

      def say_unprocessable_entity_for(form)
        say_unprocessable_entity
        present_form_errors form, Entities::Errors::UnprocessableEntity
      end

      private

      def present_form_errors(form, error_presenter)
        form.errors.messages
        present form, with: error_presenter
      end
    end
  end
end
