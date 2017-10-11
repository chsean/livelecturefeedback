require 'myo'
require 'io/console'


class TestsController < ApplicationController

  def new


    Myo.connect do |myo|
      myo.on :connected do
        puts "Myo connected!"
      end

      myo.on :unlocked do |notsure|
        puts "unlocked?"

      end

      myo.on :pose do |pose, edge|
        x = 0
        if pose == 'wave_out' then
          x = -1 #slow down
        elsif pose == 'wave_in' then
          x = 1
        end
        
        TeachersController.new.feedback(x)
        puts "#{pose}: #{edge}"
      end

      myo.on :periodic do |orientation|
        # puts orientation.accel.x
      end
    end
  end




  # Reads keypresses from the user including 2 and 3 escape character sequences.
  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  # oringal case statement from:
  # http://www.alecjacobson.com/weblog/?p=75
  def show_single_key
    c = read_char

    case c
    when " "
      puts "SPACE"
    when "\t"
      puts "TAB"
    when "\r"
      puts "RETURN"
    when "\n"
      puts "LINE FEED"
    when "\e"
      puts "ESCAPE"
    when "\e[A"
      puts "UP ARROW"
    when "\e[B"
      puts "DOWN ARROW"
    when "\e[C"
      puts "RIGHT ARROW"
    when "\e[D"
      puts "LEFT ARROW"
    when "\177"
      puts "BACKSPACE"
    when "\004"
      puts "DELETE"
    when "\e[3~"
      puts "ALTERNATE DELETE"
    when "\u0003"
      puts "CONTROL-C"
      exit 0
    when /^.$/
      puts "SINGLE CHAR HIT: #{c.inspect}"
    else
      puts "SOMETHING ELSE: #{c.inspect}"
    end
  end

#puts "crap before show"
#show_single_key while(true)

end #end class
