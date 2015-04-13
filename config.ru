require 'rubygems'
require 'bundler/setup'

require 'sinatra'

DOMAIN_REDIRECTS = {
  'opennorth.ca' => 'www.opennorth.ca',
  'nordouvert.ca' => 'www.nordouvert.ca',
  'blog.opennorth.ca' => 'www.opennorth.ca',
  'blogue.nordouvert.ca' => 'www.nordouvert.ca',
  'popoloproject.com' => 'www.popoloproject.com',
}

get '/*' do
  host = DOMAIN_REDIRECTS[request.host]
  if host
    redirect "#{request.scheme}://#{host}#{request.fullpath}", 301
  else
    400
  end
end

run Sinatra::Application
