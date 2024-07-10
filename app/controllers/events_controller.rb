class EventsController < ApplicationController

  def create_event_a
    user_email = params[:email]

    if IterableService.new.create_event('Event A', user_email).success?
      redirect_to root_path, notice: 'Event A created'
    else
      redirect_to root_path, alert: 'Failed to create Event A'
    end
  end

  def create_event_b
    user_email = params[:email]
    if IterableService.new.create_event('Event B', user_email).success?
      if IterableService.new.send_email(user_email).success?
        redirect_to root_path, notice: 'Event B created and email sent'
      else
        redirect_to root_path, alert: 'Event B created but failed to send email'
      end
    else
      redirect_to root_path, alert: 'Failed to create Event B'
    end
  end
end