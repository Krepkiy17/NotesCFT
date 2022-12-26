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
    
    public var callbackNew: ((String, String) -> Void)? // Для передачи заголовков и текстов новых заметок обратно в общий список заметок
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.placeholder = Constants.headerPlaceholder
        header.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            guard let headerText = header.text, !headerText.isEmpty, !headerText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty, !body.text.isEmpty, !body.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return } // Проверки текстов на nil, пустоту и двойной пробел
            callbackNew?(headerText, body.text) // Сохраняем заметки автоматом после выхода из заметки
        }
    }
}
