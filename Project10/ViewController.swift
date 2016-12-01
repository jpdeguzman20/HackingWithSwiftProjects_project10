//
//  ViewController.swift
//  Project10
//
//  Created by Jonathan Deguzman on 11/30/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    // collectionView(_:numberOfItemsInSection:) must return an integer and tell the collection view how many items you want to show in its grid. Here, we want to match the number of people we have entered.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    // collectionView(_:cellForItemAt:) must return an object of type UICollectionViewCell. We create and return the cell for the PersonCell class here.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
        
        // Pull out the person from the people array at the correct position
        let person = people[indexPath.item]
        
        // Replace the cell name with the correct name
        cell.name.text = person.name
        
        // Create a UIImage from the person's image filename and add it to the value from getDocumentsDirectory() so that we have a full path name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        // Adjust the borders
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Pull out the person object from the array index that was tapped
        let person = people[indexPath.item]
        
        // Show an alert asking the user to rename the person
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        // Action to cancel the alert
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Action to save the new name by using a closure to pull out the text field value and assign to it the person's name property.
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            person.name = newName.text!
            
            // Update the collection view
            self.collectionView?.reloadData()
        })
        
        present(ac, animated: true)
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
        
        // Create a Person object
        let person = Person(name: "Unknown", image: imageName)
        // Put it inside our people array
        people.append(person)
        // Reload the collection view to show the new object
        collectionView?.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

