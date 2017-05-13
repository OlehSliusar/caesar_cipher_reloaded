require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cipher_encrypt(string, shift_size)
  mapping = Hash.new { |h,k| k }.
                 merge(make_map('a', shift_size)).
                 merge(make_map('A', shift_size))
  string.gsub(/./, mapping)
end

def make_map(first_char, shift_size)
  base = first_char.ord
  26.times.with_object({}) { |i,h| h[(base+i).chr] = (base+((i+shift_size) % 26)).chr }
end

get '/' do
  erb :index
end

get '/submit' do
  post = params[:post]
  @message = post[:message]
  @factor = post[:factor]

  @string = caesar_cipher_encrypt(@message, @factor.to_i)
  erb :index
end
