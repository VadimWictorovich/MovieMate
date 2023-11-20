//
//  SearchByWordsVCViewController.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 20.11.23.
//

import UIKit

final class SearchByWordsVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func seatchAction() {
        
        
    }
    
}

extension SearchByWordsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
}
