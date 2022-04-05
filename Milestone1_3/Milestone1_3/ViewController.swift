//
//  ViewController.swift
//  Milestone1_3
//
//  Created by Konrad Cureau on 05/04/2022.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for item in items.sorted() {
            if item.hasSuffix("@2x.png") {
                flags.append(item)
            }
        }
        print(flags)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        let flagLabel = flags[indexPath.row].replacingOccurrences(of: "@2x.png", with: "").uppercased()
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(named: flags[indexPath.row])
        content.text = flagLabel

        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row]
            vc.selectedImageTitle = flags[indexPath.row].replacingOccurrences(of: "@2x.png", with: "").uppercased()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

