
import Foundation

public protocol CellReusableIdentifier {
    static var swiftIdentifier: String { get }
}
extension CellReusableIdentifier {
    public static var swiftIdentifier: String {
        return String(describing: Self.self)
    }
}
