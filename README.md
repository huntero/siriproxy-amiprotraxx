#siriproxy-amiprotraxx

A [SiriProxy](https://github.com/plamoni/SiriProxy) plugin to control an Alcorn McBride ProTraXX.  Just a few commands are implemented right now, but it's really just for demonstration purposes anyway.

##Install Instructions
To use, copy the contents of `config-info.yml` to your SiriProxy `~/.siriproxy/config.yml` file.  Set traxxIP to the IP address of your Protraxx.  You can leave traxxPort at the default of 2638.

##Supported Commands
###Play File to Channel
"Play file {number} to channel {number}"

###Play File to Channel Pair
"Play file {number} to channel pair {number}"

###Stop Channel
"Stop channel {number}"

###Stop Channel Pair
"Stop channel pair {number}"

##Support
Please don't do anything crazy...like try and use this to control an actual show.  SiriProxy is finicky.
