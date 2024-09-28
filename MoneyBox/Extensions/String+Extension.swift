import Foundation

extension String {
    // Nice!
    var asCurrency: String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.roundingMode = .down
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
