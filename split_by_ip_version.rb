#
# split_ip_by_version.rb
#
#
require 'ipaddr'
require 'pp'

arguments = ARGV

if (arguments.size < 1) then
  puts 'no arguments specified!!!'
#raise(Puppet::ParseError, "get_ipv6(): no arguments specified!")
end
#
v4_arr = Array.new
v6_arr = Array.new
other_arr = Array.new
#
arguments.each do |arg|
# We'll accept an array of strings, or just strings as arguments
if arg.is_a?(Array)
arg.each do |element|
begin
ip = IPAddr.new(element)
v4_arr.push(element) if ip.ipv4?
v6_arr.push(element) if ip.ipv6?
rescue ArgumentError
other_arr.push(element)
next
end # begin/rescue
end # array traversal
elsif arg.is_a?(String)
# This argument is a string
begin
ip = IPAddr.new(arg)
v4_arr.push(arg) if ip.ipv4?
v6_arr.push(arg) if ip.ipv6?
rescue
other_arr.push(arg)
end # begin/rescue
end # string handling
end # argument traversal
#
ret_hash = { 'ipv6' => v6_arr, 'ipv4' => v4_arr, 'other' => other_arr }

pp ret_hash
