//
//  Управляет экраном с созданием новой заметки
//
//
//  Created by Кирилл on 24.12.22..
//

import UIKit

final class NewNoteViewController: UIViewController {
    
    @IBOutlet var header: UITextField!
    @IBOutlet var body: UITextView!
    
    public var editingEnded: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.placeholder = Constants.headerPlaceholder
        header.becomeFirstResponder() // Показываем клавиатуру для ввода заголовка заметки
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.saveButton, style: .done, target: self, action: #selector(saveNote))
        
    }
   
    func saveAlert() {
        let alert = UIAlertController(title: Constants.error, message: Constants.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    } // Предупреждение об ошибке на случай если юзер будет сохранять пустые заметки
    
    @objc func saveNote() {
        guard let headerText = header.text, !headerText.isEmpty, !headerText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty, !body.text.isEmpty, !body.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            saveAlert()
            return } // Проверки на nil, пустоту и двойной пробел
        editingEnded?(headerText, body.text)
    }
    
}
