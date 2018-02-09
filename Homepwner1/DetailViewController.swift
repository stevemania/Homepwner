//  DetailViewController.swift
//  Homepwner1
//
//  Created by STEVE DURAN on 10/12/17.
//  Copyright © 2017 Steve Duran. All rights reserved.
//
import UIKit

//this will display segue
class DetailViewController: UIViewController, UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    //this will ask for the camera to operate
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        // If the device has a camera, take a picture; otherwise, // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera } else {
            imagePicker.sourceType = .photoLibrary }
        
        imagePicker.delegate = self// ??
        
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    //convienent way to dismiss keyboard when clicking on something else
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //this has a response to the return key 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }
    
    //this assigns items to labels and stack view
    var item: Item! {
        didSet {
            navigationItem.title = item.name }
    }
    //this will give the view access to the imageStore 
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = { let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = "\(item.valueInDollars)"
        dateLabel.text = "\(item.dateCreated)"
        
        //numberFormatter
        valueField.text =
            numberFormatter.string(from: NSNumber(value: item.valueInDollars))
            dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        // Get the item key
        let key = item.itemKey
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    // this rewrites navigation title with Item name
 
    
    //This function will save the information put in by the user
    // the segue disappears so will the data
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        } else { item.valueInDollars = 0}
    }
    
    //saves the saves the photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // Put that image on the screen in the image view
        imageView.image = image
        
        // Take image picker off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    
}
