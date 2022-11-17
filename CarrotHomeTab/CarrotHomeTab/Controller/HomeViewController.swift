//
//  HomeViewController.swift
//  CarrotHomeTab
//
//  Created by 김지수 on 2022/11/18.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonTapped(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "D") as! DetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
