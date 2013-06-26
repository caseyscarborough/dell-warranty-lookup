#!/usr/bin/ruby

##
# Author: Casey Scarborough
#
# This is a simple script to pull warranty information from
# Dell's servers about a specific machine.
#
# Usage: ruby dell_warranty.rb <service tag>

require 'savon'

if (ARGV.length != 1)
	puts "Usage: dell_warranty.rb <service tag>"
	abort
end

# Get the service tag
service_tag = ARGV[0]

client = Savon.client(
	# WSDL document for Dell's web service
	:wsdl => "http://xserv.dell.com/services/assetservice.asmx?WSDL",
	
	# Lower timeouts
	:open_timeout => 10,
	:read_timeout => 10,

	# Disable logging
	:log => false
)

# Try to retrieve asset information
result = client.call(:get_asset_information, message: {guid: '12345678-1234-1234-1234-123456789012', applicationName: 'dellwarrantycheck', serviceTags: service_tag})

begin # Try to get header and entitlement data
	header_data = result.body[:get_asset_information_response][:get_asset_information_result][:asset][:asset_header_data]
	entitlement_data = result.body[:get_asset_information_response][:get_asset_information_result][:asset][:entitlements][:entitlement_data]
rescue
	abort "Service tag '#{service_tag}' not found."
end

# Output data
puts "\nModel: " + header_data[:system_type] + " " + header_data[:system_model]
puts "Service Tag: " + header_data[:service_tag]
puts "\n"
puts "Start Date: " + entitlement_data[0][:start_date].strftime("%m-%d-%Y")
puts "End Date: " + entitlement_data[0][:end_date].strftime("%m-%d-%Y")
puts "Days Left: " + entitlement_data[0][:days_left]
puts "\n"
