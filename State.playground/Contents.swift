import Foundation

protocol State {
    var description: String { get }
    
    func setTask(_ task: Task)
    
    func startProgress()
    func startTesting()
    func close()
    func open()
}

final class OpenState: State {
    let description = "Opened at \(Date()) "
    private var task: Task?
    
    init() {}
    
    func setTask(_ task: Task) {
        self.task = task
    }
    
    func startProgress() { task?.setState(InProgressState()) }
    func startTesting() { print("--- Needs to start progress.")}
    func close() { task?.setState(CloseState()) }
    func open() { print("--- Already opened. Do nothing.")}
}

final class InProgressState: State {
    let description = "In progress: \(Date()) "
    private var task: Task?
    
    init() {}
    
    func setTask(_ task: Task) {
        self.task = task
    }
    
    func startProgress() { print("--- Already in progress.") }
    func startTesting() { task?.setState(InTestingState()) }
    func close() { print("--- Needs to be tested first.") }
    func open() { task?.setState(OpenState()) }
}

final class InTestingState: State {
    let description = "Testing: \(Date()) "
    private var task: Task?
    
    init() {}
    
    func setTask(_ task: Task) {
        self.task = task
    }
    
    func startProgress() { task?.setState(InProgressState()) }
    func startTesting() { print("--- Already in testing.") }
    func close() { task?.setState(CloseState()) }
    func open() { print("--- Needs to be closed first.") }
}

final class CloseState: State {
    let description = "Closed at \(Date()) "
    private var task: Task?
    
    init() {}
    
    func setTask(_ task: Task) {
        self.task = task
    }
    
    func startProgress() { task?.setState(InProgressState()) }
    func startTesting() { print("--- Needs to be opened first.") }
    func close() { print("--- Already closed.") }
    func open() { task?.setState(OpenState()) }
}

final class Task {
    var history = "\n Task history:\n"
    private var state: State
    
    init() {
        state = OpenState()
        state.setTask(self)
        history += state.description
        print("--- \(state.description)")
    }
    
    func setState(_ state: State) {
        self.state = state
        state.setTask(self)
        history += state.description
        print("--- \(state.description)")
    }
    
    func startProgress() { state.startProgress() }
    func startTesting()  { state.startTesting() }
    func close()         { state.close() }
    func open()          { state.open() }
}

let task = Task()
task.startProgress()
task.startTesting()
task.open()
task.close()
task.startTesting()
task.startProgress()

print(task.history)
