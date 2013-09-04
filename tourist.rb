class Tourist
  class Input
    def self.read_file(file_name)
      fligth = []
      count = 0
      File.open(file_name, "r") do |file|
        file.each_line do |line|
          fligth[count] = line.split(" ")
          if fligth[count].length == 5
            fligth[count][2] = Time.parse(fligth[count][2])
            fligth[count][3] = Time.parse(fligth[count][3])
            fligth[count][4] = fligth[count][4].to_f

          end
          count += 1
        end
      end
      puts fligth
    end

    def search_cities

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
Tourist.new("sample-input.txt")
