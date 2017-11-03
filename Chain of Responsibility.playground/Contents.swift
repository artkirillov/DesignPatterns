final class Responder {
    private var qa: [String: String]
    private var next: Responder?
    
    init(qa: [String: String]) {
        self.qa = qa
    }
    
    func setNext(_ next: Responder) {
        self.next = next
    }
    
    func answer(for question: String) -> String {
        if let answer = qa[question] {
            print("--- Done.")
            return answer
        } else if let next = next {
            print("--- Can't handle. Processing to the next...")
            return next.answer(for: question)
        }
        print("--- No answer")
        return "Sorry! We'll call you later"
    }
}

final class CallCenter {
    private var answerPhone: Responder
    private var manager: Responder
    private var expert: Responder
    
    init(answerPhone: Responder, manager: Responder, expert: Responder) {
        self.answerPhone = answerPhone
        self.manager = manager
        self.expert = expert
    }
    
    func receiveCall(question: String) {
        print("Answer: \(answerPhone.answer(for: question))")
    }
}

let answerPhone = Responder(qa: [
    "How to turn it on?": "Push the green button",
    "How to turn it off?": "Push the red button"
    ])
let manager = Responder(qa: ["I wanna refresh profile info": "Let's get on with it"])
let expert = Responder(qa: ["Very specific tech question": "Specific answer"])

answerPhone.setNext(manager)
manager.setNext(expert)

let callCenter = CallCenter(answerPhone: answerPhone, manager: manager, expert: expert)
callCenter.receiveCall(question: "How to fire you?")
