#!/usr/bin/env ruby
# encoding: UTF-8
server = ENV['ftpserver']
user = ENV['user']
pass = ENV['pass']
file = ENV['file']
dir = ENV['dir']

require 'net/ftp'
require 'guid'

if server != nil then
    ftp = Net::FTP.new(server)
    ftp.login(user,pass)
    if file != 'listonly' then
        # Randomize the target name a bit 
        fileext = file.split('.')[file.split('.').length - 1]
        thefilename = "#{Guid.new.to_s.gsub('-','')[0, 8]}." + fileext
        puts "Sending #{file} as #{thefilename}"
    end
    if dir != nil then
        ftp.chdir(dir)
    end
    if thefilename != nil
        ftp.putbinaryfile(file, thefilename)
    end
    ftp.list.each {|file|
        puts file
    }
    ftp.close
end
