require_relative '../enemy.rb'
class Dlang < Enemy
    def initialize
        super
        @img = Image.load('images/dlang.png')
    end
end