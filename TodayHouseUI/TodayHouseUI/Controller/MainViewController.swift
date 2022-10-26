//
//  ViewController.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var mainModel: MainModel?
    private let dataManager = DataManager()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupTableView()
    }
    
    private func setupData() {
        self.mainModel = dataManager.getData()
    }
    
    private func setupTableView() {
        mainTableView.register(UINib(nibName: "ADCell", bundle: nil), forCellReuseIdentifier: "ADCell")
        mainTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        mainTableView.register(UINib(nibName: "RecommandCell", bundle: nil), forCellReuseIdentifier: "RecommandCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        //        mainTableView.sectionHeaderHeight = 20
    }
}


extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "ADCell") as? ADCell else { return UITableViewCell()}
                cell.ad = mainModel?.ad
                cell.setupCollectionView()
                return cell
            case 1:
                guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell else { return UITableViewCell()}
                cell.category = mainModel?.category
                cell.setupCollectionView()
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "RecommandCell") as? RecommandCell else { return UITableViewCell()}
            cell.recommandation = mainModel?.recommandation
            cell.setupCollectionView()
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 180
            case 1:
                return 240
            default:
                return UITableView.automaticDimension
            }
        case 1:
            return 650
        default:
            return UITableView.automaticDimension
        }
    }
}
