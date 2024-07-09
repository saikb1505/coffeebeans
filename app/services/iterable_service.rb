class IterableService
  include HTTParty
  base_uri 'https://api.iterable.com/api'

  def initialize
    @headers = {
      "Content-Type" => "application/json",
      "Api-Key" => ENV['ITERABLE_API_KEY']
    }
  end

  def create_event(event_name, user_email)
    options = {
      headers: @headers,
      body: {
        eventName: event_name,
        email: user_email,
        dataFields: {}
      }.to_json
    }
    self.class.post('/events/track', options)
  end

  def send_email(user_email)
    options = {
      headers: @headers,
      body: {
        email: user_email,
        campaignId: 12345
      }.to_json
    }
    self.class.post('/email/target', options)
  end
end