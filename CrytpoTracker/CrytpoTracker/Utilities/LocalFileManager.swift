//
//  LocalFileManager.swift
//  CrytpoTracker
//
//  Created by Abhijith on 08/03/24.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
            
        guard
            let data = image.pngData(),
            let url = URL(string: "") else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image: \(error)")
        }
    }
    
    func getImage(ImageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(ImageName: ImageName, folderName: folderName),
            FileManager.default.fileExists(atPath: folderName) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory: \(error)")
            }
        }
    }

    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(ImageName: String, folderName: String) -> URL? {
        
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(ImageName + ".png")
    }
}
