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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = noteHeader
        body.text = noteBody
    }
    
}
