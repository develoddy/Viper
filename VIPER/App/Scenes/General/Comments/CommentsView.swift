//
//  CommentsView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit

class CommentsView: UIViewController {

    // MARK: Properties
    var presenter: CommentsPresenterProtocol?
    var commentsUI = CommentsUI()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerTableView()
        delegates()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        commentsUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
        commentsUI.tableView.frame = view.bounds
    }
    
    // VIEW -> PRESENTER
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    // SETUP VIEW
    func setupView() {
        self.view.backgroundColor = .systemBackground
        self.commentsUI.tableView.backgroundColor = .systemBackground
        self.view.addSubview(commentsUI)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // REGISTER TABLEVIEW
    func registerTableView() {
        commentsUI.tableView.register(PostCommentsListTableViewCell.self, forCellReuseIdentifier: PostCommentsListTableViewCell.identifier)
        commentsUI.tableView.register(CustomHeaderTableViewCell.self, forCellReuseIdentifier: CustomHeaderTableViewCell.identifier)
    }
    
    // DELEGATES TABLEVIEW
    func delegates() {
        commentsUI.tableView.delegate = self
        commentsUI.tableView.dataSource = self
        commentsUI.typingCommentText.delegate = self
    }
    
    // KEYBOARD
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = userInfo.cgRectValue
            let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
            commentsUI.bottomConstraint?.constant = isKeyBoardShowing ? -keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                guard let renderCount = self.presenter?.presenterNumberOfSections() else { return }
                let indexPath = NSIndexPath(item: renderCount-1, section: 0)
                self.commentsUI.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
            })
        }
    }
}




// MARK: - KEYBOARD DELGATE
extension CommentsView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}




// MARK: - COMMENTS VIEW PROTOCOLS
extension CommentsView: CommentsViewProtocol {
    // TODO: implement view output methods
}



// MARK: - UITABLEVIEW
extension CommentsView: UITableViewDataSource {
    
    // RETURN NUMBER OF SECTIONSfunc tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.presenterNumberOfSections() ?? 0
    }
    
    // RETURN NUMBERS OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
        //return 0
    }
    
    // SHOW DATA CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentsListTableViewCell.identifier, for: indexPath) as! PostCommentsListTableViewCell
        guard let comment = self.presenter?.showCommentsData(indexPath: indexPath) else { return UITableViewCell() }
        cell.setCellWithValuesOf(with: comment)
        return cell
    }
    
    // SHOW DATA HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomHeaderTableViewCell.identifier) as! CustomHeaderTableViewCell
        let post = self.presenter?.showHeaderCommentData(section: section)
        cell.setCellWithValuesOf(with: post)
        return cell
    }
    
    // HEIGHT CELL LIST COMMENTS
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    // HEIGHT HEADER TABLEVIEW
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}

// MARK: UITABLEVIEW
extension CommentsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.deselectRow(at: indexPath, animated: true)
        // print("Did select normal list item")
        // inputTextfield.endEditing(true)
    }
}
