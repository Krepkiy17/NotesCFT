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
        title = Constants.headerName
        label.text = Constants.noNotes
        listOfNotes.dataSource = self
        listOfNotes.delegate = self
        if notes.count != 0 {
            self.listOfNotes.isHidden = false
            self.label.isHidden = true}
    }
    
    @IBOutlet var listOfNotes: UITableView!
    @IBOutlet var label: UILabel!
    
    
    private(set) var notes : [(header: String, body: String)] = [("Первая заметка", "Это ваша первая заметка")]
    
    @IBAction func addNewNote() {
        guard let vc = storyboard?.instantiateViewController(identifier: "create") as? NewNoteViewController else { return }
        vc.title = Constants.newNoteHeader
        vc.editingEnded = { forHeader, forBody in
            self.navigationController?.popToRootViewController(animated: true)
            self.notes.append((header: forHeader, body: forBody))
            self.listOfNotes.isHidden = false
            self.label.isHidden = true
            self.listOfNotes.reloadData()
        }
            navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfNotes.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].header
        cell.detailTextLabel?.text = notes[indexPath.row].body
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize:15.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let existingNote = notes[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else { return }
        vc.title = Constants.noteHeader
        vc.noteHeader = existingNote.header
        vc.noteBody = existingNote.body
        navigationController?.pushViewController(vc, animated: true)
            
        }
}
