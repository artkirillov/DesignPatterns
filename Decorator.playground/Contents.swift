protocol Coffee {
    func cost() -> Double
    func ingredients() -> String
}

final class Espresso: Coffee {
    
    func ingredients() -> String {
        return "Espresso"
    }

    func cost() -> Double {
        return 100
    }
}

class CoffeDecorator: Coffee {
    
    private var сoffee: Coffee
    
    init(сoffee: Coffee) {
        self.сoffee = сoffee
    }
    
    func ingredients() -> String {
        return сoffee.ingredients()
    }
    
    func cost() -> Double {
        return сoffee.cost()
    }
}

final class Milk: CoffeDecorator {
    
    override func ingredients() -> String {
        return super.ingredients() + ", Milk"
    }
    
    override func cost() -> Double {
        return super.cost() + 20
    }
}

final class Whip: CoffeDecorator {
    
    override func ingredients() -> String {
        return super.ingredients() + ", Whip"
    }
    
    override func cost() -> Double {
        return super.cost() + 30
    }
}

final class Chocolate: CoffeDecorator {
    
    override func ingredients() -> String {
        return super.ingredients() + ", Chocolate"
    }
    
    override func cost() -> Double {
        return super.cost() + 50
    }
}

let espresso = Espresso()
let capuccino = Whip(сoffee: Milk(сoffee: espresso))
let capuccinoWithChocolate = Chocolate(сoffee: capuccino)

print(espresso.ingredients())
print(espresso.cost())

print(capuccino.ingredients())
print(capuccino.cost())

print(capuccinoWithChocolate.ingredients())
print(capuccinoWithChocolate.cost())
