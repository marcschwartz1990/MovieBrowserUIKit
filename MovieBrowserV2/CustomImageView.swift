//
//  CustomImageView.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/12/22.
//

import UIKit



class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)
    
//    func loadImage(from url: URL) {
//        image = nil
//        
//        addSpinner()
//        
//        if let task = task {
//            task.cancel()
//        }
//        
//        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
//            image = imageFromCache
//            removeFromSuperview()
//            return
//        }
//        
//        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            guard
//                let data = data,
//                let newImage = UIImage(data: data)
//            else {
//                print("Couldn't load image from url: \(url)")
//                return
//            }
//            
//            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
//            
//            DispatchQueue.main.async {
//                self.image = newImage
//                self.removeSpinner()
//            }
//        }
//        
//        task.resume()
//    }
    
    func addSpinner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
