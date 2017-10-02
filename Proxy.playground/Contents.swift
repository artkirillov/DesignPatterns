final class Lock: LockingSystem {
    
    func open() {
        print("Unlock")
    }
    
    func close() {
        print("Lock")
    }
}

protocol LockingSystem {
    func open()
    func close()
}

final class ProxyLock: LockingSystem {
    
    private var lock: Lock = Lock()
    
    func open() {
        print("Additional operations...")
        lock.open()
    }
    
    func close() {
        lock.close()
    }
}

let lock = ProxyLock()
lock.open()
