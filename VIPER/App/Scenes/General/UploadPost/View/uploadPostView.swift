import Foundation
import UIKit

class uploadPostView: UIViewController {

    // MARK: PROPERTIES
    var presenter: uploadPostPresenterProtocol?

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    func initMethods() {
        setupView()
        loadData()
    }
    
    func setupView() {
        view.backgroundColor = .red
    }
    
    func loadData() {
        // LLAMAR AL PRESENTER
        self.presenter?.viewDidLoad()
    }
}


// MARK: - OUTPUT
extension uploadPostView: uploadPostViewProtocol {
    
}
