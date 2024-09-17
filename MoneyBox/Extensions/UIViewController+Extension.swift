import UIKit

extension UIViewController {
    func displayError(_ error: String) {
        let errorView = UIAlertController(
            title: error,
            message: nil,
            preferredStyle: .alert
        )
        errorView.addAction(UIAlertAction(
            title: "Dismiss",
            style: .cancel,
            handler: nil
        ))
        self.present(errorView, animated: true, completion: nil)
    }
}
