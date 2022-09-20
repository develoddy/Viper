
import Foundation
import UIKit

class CommentsView: UIViewController {

    // MARK: Properties
    var presenter: CommentsPresenterProtocol?
    var commentsUI = CommentsUI()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        commentsUI.tableView.frame = view.bounds
        commentsUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
    }
    
    func initMethods() {
        setupView()
        registerTableView()
        delegates()
        loadData()
        configurationButtonComment()
    }
    
    // VIEW -> PRESENTER
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    // SETUP VIEW
    func setupView() {
        view.backgroundColor = .clear
        self.view.addSubview(commentsUI)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func configurationButtonComment() {
        var configuration = UIButton.Configuration.filled()
        configuration = UIButton.Configuration.plain()
        configuration.title = "Public"
        configuration.baseBackgroundColor = .systemBackground
        configuration.cornerStyle = .capsule
        configuration.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { action in
            self.didTapComment()
        }))
        self.commentsUI.typingCommentText.rightView = button
        self.commentsUI.typingCommentText.rightViewMode = .always
    }
    
    // LLAMAR AL PRESENTER.
    func didTapComment() {
        guard let textComment = self.commentsUI.typingCommentText.text else {
            return
        }
        self.presenter?.insertComment(textComment: textComment)
    }
    
    // REGISTER TABLEVIEW
    func registerTableView() {
        commentsUI.tableView.register(PostCommentsListTableViewCell.self, forCellReuseIdentifier: PostCommentsListTableViewCell.identifier)
        commentsUI.tableView.register(CustomHeaderTableViewCell.self, forCellReuseIdentifier: CustomHeaderTableViewCell.identifier)
        // DESACTIVAR LA SELECCION UITABLEVIEW
        commentsUI.tableView.allowsSelection = false
    }
    
    // DELEGATES TABLEVIEW
    func delegates() {
        commentsUI.tableView.delegate = self
        commentsUI.tableView.dataSource = self
        commentsUI.typingCommentText.delegate = self
    }
    
    // KEYBOARD
    @objc private func handleKeyboardNotification( notification: NSNotification ) {
        if let userInfo: NSValue = notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue {
            let keyboardFrame = userInfo.cgRectValue
            let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            commentsUI.bottomConstraint?.constant = isKeyBoardShowing ? -keyboardFrame.height+100 : 0
            UIView.animate( withDuration: 0,
                            delay: 0,
                            options: UIView.AnimationOptions.curveEaseOut,
                            animations: {
                self.view.layoutIfNeeded()
            }, completion: { ( completed ) in
                guard let renderCount = self.presenter?.presenterNumberOfSections() else {
                    return
                }
                
                let indexPath = NSIndexPath( item: renderCount - 1, section: 0 )
                self.commentsUI.tableView.scrollToRow( at: indexPath as IndexPath,
                                                       at: .bottom,
                                                       animated: true )
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
    
    // RELOAD UPDATE TABLEVIEW
    func updateUI() {
        DispatchQueue.main.async {
            self.commentsUI.tableView.reloadData()
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.commentsUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.commentsUI.tableView.alpha = 0.0
            })
        }
    }
    
    func stopActivity() {
        //DispatchQueue.main.asyncAfter(deadline: .now()+4) {
        DispatchQueue.main.async {
            self.commentsUI.activityIndicator.stopAnimating()
            self.commentsUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.commentsUI.tableView.alpha = 1.0
            })
        }
    }
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
        cell.delegate = self
        return cell
    }
    
    // SHOW DATA HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomHeaderTableViewCell.identifier) as! CustomHeaderTableViewCell
        let post = self.presenter?.showHeaderCommentData()
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
    
    /*
     * ------- SE CREA DOS ACCIONES --------
     * EN LA FILA DE COMENTARIOS SE CREA DOS ACCIONES QUE SERÁ DE
     * MODIFICACIÓN DE COMENTARIO O BORRADO.
     */
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let comment = self.presenter?.showCommentsData(indexPath: indexPath) else { fatalError("xxx") }
        let contextUpdateAction = UIContextualAction(style: .normal, title: "update") { (contextualAction, view, boolValue) in
            self.updateAction(comment: comment, indexPath: indexPath)
        }
        
        let contextDeleteAction = UIContextualAction(style: .destructive, title: "delete") { (contextualAction, view, boolValue) in
            self.deleteAction(comment: comment, indexPath: indexPath)
        }
        
        contextDeleteAction.backgroundColor = .red
        contextUpdateAction.backgroundColor = .blue
        
        let swipeActions: UISwipeActionsConfiguration
        
        // EN ESTE PUNTO SE COMPRUEBA SI EL AUTOR DE LA PUBLICACIÓN
        // ESTÁ ENTRE LOS COMENTARIOS Y DEPENDIENDO DE ESO SE COMPRUEBA SI PUEDE MODIFICAR EL CONTENIDO
        // DE SU COMENTARIO O NO.
        let user = self.presenter?.showHeaderCommentData().user
        if user?.id != comment.userID {
            swipeActions = UISwipeActionsConfiguration(actions: [contextDeleteAction , contextUpdateAction])
        } else {
            swipeActions = UISwipeActionsConfiguration(actions: [contextDeleteAction])
        }
        return swipeActions
    }
    
    
    /*
     * ------- MODIFICAR COMENTARIO --------
     * EN ESTE PUNTO EL USUARIO DESLIZARÁ LA FILA DEL COMENTARIO
     * PARA QUE MODIFIQUE EL CONTENIDO DE SU COMENTARIO.
     */
    private func updateAction(comment: Comment, indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Update",
                                      message: "Update a comment",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { ( action ) in
            guard let textField = alert.textFields?.first else {
                return
            }
            if let textToEdit = textField.text {
                if textToEdit.count == 0 {
                    return
                }
                // ACTUALIZAR TAMBIEN EN LA BASE DE DATOS.
                // HAY QUE LLAMAR AL PRESENTER.
                self.presenter?.updateComment( indexPath: indexPath, content: textToEdit )
                self.commentsUI.tableView.reloadRows( at: [ indexPath ], with: .automatic )
            } else {
                return
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField()
        guard let textField = alert.textFields?.first else {
            return
        }
        textField.placeholder = "Changed tour comment "
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    

    /*
     * ------- BORRAR COMENTARIO --------
     * EN ESTE PUNTO EL USUARIO DESLIZARÁ LA FILA DEL COMENTARIO
     * PARA QUE BORRAR SU COMENTARIO.
     */
    private func deleteAction(comment: Comment, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete",
                                      message: "Are you sure want to delete comment?",
                                      preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            // ACTUALIZAR TAMBIEN EN LA BASE DE DATOS.
            // HAY QUE LLAMAR AL PRESENTER.
            self.presenter?.deleteRow(indexPath: indexPath)
            self.commentsUI.tableView.deleteRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.async {
                self.commentsUI.tableView.reloadData()
            }
            
        }
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (self.commentsUI.tableView.height-100-scrollView.frame.size.height ) {
            // LLAMAR AL PRESENTER
            //self.presenter?.fetchMoreData()
        }
    }
}



// MARK: - UITABLEVIEW DELEGATE
extension CommentsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.deselectRow(at: indexPath, animated: true)
        // print("Did select normal list item")
        // inputTextfield.endEditing(true)
    }
}


// MARK: - PROTOCOLS
// CELL: POST COMMENT UITABLE VIEWCELL
extension CommentsView: PostCommentsListTableViewCellProtocol {
    func didTapLikeButton(comment: Comment) {
        print("like")
        print(comment)
        // LLAMAR AL PRESENTER
        // INSETAR LIKE EN LA BASE DE DATOS.
    }
    
    
}
