require_relative '../enemy.rb'
class Gopher < Enemy
    def initialize
        super
        @img = Image.load('images/gopher.png')
    end
end