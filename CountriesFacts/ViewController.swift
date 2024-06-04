//
//  ViewController.swift
//  CountriesFacts
//
//  Created by Olha Pylypiv on 03.04.2024.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //performSelector(inBackground: #selector(loadJSON), with: nil)
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            self?.loadJSON()
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.shortDescription
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadJSON() {
        if let url = Bundle.main.url(forResource: "countriesFactsFile", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError(message: "Error loading JSON")
            }
        } else {
            showError(message: "JSON file not found.")
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            //countries = jsonCountries.pages
            countries = jsonCountries.pages.sorted { $0.name < $1.name }
//tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            DispatchQueue.main.async {
                [weak self] in
               self?.tableView.reloadData()
            }
        } else {
            showError(message: "Error decoding JSON")
        }
    }
    
    func showError(message: String) {
        let ac = UIAlertController(title: "Loading error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
