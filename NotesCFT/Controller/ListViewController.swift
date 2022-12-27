//
//  Управляет экраном со списком всех заметок
//
//
//  Created by Kirill Bratukhin © on 22.12.22..
//


import UIKit

final class ListViewController: UIViewController, UITableViewDelegate {
    
    private(set) var headerArray = ["Первая заметка"]
    private(set) var bodyArray = ["Это ваша первая заметка"]
    
    let savedHeaders = UserDefaults.standard
    let savedBodies = UserDefaults.standard // Создаем хранилища для заголовков и текстов заметок
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let headers = savedHeaders.array(forKey: "headerListArray") as? [String] { headerArray = headers }
        
        if let bodies = savedBodies.array(forKey: "bodyListArray") as? [String] { bodyArray = bodies } // Проверяем есть ли в userDefaults сохраненные заметки
        
        title = Constants.notesList
        label.text = Constants.noNotes
        listOfNotes.dataSource = self
        listOfNotes.delegate = self
        self.listOfNotes.isHidden = false
        if headerArray.count == 0 {
            self.listOfNotes.isHidden = true
            self.label.isHidden = false
        }
    }
    
    @IBOutlet var listOfNotes: UITableView!
    @IBOutlet var label: UILabel!
    
    @IBAction func addNewNote() {
        guard let vc = storyboard?.instantiateViewController(identifier: "create") as? NewNoteViewController else { return }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = Constants.newNoteHeader
        vc.callbackNew = { forHeader, forBody in
            self.headerArray.append(forHeader)
            self.bodyArray.append(forBody)
            self.savedHeaders.set(self.headerArray, forKey: "headerListArray")
            self.savedBodies.set(self.bodyArray, forKey: "bodyListArray")
            // Сохранение списка заметок
            self.listOfNotes.isHidden = false
            self.label.isHidden = true
            self.listOfNotes.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfNotes.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = headerArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize:22.0)
        cell.detailTextLabel?.text = bodyArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else { return }
        vc.navigationItem.largeTitleDisplayMode = .never // Для стиля по гайдлайнам Apple HIG
        vc.callbackChange = { forHeader, forBody in
            self.headerArray[indexPath.row] = forHeader
            self.bodyArray[indexPath.row] = forBody
            self.savedHeaders.set(self.headerArray, forKey: "headerListArray")
            self.savedBodies.set(self.bodyArray, forKey: "bodyListArray")
            // Сохранение списка заметок
            self.listOfNotes.isHidden = false
            self.label.isHidden = true
            self.listOfNotes.reloadData()
        }
        vc.noteHeader = headerArray[indexPath.row]
        vc.noteBody = bodyArray[indexPath.row]
        // Передаем в контроллер заголовок и текст заметки
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            headerArray.remove(at: indexPath.row)
            bodyArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.savedHeaders.set(self.headerArray, forKey: "headerListArray")
            self.savedBodies.set(self.bodyArray, forKey: "bodyListArray")
            if headerArray.count == 0 {
                self.listOfNotes.isHidden = true
                self.label.isHidden = false
            }
        }
    }
}
