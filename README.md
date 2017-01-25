# Design Patterns
Design Patterns in Swift

## Creational
### Singleton
Maybe the best known design pattern. It guaraties that only one object of a given type exists in the application. The singleton pattern solves both the real-world object and shared resource encapsulation tasks by assuring that there is only ever one instance of a class in an application (as the application itself). This object is shared between all of the components that require its functionality.

The singleton pattern should be used when creating further objects doesn’t increase the number of real-world resources (for example, printer or master switch) available or when you want to consolidate an activity such as logging or dealing with a file manager. The singleton pattern isn’t useful if there are not multiple components that require access to a shared resource or if there are no objects that represent real-world resources in the application.

#### Implementation
When implementing the singleton pattern, there are some important things to check:
* The singleton must be the only instance of its type that exists.
* The singleton cannot be replaced by another object, even of the same type. 
* The singleton must be locatable by the components that need to use it.

The pattern has been correctly implemented when there is only one instance of a given type and when that instance cannot be copied and cloned and when further instances cannot be created. The main pitfalls are using reference types (which can be copied) or classes that implement the NSCopying protocol (which can be cloned).

#### Example:

```swift

class Application {

    static let sharedInstance = Application()
    
    // Private initializer ensures that no one outside can initialize an instance of the class.
    private init() {
        // Initialization code.
    }
}
```

#### Usage:

```swift

let window = Application.sharedInstance.window
```











## Sources:
1. [Pro Design Patterns in Swift. Adam Freeman](http://www.apress.com/us/book/9781484203958)
