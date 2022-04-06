//
//  ViewController.swift
//  Milestone4_6
//
//  Created by Konrad Cureau on 06/04/2022.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptArticle))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(promptClear))
        
        let sender = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [spacer, sender]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Article", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func promptArticle() {
        let ac = UIAlertController(title: "Add an article", message: "What do you want to add ?", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] _ in
            guard let article = ac?.textFields?[0].text else { return }
            self?.addArticle(article)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func addArticle(_ article: String) {
        shoppingList.insert(article, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func promptClear() {
        let ac = UIAlertController(title: "Clear the shopping list", message: "Are you sure ?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: clearShoppingList))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func clearShoppingList(_ action: UIAlertAction? = nil) {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }


}

