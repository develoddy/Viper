
import UIKit

class SheetHomePostsUI: UIView {

    public let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemBackground
        //let tableView = UITableView()
        
        return tableView
    }()
    
    // MARK: INIT
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
    }

}
