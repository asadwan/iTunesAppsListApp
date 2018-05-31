//
//  Extensions.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/30/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWith(url: URL)  {
        
        self.image = nil
        
        // look up a caches version of the image before downloaing
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // download images in background thread
        let backgroundQueue = DispatchQueue.global(qos: .userInteractive)
        backgroundQueue.async {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if data != nil {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: url.absoluteString as AnyObject)
                        DispatchQueue.main.async {
                            self.image = downloadedImage
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
}

