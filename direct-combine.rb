require 'bunny'

# direct
#
puts "direct queue: start "
connection = Bunny.new
connection.start 
channel = connection.create_channel
queue = channel.queue('testdirect')
puts "direct queue: connection #{channel.status}"

# number of messages 
size = rand(1..30)

# produce
direct_queue_loop = 0
while ( direct_queue_loop != size ) do
 my_message = rand.to_s
 puts "direct queue producer: #{direct_queue_loop} #{my_message} sent"
 channel.default_exchange.publish(my_message, routing_key: queue.name)
 direct_queue_loop += 1
end



# consume
direct_queue_loop = 0
while ( direct_queue_loop != size ) do
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts "direct queue consumer: #{direct_queue_loop} Received #{body}"
    direct_queue_loop += 1
    if direct_queue_loop == size then exit 0 end 
  end
end


channel.close
connection.close
