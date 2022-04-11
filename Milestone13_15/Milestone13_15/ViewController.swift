//
//  ViewController.swift
//  Milestone13_15
//
//  Created by Konrad Cureau on 11/04/2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fetchCountries), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    @objc func fetchCountries() {
        if let countriesURL = Bundle.main.url(forResource: "countries", withExtension: "json") {
            if let json = try? Data(contentsOf: countriesURL) {
                let decoder = JSONDecoder()
                if let jsonCountries = try? decoder.decode([Country].self, from: json) {
                    countries = jsonCountries
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
                }
            }
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the countries.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

