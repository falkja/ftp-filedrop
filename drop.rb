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
    if ENV['destfile'] == nil
        destfile = ''
    elsif ENV['destfile'] != nil
        destfile = ENV['destfile']
    else
        destfile = ''
    end
    ftp = Net::FTP.new(server)
    ftp.login(user,pass)
    if file != 'listonly' then
        # Randomize the target name a bit 
        fileext = file.split('.')[file.split('.').length - 1]
        thefilename = "#{Guid.new.to_s.gsub('-','')[0, 8]}." + fileext
    end
    if dir != nil then
        ftp.chdir(dir)
    end
    if thefilename != nil
        if destfile != ''
            thefilename = destfile
        end
        puts "Sending #{file} as #{thefilename}"        
        ftp.putbinaryfile(file, thefilename)
    end
    ftp.list.each {|file|
        puts file
    }
    ftp.close
end
