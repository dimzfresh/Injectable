import UIKit

final class ViewController: UIViewController {

    @Injectable private var networkService: NetworkProtocol

    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.request()

    }
}

