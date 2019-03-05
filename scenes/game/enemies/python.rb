require_relative '../enemy.rb'
class Python < Enemy
    def initialize
        super
        @img = Image.load('images/python.png')
    end
end