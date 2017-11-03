import Foundation

protocol Component {
    var id: UInt32 { get }
    func description() -> String
}

final class WashingMachine: Component {
    
    var id = arc4random_uniform(100)
    
    func description() -> String {
        return "WashingMachine-\(id)"
    }
}

final class Computer: Component {
    
    var id = arc4random_uniform(100)
    
    func description() -> String {
        return "Computer-\(id)"
    }
}

final class Speakers: Component {
    
    var id = arc4random_uniform(100)
    
    func description() -> String {
        return "Speakers-\(id)"
    }
}

final class Composite: Component {
    
    private var components: [Component] = []
    
    func add(component: Component) {
        components.append(component)
    }
    
    func remove(component: Component) {
        if let index = components.index(where: { $0.id == component.id }) {
            components.remove(at: index)
        }
    }
    
    var id = arc4random_uniform(100)
    
    func description() -> String {
        return components.reduce("", {"\($0)\($1.description()) "})
    }
}

let computer = Computer()
let smallBox = Composite()
let mediumBox = Composite()
let bigBox = Composite()

smallBox.add(component: WashingMachine())

mediumBox.add(component: Computer())
mediumBox.add(component: Speakers())

bigBox.add(component: smallBox)
bigBox.add(component: mediumBox)
bigBox.add(component: WashingMachine())

print(computer.description())
print(smallBox.description())
print(mediumBox.description())
print(bigBox.description())
