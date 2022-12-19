
import Foundation
import UIKit

class BirthdayView: UIViewController {

    // MARK: Properties
    var presenter: BirthdayPresenterProtocol?
    var birthdayUI = BirthdayUI()
    let datePicker = UIDatePicker()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    private func initMethods() {
        setupView()
        tapContinue()
        createDatePicker()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(birthdayUI)
        self.birthdayUI.continueButton.isHidden = true
    }
    
    func createToolBar() -> UIToolbar {
        // TOOlBAR
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // DONE BUTTON
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthdayUI.birthdayText.inputView = datePicker
        birthdayUI.birthdayText.inputAccessoryView = createToolBar()
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.birthdayUI.birthdayText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        self.birthdayUI.continueButton.isHidden = false
    }
    
    private func loadData() {
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        birthdayUI.frame = view.bounds
    }
    
    func tapContinue() {
        let continueButton = birthdayUI.continueButton
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    // TAP LOGIN
    @objc private func didTapContinueButton() {
        presenter?.navigateToPasswordView()
    }
}

extension BirthdayView: BirthdayViewProtocol {
    // TODO: implement view output methods
}
