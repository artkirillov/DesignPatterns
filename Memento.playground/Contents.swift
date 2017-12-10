import UIKit

struct Point {
    var x: Double
    var y: Double
}

final class Painter {
    var color: UIColor = .clear
    private(set) var paintedPoints: [Point] = []
    
    var description: String {
        return paintedPoints.reduce("Points: ", { "\($0)(\($1.x); \($1.y)), " })
    }
    
    func paint(points: [Point]) {
        paintedPoints.append(contentsOf: points)
    }
    
    func saveState() -> Memento {
        return PainterMemento(color: color, points: paintedPoints)
    }
    
    func restore(state: Memento) {
        color = state.color
        paintedPoints = state.points
    }
}

protocol Memento {
    var color: UIColor { get }
    var points: [Point] { get }
}

final class PainterMemento: Memento {
    private(set) var color: UIColor
    private(set) var points: [Point]
    
    init(color: UIColor, points: [Point]) {
        self.color = color
        self.points = points
    }
}

final class Caretaker {
    var states: [Memento] = []
    var currentIndex: Int = 0
    var painter: Painter
    
    init(painter: Painter) {
        self.painter = painter
    }
    
    func save() {
        let tail = states.count - 1 - currentIndex
        if tail > 0 { states.removeLast(tail) }
        
        states.append(painter.saveState())
        currentIndex = states.count - 1
        print("Save. \(painter.description)")
    }
    
    func undo(steps: Int) {
        guard steps <= currentIndex else { return }
        
        currentIndex -= steps
        painter.restore(state: states[currentIndex])
        print("Undo \(steps) steps. \(painter.description)")
    }
    
    func redo(steps: Int) {
        let newIndex = currentIndex + steps
        guard newIndex < states.count - 1 else { return }
        
        currentIndex = newIndex
        painter.restore(state: states[currentIndex])
        print("Redo \(steps) steps. \(painter.description)")
    }
}

let painter = Painter()
let caretaker = Caretaker(painter: painter)

painter.paint(points: [Point(x: 0, y: 0), Point(x: 1, y: 1)])
caretaker.save()

painter.paint(points: [Point(x: 2, y: 2), Point(x: 3, y: 3)])
caretaker.save()

painter.paint(points: [Point(x: 4, y: 4), Point(x: 5, y: 5)])
caretaker.save()

painter.paint(points: [Point(x: 6, y: 6)])
caretaker.save()

caretaker.undo(steps: 3)
caretaker.redo(steps: 1)

painter.paint(points: [Point(x: 10, y: 10)])
caretaker.save()

caretaker.undo(steps: 2)

