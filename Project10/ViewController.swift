//
//  ViewController.swift
//  Project10
//
//  Created by Jonathan Deguzman on 11/30/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    // collectionView(_:numberOfItemsInSection:) must return an integer and tell the collection view how many items you want to show in its grid.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // collectionView(_:cellForItemAt:) must return an object of type UICollectionViewCell. We create and return the cell for the PersonCell class here.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Use guard to pull out the image from the image picker, and if guard fails we will exit the image immediately. Otherwise, we check for if it is a UIImage.
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        // Create a UUID object and use its uuidString property to extract the unique identifier as a string data type
        let imageName = UUID().uuidString
        
        // Take the URL result of getDocumentsDirectory() and adds the imageName string to a path
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // Convert the UIIMage to a Data object so it can be saved.
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            // Write the new Data object to the file path we just made.
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

