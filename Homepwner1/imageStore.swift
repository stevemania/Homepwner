//
//  imageStore.swift
//  Homepwner1
//
//  Created by STEVE DURAN on 10/13/17.
//  Copyright © 2017 Steve Duran All rights reserved.
//

// images are diffrent everytime so this will get
//works like a dictinoary
// we can remove, delete and retrieve image 
import UIKit
class ImageStore {
    let cache = NSCache<NSString,UIImage>()
    
    
    func setImage(_ image: UIImage, forKey key: String) { cache.setObject(image, forKey: key as NSString)
        // Create full URL for image
        let url = imageURL(forKey: key)
        
        // BRONZE CHALLENGE
        //if let data = UIImagePNGRepresentation(image){
        
        // Turn image into JPEG data
       if let data = UIImageJPEGRepresentation(image, 0.5){
        
        
        // Write it to full URL
        let _ = try? data.write(to: url, options: [.atomic]) }
    }
    
    func image(forKey key: String) -> UIImage? {
       
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
        
        
    func deleteImage(forKey key: String) {
        
        cache.removeObject(forKey: key as NSString)
        let url = imageURL(forKey: key)
        
        //error handling
        do{
            try FileManager.default.removeItem(at: url)
        }catch let deleteError {
            print("Error removing the image from directory: \(deleteError)")
        }
    }
    
    //creates a document directory using URL 
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
        
    }
}
