require 'sinatra'
require 'sinatra/config_file'
require 'aws-sdk'
require 'dynamoid'

ENV['RACK_ENV'] = 'development'

config_file "./config/environment/#{ENV['RACK_ENV']}.yml"

Aws.config.update({
  region: 'us-west-2',
    settings.UseDynamoDBLocal ? 'ACCESS_KEY_ID' : settings.AccessKeyId,
    settings.UseDynamoDBLocal ? 'SECRET_ACCESS_KEY' : settings.SecretAccessKey
  )
})

Dynamoid.configure do |config|
  config.adapter = 'aws_sdk_v2'
  config.namespace = "dynamoid_app_development"
  config.warn_on_scan = true
  config.read_capacity = 5
  config.write_capacity = 5
  config.endpoint = "http://#{ENV['DOCKER_HOST_IP']}:8000" if settings.UseDynamoDBLocal
end

class StockKeepingUnit
  include Dynamoid::Document

  field :name
end

get '/' do
  'Hello world!'
end

post '/sku' do
  content_type :json
  body = JSON.parse request.body.read
  sku = StockKeepingUnit.new(:name => body['name'])
  sku.save
  [200, sku.to_json]
end

get '/sku/:id' do
  content_type :json
  sku = StockKeepingUnit.find(params['id'])
  [200, sku.to_json]
end

delete '/sku/:id' do
  content_type :json
  sku = StockKeepingUnit.find(params['id'])
  sku.delete if sku
  [204, 'OK']
end

put '/sku/:id' do
  content_type :json
  body = JSON.parse request.body.read
  sku = StockKeepingUnit.find(params['id'])
  sku.update(:name => body['name']) if sku
  [200, sku.to_json]
end