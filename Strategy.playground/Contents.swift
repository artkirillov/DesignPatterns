import UIKit

final class Filter {
    var filterStrategy: FilterStrategy?
    
    func applyFilter(to image: UIImage) {
        filterStrategy?.process(image: image)
    }
}

protocol FilterStrategy {
    func process(image: UIImage) -> UIImage
}

final class SepiaFilter: FilterStrategy {
    func process(image: UIImage) -> UIImage {
        print("Apply SEPIA filter to image")
        return image
    }
}

final class BWFilter: FilterStrategy {
    func process(image: UIImage) -> UIImage {
        print("Apply B&W filter to image")
        return image
    }
}

final class DistortionFilter: FilterStrategy {
    func process(image: UIImage) -> UIImage {
        print("Apply DISTORTION filter to image")
        return image
    }
}

let filter = Filter()
let image = UIImage()

filter.filterStrategy = SepiaFilter()
filter.applyFilter(to: image)

filter.filterStrategy = BWFilter()
filter.applyFilter(to: image)

filter.filterStrategy = DistortionFilter()
filter.applyFilter(to: image)
