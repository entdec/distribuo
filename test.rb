require 'uri'
require 'net/http'
require 'json'

appcenter_api_token = '9b1a79fe6078fe40dc5a4e455cd0b3f79487aa93'

def get_apps(api_token)
  host_uri = URI.parse('https://api.appcenter.ms')
  http = Net::HTTP.new(host_uri.host, host_uri.port)
  http.use_ssl = true
  apps_request = Net::HTTP::Get.new('/v0.1/apps')
  apps_request['X-API-Token'] = api_token
  apps_response = http.request(apps_request)
  return [] unless apps_response.is_a?(Net::HTTPOK)

  JSON.parse(apps_response.body)
end

def get_releases(api_token, owner_name, app_name)
  host_uri = URI.parse('https://api.appcenter.ms')
  http = Net::HTTP.new(host_uri.host, host_uri.port)
  http.use_ssl = true
  apps_request = Net::HTTP::Get.new("/v0.1/apps/#{owner_name}/#{app_name}/releases")
  apps_request['X-API-Token'] = api_token
  apps_response = http.request(apps_request)
  return [] unless apps_response.is_a?(Net::HTTPOK)

  JSON.parse(apps_response.body)
end

def get_build_url(api_token, owner_name, app_name, build_id)
  host_uri = URI.parse('https://api.appcenter.ms')
  http = Net::HTTP.new(host_uri.host, host_uri.port)
  http.use_ssl = true
  apps_request = Net::HTTP::Get.new("/v0.1/apps/#{owner_name}/#{app_name}/builds/#{build_id}/downloads/build")
  apps_request['X-API-Token'] = api_token
  apps_response = http.request(apps_request)
  return [] unless apps_response.is_a?(Net::HTTPOK)

  JSON.parse(apps_response.body)
end

puts get_apps(appcenter_api_token)
puts get_releases(appcenter_api_token, 'boxture', 'OMS-ios-beta')
