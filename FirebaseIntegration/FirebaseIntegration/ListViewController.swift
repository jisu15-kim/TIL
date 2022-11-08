//
//  NextViewController.swift
//  FirebaseIntegration
//
//  Created by 김지수 on 2022/11/08.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let collectionPath = "Product"
    let documentPath = "Product01"
    let db = Firestore.firestore()
    let data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

    func setupData() {
        db.collection(self.collectionPath).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    print(document.documentID)
                }
            } else {
                print("Error")
            }
        }
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupUI() {

    }
    
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 100)
    }
}
