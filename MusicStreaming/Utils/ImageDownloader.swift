//
//  ImageDownloader.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 28/10/23.
//

import Foundation
import FirebaseStorage

class ImageDownloader {
    
    static func imageDownloader(url: String, callback: @escaping (Data) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let storageRef = Storage.storage().reference(forURL: url)
            storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let data = data {
                    callback(data)
                } else {
                    print(error ?? "error")
                    print("Error: Image could not download!")
                }
            }
        }
    }
}
