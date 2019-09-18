require 'bunny'

connection = Bunny.new
connection.start
channel = connection.create_channel
queue = channel.queue('testqueue')

size = rand(1..100)

while ( size != 0 ) do
 channel.default_exchange.publish(rand.to_s, routing_key: queue.name)
 size -= 1
 puts "message #{size} sent"
end

channel.close
connection.close
