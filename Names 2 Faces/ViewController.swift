//
//  ViewController.swift
//  Names 2 Faces
//
//  Created by Aasem Hany on 01/12/2022.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCollectionCell else {
            fatalError("Cell Casting Erroe")
        }
        currentCell.personNameLabel.text = "Aasem"
        return currentCell
    }
}

