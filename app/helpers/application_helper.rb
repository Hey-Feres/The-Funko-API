# frozen_string_literal: true

#
# Helpers that are used across the application for different concepts
module ApplicationHelper
  #
  # Define the model name trought controller name
  def model_from_controller(controller = '')
    return if controller&.to_s.blank?

    controller = controller.to_s
    controller.split('::').each do |str|
      if str.include?('Controller')
        controller = str
        break
      end
    end

    controller.remove('Controller').singularize.constantize
  end
end