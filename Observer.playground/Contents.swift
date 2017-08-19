protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var id: String { get set }
    func update(value: Int?)
}

final class NewsResource: Observable {
    
    var value: Int? {
        didSet {
            notifyObservers()
        }
    }
    private var observers: [Observer] = []
    
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let index = observers.enumerated().first(where: { $0.element.id == observer.id })?.offset else { return }
        observers.remove(at: index)
    }
    
    func notifyObservers() {
        observers.forEach { $0.update(value: value) }
    }
}

final class NewsAgency: Observer {
    var id = "newsAgency"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("NewsAgency handles updated value: \(value)")
    }
}

final class Reporter: Observer {
    var id = "reporter"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("Reporter. Updated value: \(value)")
    }
}

final class Blogger: Observer {
    var id = "blogger"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("Blogger. New article about value: \(value)")
    }
}

let resource = NewsResource()
let newsAgency = NewsAgency()
let reporter = Reporter()
let blogger = Blogger()

resource.add(observer: newsAgency)
resource.add(observer: reporter)

resource.value = 5

resource.add(observer: blogger)

resource.value = 7

resource.remove(observer: reporter)

resource.value = 11
resource.value = 15
