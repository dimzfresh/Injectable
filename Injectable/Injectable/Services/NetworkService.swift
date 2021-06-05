import Foundation

protocol NetworkProtocol {
    func request()
}

final class NetworkService: NetworkProtocol {
    func request() {
        print("Make request")
    }
}
