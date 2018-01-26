import UIKit

enum BacteriaType: String {
    case cocci
    case bacilli
    case spirilla
}

final class BacteriaSprite {
    let color: UIColor
    let image: UIImage
    let type: BacteriaType
    
    init(color: UIColor, image: UIImage, type: BacteriaType) {
        self.color = color
        self.image = image
        self.type = type
    }
    
    func draw(at point: CGPoint) {
        let address = Unmanaged<BacteriaSprite>
            .passUnretained(self).toOpaque()
        print("Draw new bacteria of type \(type.rawValue.capitalized) with sprite object \(address)")
    }
}

final class BacteriaSpriteFactory {
    
    static private var sprites: [BacteriaType: BacteriaSprite] = [:] {
        didSet {
            print("Amount of sprites has changed to \(sprites.count)")
        }
    }
    
    static func makeBacteriaSprite(for type: BacteriaType) -> BacteriaSprite {
        if let sprite = sprites[type] {
            return sprite
        } else {
            var newSprite: BacteriaSprite
            switch type {
            case .cocci: newSprite = BacteriaSprite(color: .red, image: UIImage(), type: type)
            case .bacilli: newSprite = BacteriaSprite(color: .green, image: UIImage(), type: type)
            case .spirilla: newSprite = BacteriaSprite(color: .blue, image: UIImage(), type: type)
            }
            sprites[type] = newSprite
            return newSprite
        }
    }
}

final class Bacteria {
    var point: CGPoint
    var size: Double
    var sprite: BacteriaSprite
    
    init(point: CGPoint, size: Double, sprite: BacteriaSprite) {
        self.point = point
        self.size = size
        self.sprite = sprite
    }
    
    func draw() {
        sprite.draw(at: point)
    }
}

let bacteriaTypes: [BacteriaType] = [.cocci, .bacilli, .spirilla]

for _ in 0..<1000 {
    let randomType = bacteriaTypes[Int(arc4random_uniform(UInt32(bacteriaTypes.count)))]
    let newBacteriaSprite = BacteriaSpriteFactory.makeBacteriaSprite(for: randomType)
    let newBacteria = Bacteria(point: .zero, size: 0.3, sprite: newBacteriaSprite)
    newBacteria.draw()
}
