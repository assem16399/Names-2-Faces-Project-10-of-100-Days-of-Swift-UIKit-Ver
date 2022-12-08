//
//  ViewController.swift
//  Names 2 Faces
//
//  Created by Aasem Hany on 01/12/2022.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var persons = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .cyan
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    @objc private func addTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        persons.append(Person(name: "Unknown", image: imageName))
        collectionView.reloadData()

        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCollectionCell else {
            fatalError("Cell Casting Error")
        }
        currentCell.personNameLabel.text = persons[indexPath.item].name
        let personImageName = persons[indexPath.item].image
        let personImagePath = getDocumentsDirectory().appendingPathComponent(personImageName)
        currentCell.personImageView.image = UIImage(contentsOfFile: personImagePath.path)
        currentCell.personImageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        currentCell.personImageView.layer.borderWidth = 2
        currentCell.personImageView.layer.cornerRadius = 5
        currentCell.layer.cornerRadius = 9
        return currentCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        askToDeleteOrAdd(indexPath: indexPath, collectionView: collectionView)
    }
    
    func askToDeleteOrAdd(indexPath: IndexPath,collectionView: UICollectionView) {
        let ac = UIAlertController(title: "Select an option", message: "Do you want to edit the name or delete the person?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
            self?.deletePerson(indexPath: indexPath, collectionView: collectionView)
        }))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: {[weak self]_ in
            self?.addPersonName(indexPath: indexPath, collectionView: collectionView)
        }))
        present(ac, animated: true)
    }
    
    func deletePerson(indexPath: IndexPath,collectionView: UICollectionView) {
        persons.remove(at: indexPath.item)
        collectionView.reloadData()
    }
    
    func addPersonName(indexPath: IndexPath,collectionView: UICollectionView) {
        let ac = UIAlertController(title: "Person's Name", message: "Type this person name in here", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: {[weak self, weak ac]_ in
            guard let name = ac?.textFields?[0].text else {return}
            guard let currentCell = collectionView.cellForItem(at: indexPath) as? PersonCollectionCell else {return}
            guard let person = self?.persons[indexPath.item] else {return}
            person.name = name
            currentCell.personNameLabel.text = name
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

