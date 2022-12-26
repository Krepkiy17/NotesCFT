//
//  Управляет экраном отдельной заметки
//
//  Created by Кирилл on 24.12.22..
//

import UIKit

final class NoteViewController: UIViewController {
    
    @IBOutlet var header: UITextField!
    @IBOutlet var body: UITextView!
    
    public var noteHeader: String = ""
    public var noteBody: String = ""
    
    public var callbackChange: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = noteHeader
        body.text = noteBody
        header.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            guard let headerText = header.text, !headerText.isEmpty, !headerText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty, !body.text.isEmpty, !body.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return } // Проверки текстов на nil, пустоту и двойной пробел - при ошибке остается старый текст
            callbackChange?(headerText, body.text) // Обновляем заметки автоматом после выхода из заметки
        }
    }
}
