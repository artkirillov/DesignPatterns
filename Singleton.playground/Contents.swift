final class Singleton {
    
    static let shared = Singleton()
    
    private init() {
        
    }
    
    var value: Int = 0
    
    func doSomething() {
        print("Doing something with value \(value)")
    }
}

var object = Singleton.shared
object.value = 1000

var secondObject = Singleton.shared
secondObject.value = 2000

object.doSomething()
secondObject.doSomething()

print(object === secondObject)

//var thirdObject = Singleton()
//thirdObject.value = 9999
//thirdObject.doSomething()
//print(object === thirdObject)
//print(secondObject === thirdObject)
