class EventsController < ApplicationController

  def create_event_a
    user_email = User.first.email
    IterableService.new.create_event('Event A', user_email)
    redirect_to root_path, notice: 'Event A created'
  end

  def create_event_b
    user_email = User.first.email
    IterableService.new.create_event('Event B', user_email)
    IterableService.new.send_email(user_email)
    redirect_to root_path, notice: 'Event B created and email sent'
  end
end