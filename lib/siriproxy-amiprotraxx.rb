require 'cora'
require 'siri_objects'
require 'pp'
require 'socket'

#######
#This gives basic control of an Alcorn McBride, Inc. ProtraXX.  Obviously, this is just for demo purposes.  
######

class SiriProxy::Plugin::Amiprotraxx < SiriProxy::Plugin
  attr_accessor :traxxIP, :traxxPort

  def initialize(config)
    self.traxxIP = config["traxxIP"]
    self.traxxPort = config["traxxPort"]
  end

  numberWordRegEx = /one|won|two|to|too|three|four|for|five|six|seven|eight|nine/i
  numberRegEx = /#{numberWordRegEx}|[0-9,]*[0-9]/i
  
  #Play file number to channel
  listen_for /Play file (#{numberRegEx}) on channel (#{numberRegEx})/i do |file,channel|

    fileNum = makeNumber(file)
    channelNum = makeNumber(channel)
    say "Playing file #{fileNum} on channel #{channelNum} on ProTraXX", spoken: "Playing file #{fileNum} on channel #{channelNum} on pro tracks"
  
    cmdString = "#{fileNum}c#{channelNum}PL\n"
    s = UDPSocket.new
    s.send(cmdString, 0, self.traxxIP, self.traxxPort)
  
    request_completed
  end

  #Play file number to channel pair
  listen_for /Play file (#{numberRegEx}) on channel pair (#{numberRegEx})/i do |file,channelpair|

    fileNum = makeNumber(file)
    channelPairNum = makeNumber(channelpair)
    say "Playing file #{fileNum} on channel pair #{channelPairNum} on ProTraXX", spoken: "Playing file #{fileNum} on channel pair #{channelPairNum} on pro tracks"
    
    cmdString = "#{fileNum}p#{channelNum}PL\n"
    s = UDPSocket.new
    s.send(cmdString, 0, self.traxxIP, self.traxxPort)
    
    request_completed
  end
  

  #Stop channel
  listen_for /Stop channel (#{numberRegEx})/i do |channel|
    channelNum = makeNumber(channel)
    say "Stopping channel #{channelNum} on ProTraXX", spoken: "Stopping channel #{channelNum} on pro tracks"
    
    cmdString = "c#{channelNum}RJ\n"
    s = UDPSocket.new
    s.send(cmdString, 0, self.traxxIP, self.traxxPort)
  
    request_completed
  end
  
  #Stop channel pair
  listen_for /Stop channel pair (#{numberRegEx})/i do |channelPair|
    channelPairNum = makeNumber(channelPair)
    say "Stopping channel pair #{channelPairNum} on ProTraXX", spoken: "Stopping channel pair #{channelPairNum} on pro tracks"
    
    cmdString = "p#{channelPairNum}RJ\n"
    s = UDPSocket.new
    s.send(cmdString, 0, self.traxxIP, self.traxxPort)
  
    request_completed
  end

  def makeNumber(str)
    case str
    when "one","won"
      num = 1
    when "two","to","too"
      num = 2
    when "three"
      num = 3
    when "four","for"
      num = 4
    when "five"
      num = 5
    when "six"
      num = 6
    when "seven"
      num = 7
    when "eight"
      num = 8
    when "nine"
      num = 9
    else
      num = str
    end
    return num  
  end
end
