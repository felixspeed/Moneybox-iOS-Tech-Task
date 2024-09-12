import UIKit

class Coordinator {
    var children: [Coordinator] = []
    var root: UINavigationController
    
    init(root: UINavigationController) {
        self.root = root
    }
    
    func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator) {
        guard let i = children.firstIndex(where: { $0 == coordinator }) else { return }
        children.remove(at: i)
    }
    
    func start() {
        preconditionFailure("Method requires overwrite")
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}


