class Item < CPBox
    COLLISION_TYPE = 4
    def initialize(x, y,w,h,m,color=C_RED)
        super
        itemList=["beer","apple","choco"]
        @itemName = itemList[rand(3)]
        itemAddress="images/#{@itemName}.png"
        @image=Image.load(itemAddress)
    end
    def item_name
        @itemName
    end
end