//
//  Управляет экраном со списком всех заметок
//
//
//  Created by Кирилл on 22.12.22..
//


import UIKit

final class ListViewController: UIViewController, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerArray = savedHeaders.array(forKey: "headerListArray") as! [String]
        bodyArray = savedBodies.array(forKey: "bodyListArray") as! [String]
        
        title = Constants.notesList
        label.text = Constants.noNotes
        listOfNotes.dataSource = self
        listOfNotes.delegate = self
        //if notes.count == 0 {
        if headerArray.count == 0 {
            self.listOfNotes.isHidden = true
            self.label.isHidden = false} // Скрываем таблицу если заметок нет и показываем юзеру надпись об этом
    }
    
    @IBOutlet var listOfNotes: UITableView!
    @IBOutlet var label: UILabel!
    
    
    //private(set) var notes : [(header: String, body: String)] = [("Первая заметка", "Это ваша первая заметка")]
    
    private(set) var headerArray = ["Первая заметка"]
    private(set) var bodyArray = ["Это ваша первая заметка"]
    
    let savedHeaders = UserDefaults.standard
    let savedBodies = UserDefaults.standard
    
    @IBAction func addNewNote() {
        guard let vc = storyboard?.instantiateViewController(identifier: "create") as? NewNoteViewController else { return }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = Constants.newNoteHeader
        vc.editingEnded = { forHeader, forBody in
            self.navigationController?.popToRootViewController(animated: true)
            self.headerArray.append(forHeader)
            self.bodyArray.append(forBody)
            //self.notes.append((header: forHeader, body: forBody))
            self.savedHeaders.set(self.headerArray, forKey: "headerListArray")
            self.savedBodies.set(self.bodyArray, forKey: "bodyListArray")
            // Сохранение списка заметок
            self.listOfNotes.reloadData()
        }
            navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return notes.count
        return headerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfNotes.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = headerArray[indexPath.row]
        cell.detailTextLabel?.text = bodyArray[indexPath.row]
        //cell.textLabel?.text = notes[indexPath.row].header
        //cell.detailTextLabel?.text = notes[indexPath.row].body
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize:15.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let existingNote = notes[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else { return }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.noteHeader = headerArray[indexPath.row]
        vc.noteBody = bodyArray[indexPath.row]
        //vc.noteHeader = existingNote.header
        //vc.noteBody = existingNote.body // Передаем в контроллер заголовок и текст заметки
        navigationController?.pushViewController(vc, animated: true)
            
        }
}
