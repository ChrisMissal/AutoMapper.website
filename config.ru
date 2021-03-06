require 'toto'
require './site'

use Rack::CommonLogger

use Rack::Static, :urls => ['/css', '/img', '/favicon.ico'], :root => 'public'

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

Toto::Paths[:templates] = "dorothy/templates"
Toto::Paths[:pages]     = "dorothy/templates/pages"
Toto::Paths[:articles]  = "dorothy/articles"

#
# Create and configure a toto instance
#
toto = Toto::Server.new do

	set :author, "Jimmy Bogard"
	set :title, "AutoMapper Blog"
	set :date, lambda {|now| now.strftime("%d %b %Y") }
	set :summary,   :max => 500
	set :root, "index"
	set :prefix, "blog"
	set :disqus, "automapper"
	set :url, 'http://automapper.org'
	set :markdown,  :smart
end

map '/blog' do
  run toto
end

map "/" do
  run HomeApp
end
