require 'rubygems'
require 'sinatra/base'
require 'haml'


class WkhtmltopdfDaemon < Sinatra::Base

  get '/' do
    haml :index
  end

  post "/" do
    content_type 'application/pdf'
    uri = URI.parse(params[:url])
    uri.merge! "index.html" if uri.path == ""

    imagequality = params[:imagequality].to_i
    imagequality = 94 if imagequality.nil? || imagequality < 0 || imagequality > 100


    if params[:program] == "1"
      cmd = "wkhtmltopdf-0.10.0_beta4_OS-X.i386 "
      content_type 'application/pdf'
      imagequality = "--image-quality " + imagequality.to_s + " "
    end
    if params[:program] == "2"
      cmd = "wkhtmltoimage-0.10.0_beta4-OS-X.i386 "
      content_type 'image/jpeg'
      imagequality = "--quality " + imagequality.to_s + " "
    end


    command = cmd +
            imagequality +
            uri.to_s + " -"

    %x{#{command}}
  end
end

