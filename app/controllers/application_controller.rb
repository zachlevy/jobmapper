class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'parse-ruby-client'
  Parse.init :application_id => "7pw4FPFfdNZa3BokXn29zXGbLg7nP9DYwUDY9Err",
            :api_key        => "e9Sj3tqLr1wQnkGaY4b1Wz0owo1zymmQPTEsElIE",
            :quiet           => true | false 
end
