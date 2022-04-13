//
//  DetailViewController.swift
//  Milestone19_21
//
//  Created by Konrad Cureau on 13/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        toolbarItems = [spacer, delete]
        navigationController?.isToolbarHidden = false
        
        if let note = note {
            textView.text = note.content
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        note?.content = textView.text
        note?.date = Date()
    }
    
    
    @objc func deleteNote() {
        
    }

}
