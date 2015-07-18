require 'rubygems'
require 'bundler/setup'

require 'sinatra'

DATA = {
  'opennorth.ca' => {
    host: 'www.opennorth.ca',
  },
  'nordouvert.ca' => {
    host: 'www.nordouvert.ca',
  },
  'blog.opennorth.ca' => {
    host: 'www.opennorth.ca',
    root_to: '/archive.html',
    undo_clean_url: true,
  },
  'blogue.nordouvert.ca' => {
    host: 'www.nordouvert.ca',
    root_to: '/archive.html',
    undo_clean_url: true,
  },
  'open511.org' => {
    host: 'www.open511.org',
  },
}

get '/*' do
  config = DATA[request.host]
  if config
    if config[:root_to] && request.fullpath == '/'
      path = config[:root_to]
    elsif config[:undo_clean_url] && request.fullpath != '/' && request.fullpath.end_with?('/')
      path = request.fullpath.chomp('/') + '.html'
    else
      path = request.fullpath
    end
    redirect "#{request.scheme}://#{config.fetch(:host)}#{path}", 301
  else
    400
  end
end

run Sinatra::Application
