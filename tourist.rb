class Tourist
  class Input
    def self.read_file(file_name)
      flight = []
      count = 0
      File.open(file_name, "r") do |file|
        file.each_line do |line|
          flight[count] = line.split(" ")
          if flight[count].length == 5
            flight[count][2] = Time.parse(flight[count][2])
            flight[count][3] = Time.parse(flight[count][3])
            flight[count][4] = flight[count][4].to_f
          end
          count += 1
        end
      end
      Sequences.search_sequences(flight)
    end
  end
  class Sequences
    @@departure = "no hay"
    @@check = "no hay"
    def self.search_sequences(flight)
      min_time = 24
      best_price = 1000
      total = flight[0][0].to_i
      init = 2
      for i in 1..total
        @@price = 10000
        block_total = flight[init][0].to_i
        block_begin = init+1
        block_end   = init + block_total
        count = 0 
        flight_time = []
        for j in block_begin..block_end
          flight_time[count] = flight[j]
          count += 1
        end
        flight_time.sort_by!{|h| h[2]}
        pp flight_time
        search_sequences_time(flight_time)
        puts "mas rapido salida #{@@departure}, llegada #{@@check} y cuesta #{@@price_by_time}"
        puts "mas barato salida #{@@departure_by_price}, llegada #{@@check_by_price} y custa #{@@price}"
        min_time = @@final_time if @@final_time < min_time
        init = j+2
      end
    end
    def self.search_sequences_time(flight)
      init, count, @end_, to, time, @@final_time, arrival = "A", 0, "Z", "ZZ", 0, 24, 0
      flight.each do |fly|
        count += 1
        if fly[0] == init
          new_departure = fly[2]
          new_price = fly[4]
          arrival = fly[3]
          if fly[1] == @end_
            chec = fly[3]
            time = (chec - new_departure)/3600
            if @@final_time > time
              @@final_time = time 
              @@check  = chec
              @@departure = new_departure
              @@price_by_time = new_price
            end
            if new_price < @@price
              @@price = new_price
              @@departure_by_price = fly[2]
              @@check_by_price = chec
            end
          else
            routes_recursive(count,fly[1],time,flight,new_departure,new_price,arrival)
          end
        else
        end
      end
      puts @@final_time
    end

    def self.routes_recursive(inicio, to, time, flight, new_departure, new_price, arrival)
      for j in inicio..flight.length-1
       if (flight[j][0] == to and arrival < flight[j][3])
          #price_copy = new_price
          new_price = new_price + flight[j][4]
          arrival = flight[j][3]
          #binding.pry
          if flight[j][1] == @end_
            chec = flight[j][3]
            time = (chec - new_departure)/3600
            if @@final_time > time
              @@final_time = time 
              @@check  = flight[j][3]
              @@departure = new_departure
              @@price_by_time = new_price
            end
            if new_price < @@price
              #binding.pry
              @@check_by_price = flight[j][3]
              @@departure_by_price = new_departure
              #binding.pry
              @@price = new_price
            end
          else
            #new_price = price_copy
            routes_recursive(j+1, flight[j][1], time, flight, new_departure,new_price,arrival)

          end
        else
        end
      end
    end
  end
  def initialize(file_name)
    Input.read_file(file_name)
  end
end
require 'time'
require 'pp'
require 'pry'
Tourist.new("input.txt")
