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
        title = Constants.titleName
        listOfNotes.dataSource = self // Look for data in View Controller itself
        listOfNotes.delegate = self
    }
    
    @IBOutlet var listOfNotes: UITableView!
    @IBOutlet var lable: UILabel!
    
    private(set) var notes : [(header: String, text: String)] = []
    
    @IBAction func addNewNote() {
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfNotes.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].header
        cell.detailTextLabel?.text = notes[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // code
        
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else { return }
        vc.title = Constants.noteHeader
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
