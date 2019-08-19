require 'bunny'

connection = Bunny.new
connection.start
channel = connection.create_channel
#puts channel.status #open
queue = channel.queue('balls')

size = rand * 10000 
size = size % 100

while ( size != 0 ) do
 channel.default_exchange.publish(rand.to_s, routing_key: queue.name)
end

puts " [x] Sent "
channel.close
#puts channel.status #closed
connection.close

