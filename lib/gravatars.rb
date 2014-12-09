#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'open-uri'
require 'digest'

EMAIL_LIST = 'http://pastebin.com/raw.php?i=KdDrmNsX'
SAVE_TO = '/home/eelsaid/Desktop/gravatar/'

# read emails from source
emails = open(EMAIL_LIST).read.lines

# iterate over all emails, get the gravatar image
# and save it locally with the email as file name
# but i convert the @ character to a dot .


EMAIL_LIST = 'http://pastebin.com/raw.php?i=KdDrmNsX'
emails = open(EMAIL_LIST).read.lines
gravatar_emails = Array.new
emails.each do |email|
  gravatar_emails << email.strip.downcase
end