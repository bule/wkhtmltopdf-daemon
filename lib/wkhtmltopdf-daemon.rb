require 'rubygems'
require 'sinatra/base'
require 'haml'

 
class WkhtmltopdfDaemon < Sinatra::Base
 
  get '/' do
    haml :index
  end

  # whois
  get '/whois' do
    haml :whois
  end

  post '/whois' do
    @host = params[:host]

    haml :whois
  end

  # traceroute
  get '/traceroute' do
    haml :traceroute
  end

  post '/traceroute' do
    @host = params[:host]

    haml :traceroute
  end

  __END__
  @@layout
  %html
    %head
      %title Network Tools
    %body
      #header
        %h1 Network Tools
      #content
        =yield
    %footer
      %a(href='/') Back to index

  @@index
  %p
    Welcome to Network Tools. Below is a list
    of the tools available.
  %ul
    %li
      %h3
        %a(href='/whois') Whois
    %li
      %h3
        %a(href='/traceroute') Traceroute

  @@whois
  %h3 Whois
  %form(action='/whois' method='POST')
    %input(type='text' name='host' value=@host)
    %input(type='submit')
  - if defined?(@results)
    %pre= @results

  @@traceroute
  %h3 Traceroute
  %form(action='/traceroute' method='POST')
    %input(type='text' name='host' value=@host)
    %input(type='submit')
  - if defined?(@results)
    %pre= @results

 
end

