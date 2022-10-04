import UIKit

class ProfileUI : UIView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let lineButton: UIButton = {
        let lineButton  = UIButton()
        lineButton.clipsToBounds = true
        lineButton.tintColor = .lightGray
        lineButton.setBackgroundImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        return lineButton
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
    
    func setupView() {
        backgroundColor = .systemBackground
        self.addSubview(activityIndicator)
    }
}
