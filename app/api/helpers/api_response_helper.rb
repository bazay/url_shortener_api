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

    def say_unprocessable_entity_for(model)
      say_unprocessable_entity
      present_model_errors model, Entities::Errors::UnprocessableEntity
    end

    private

    def present_model_errors(model, error_presenter)
      model.errors.messages
      present model, with: error_presenter
    end

    def set_api_host!
      Rails.application.default_url_options[:host] = request.host_with_port
    end
  end
end
