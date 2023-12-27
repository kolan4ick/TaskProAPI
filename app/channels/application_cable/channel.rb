module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def current_application_context
      @current_application_context ||= ApplicationContext.new(self)
    end
  end
end
