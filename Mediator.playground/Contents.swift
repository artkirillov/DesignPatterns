import Foundation

enum Event {
    case stepExecuted
    case angleChanged
    case stabilizationFinished
}

protocol Mediator {
    func notify(sender: Component, event: Event)
}

protocol Component {
    var controller: Mediator? { get set }
}

final class AngleSensor: Component {
    var controller: Mediator?
    var value: Double = 0 {
        didSet {
            controller?.notify(sender: self, event: .angleChanged)
        }
    }
}

final class BodyStabilizer: Component {
    var controller: Mediator?
    
    func stabilize() {
        print("Stabilizing body\n")
        controller?.notify(sender: self, event: .stabilizationFinished)
    }
}

final class MovementRegulator: Component {
    var controller: Mediator?
    var isCancelled = false
    
    func executeStep() {
        guard !isCancelled else { return }
        controller?.notify(sender: self, event: .stepExecuted)
    }
}

final class SystemLogger: Component {
    var controller: Mediator?
    
    func log(pitch: Double) {
        print("Logging pitch \(pitch) degrees")
    }
}

final class CentralController: Mediator {
    
    var pitchAngleSensor: AngleSensor
    var rotateAngleSensor: AngleSensor
    var healingAngleSensor: AngleSensor
    
    var stabilizer: BodyStabilizer
    var movementRegulator: MovementRegulator
    var logger: SystemLogger
    
    init(pitchAngleSensor: AngleSensor,
         rotateAngleSensor: AngleSensor,
         healingAngleSensor: AngleSensor,
         stabilizer: BodyStabilizer,
         movementRegulator: MovementRegulator,
         logger: SystemLogger) {
        
        self.pitchAngleSensor = pitchAngleSensor
        self.rotateAngleSensor = rotateAngleSensor
        self.healingAngleSensor = healingAngleSensor
        
        self.stabilizer = stabilizer
        self.movementRegulator = movementRegulator
        self.logger = logger
    }
    
    func notify(sender: Component, event: Event) {
        switch event {
        case .stepExecuted:
            pitchAngleSensor.value = Double(arc4random_uniform(10))
        case .angleChanged:
            let pitchValue = pitchAngleSensor.value
            logger.log(pitch: pitchValue)
            guard pitchValue > 0 else {
                print("Stabilization is not needed\n")
                return
            }
            stabilizer.stabilize()
        case .stabilizationFinished:
            break
        }
    }
    
    func goForward(steps: Int) {
        var i = 1
        while i <= steps && !movementRegulator.isCancelled {
            print("\(i) step forward")
            movementRegulator.executeStep()
            i += 1
        }
    }
}

let pitchAngleSensor = AngleSensor()
let stabilizer = BodyStabilizer()
let movementRegulator = MovementRegulator()
let logger = SystemLogger()

let controller = CentralController(pitchAngleSensor: pitchAngleSensor,
                                   rotateAngleSensor: AngleSensor(),
                                   healingAngleSensor: AngleSensor(),
                                   stabilizer: stabilizer,
                                   movementRegulator: movementRegulator,
                                   logger: logger)

pitchAngleSensor.controller = controller
stabilizer.controller = controller
movementRegulator.controller = controller
logger.controller = controller

controller.goForward(steps: 5)

