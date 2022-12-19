import Foundation
import UIKit

class PicView: UIViewController {

    // MARK: Properties
    var presenter: PicPresenterProtocol?
    var picUI = PicUI()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    private func initMethods() {
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(picUI)
    }
    
    private func loadData() {
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        picUI.frame = view.bounds
    }
}

extension PicView: PicViewProtocol {
    // TODO: implement view output methods
}
