# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Sample Client', redirect_uri: '', scopes: '')

end
