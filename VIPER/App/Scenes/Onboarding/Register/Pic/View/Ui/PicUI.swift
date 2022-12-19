
import UIKit

class PicUI: UIView {
    let gradient = CAGradientLayer()
    var bottomConstraint: NSLayoutConstraint?
    
    public let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureHeaderView()
        configureFooterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    private func setupView() {
        self.addSubview(headerView)
        self.addSubview(footerView)
    }
    
    func configureHeaderView() {
        headerView.clipsToBounds = true
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBackground.cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = self.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        
        // ADD
    }
    
    func configureFooterView() {
        self.addConstraintWhithFormat(format:"H:|[v0]|",views: footerView)
        self.addConstraintWhithFormat(format:"V:[v0(100)]",views: footerView)
        bottomConstraint = NSLayoutConstraint(
            item: footerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -0)
        self.addConstraint(bottomConstraint!)
        
        // ADD
    }

}
