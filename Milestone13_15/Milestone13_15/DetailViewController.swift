//
//  DetailViewController.swift
//  Milestone13_15
//
//  Created by Konrad Cureau on 11/04/2022.
//

import UIKit

class DetailViewController: UITableViewController {
    var country: Country!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = country.name
        navigationItem.largeTitleDisplayMode = .never
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Info", for: indexPath)
        tableView.l
    }
    
}
