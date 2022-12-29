//
//  ViewController.swift
//  NetworkTest
//
//  Created by 김지수 on 2022/12/27.
//

import UIKit

class ViewController: UIViewController, CreateVCDelegate {
    
    var model: [Model] = []
    
    let dataManager = DataManager()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.getNetworkData { model in
            model.forEach { model in
                self.model.append(model)
            }
            self.mainTableView.reloadData()
        }
        setupTableView()
    }
    
    func setupTableView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
    
    func createData(item: Model) {
        model.insert(item, at: 0)
        mainTableView.reloadData()
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CreateViewController") as? CreateViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataCell else { return UITableViewCell() }
        cell.model = self.model[indexPath.row]
        cell.configure()
        return cell
    }
    
    
}

