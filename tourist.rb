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
      pp flight
      self.search_sequences(flight)
    end

    def self.search_sequences(flight)
      best_time = 24
      best_price = 1000
      total = flight[0][0].to_i
      init = 2
      for i in 1..total
        block_total = flight[init][0].to_i
        block_begin = init+1
        block_end   = init + block_total
        for j in block_begin..block_end
          from = flight[j][0]
          to = flight[j][1]
          #binding.pry
          if (from == "A" and to == "Z")
            flight_time  = (flight[j][3]-flight[j][2])/(60*60)
            flight_price = flight[j][4]
            if (flight_time < best_time)
              best_time = flight_price
            end
            if (flight_price < best_price)
              best_price = flight_price
            end
            puts "mas corta: "
            pp flight[j]
          else
            
          end
          
        end
        init = j+2
      end
    end
  end
  

  class Sequences
    def cheap
    end

    def fast
    end
  end

 
  def initialize(file_name)
    Input.read_file(file_name)
  end


end
require 'time'
require 'pp'
require 'pry'
Tourist.new("sample-input.txt")
