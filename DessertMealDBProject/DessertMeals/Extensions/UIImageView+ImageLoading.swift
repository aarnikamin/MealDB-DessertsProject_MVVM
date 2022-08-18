//
//  UIImageView+ImageLoading.swift
//  DessertMeals
//


import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
  func downloadImage(urlString: String) {
    let url = URL(string: urlString)
    image = nil
    if let imageReceivedFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        self.image = imageReceivedFromCache
        return
    }
    URLSession.shared.dataTask(with: url!) {
        data, response, error in
          if let response = data {
              DispatchQueue.main.async {
                if let imageSentToCache = UIImage(data: response) {
                    imageCache.setObject(imageSentToCache, forKey: urlString as AnyObject)
                    self.image = imageSentToCache
                } else {
                    self.downloadImage(urlString: "https://imageplaceholder.com/testImage")
                }
              }
          }
     }.resume()
  }
}
