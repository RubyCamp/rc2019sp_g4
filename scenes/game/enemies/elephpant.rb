require_relative '../enemy.rb'
class Elephpant < Enemy
    def initialize
        super
        @img = Image.load('images/elephpant.png')
    end
end