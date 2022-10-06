import UIKit

class HomeUI: UIView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .blue
        return refreshControl
    }()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
    }
    
    private func setupView() {
        backgroundColor = .white
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }
    
    func configureSpinner() {
        activityIndicator.hidesWhenStopped = true
    }
}
