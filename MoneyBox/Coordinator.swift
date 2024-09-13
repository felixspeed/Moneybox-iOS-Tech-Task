import UIKit

class Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
    func finish() {
        preconditionFailure("Method requires overwrite")
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}


