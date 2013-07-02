#!/usr/bin/env ruby

Dir.glob '*.rb' do |filename|
  require "./#{filename}"
end
