# frozen_string_literal: true

module ApplicationHelper
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

  def generate_slug_number
    (0...10).map { ('0'..'9').to_a[rand(10)] }.join
  end
end