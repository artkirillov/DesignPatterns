final class Destination {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

protocol Iterator {
    func next() -> Destination?
}

final class DestinationList {
    var destinations: [Destination]
    
    init(destinations: [Destination]) {
        self.destinations = destinations
    }
}

final class DestinationIterator: Iterator {
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

final class DestinationIterator2: Iterator {
    private var current = 0
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

var iterator = DestinationIterator(destinationList: list)
var iterator2 = DestinationIterator2(destinationList: list)

while let element = iterator.next(), let element2 = iterator2.next() {
    print("First iterator:  \(element.name)")
    print("Second iterator:  \(element2.name)")
}
