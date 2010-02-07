#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'
# no idea wtf im doing :)

# Load etherpad credentials from config/credentials.yml
# credentials there and allows developers to gitinore that,
# so you don't have to worry about accidentally committing
# your password :)
# End users should feel free to delete the line that reads
# the creds and replace `config['email']` with their email, etc
require 'yaml'
config = YAML::load File.read('config/credentials.yml')
username  = config['username']
email     = config['email']
password  = config['password']

format    = "txt"
path      = "https://#{username}.etherpad.com/ep/account/sign-in?cont=https%3a%2f%2f#{username}.etherpad.com%2f"

agent = WWW::Mechanize.new
agent.get "http://#{username}.etherpad.com" do |signin_page|
  home = signin_page.form_with(:id => 'signin-form') do |form|
    form.email = email
    form.password = password
  end.submit

  pad_list = a.click home.links.text(/View all/)
end


http = Net::HTTP.new("#{username}.etherpad.com")
http.start do |http|
  resp, data = http.get(path, nil)
  cookie = resp.response['set-cookie']
  data = "email=#{email}&password=#{password}"
  headers = {
    'Cookie'       => cookie,
    'Referer'      => 'http://etherpad.com',
    'Content-Type' => 'application/x-www-form-urlencoded'
  }
  resp, data = http.post(path, data, headers)
  pad = 3 # just testing
  getfile = Net::HTTP::Get.new("http://#{username}.etherpad.com/ep/pad/export/#{pad}/latest?format=txt")
  asdf = http.request(getfile)
  ans = asdf.body
  puts ans
end

  
#rescue SocketError
#  raise "Host " + host 
#end
