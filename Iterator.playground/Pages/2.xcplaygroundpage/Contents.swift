final class Destination {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

final class DestinationList: Sequence {
    var destinations: [Destination]
    
    init(destinations: [Destination]) {
        self.destinations = destinations
    }
    
    func makeIterator() -> DestinationIterator {
        return DestinationIterator(destinationList: self)
    }
}

final class DestinationIterator: IteratorProtocol {
    private var current = 0
    private let destinations: [Destination]
    
    init(destinationList: DestinationList) {
        self.destinations = destinationList.destinations
    }
    
    func next() -> Destination? {
        let next = current < destinations.count ? destinations[current] : nil
        current += 1
        return next
    }
}

final class DestinationIterator2: IteratorProtocol {
    private var current: Int
    private let destinations: [Destination]
    
    init(destinationList: DestinationList) {
        self.destinations = destinationList.destinations
        self.current = destinations.count - 1
    }
    
    func next() -> Destination? {
        let next = current >= 0 ? destinations[current] : nil
        current -= 1
        return next
    }
}

let list = DestinationList(destinations: [
    Destination(name: "Destination 1"),
    Destination(name: "Destination 2"),
    Destination(name: "Destination 3")
    ]
)

for destination in list {
    print(destination.name)
}

list.forEach { print($0.name) }
