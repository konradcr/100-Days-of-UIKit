//
//  ViewController.swift
//  Milestone19_21
//
//  Created by Konrad Cureau on 13/04/2022.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()
    
    var numberNotesLabel: UILabel!
    

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        numberNotesLabel = UILabel()
        numberNotesLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        numberNotesLabel.text = "\(notes.count) notes"
        
        let notesCount = UIBarButtonItem(customView: numberNotesLabel)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        
        toolbarItems = [spacer, notesCount, spacer, compose]
        navigationController?.toolbar.tintColor = .orange
        navigationController?.isToolbarHidden = false
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].content
        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        cell.detailTextLabel?.text = notes[indexPath.row].date.formatted(date: .numeric, time: .omitted)
        cell.detailTextLabel?.textColor = .gray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailNote") as? DetailViewController {
            vc.note = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func createNote() {
        let newNote = Note()
        notes.append(newNote)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailNote") as? DetailViewController {
            vc.note = newNote
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.reloadData()
    }
}

