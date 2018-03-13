//
//  DeleteDuplicatesViewController.swift
//  mac Organizer
//
//  Created by Shubham Batra on 06/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Cocoa

class DeleteDuplicatesViewController: NSViewController {

    let fileManager:FileManager = FileManager()
    var filesArray: [String] = []
    
    func getFileNamesWithoutExtenion(folder: URL) {
        do {
            filesArray.removeAll()
            let files = try fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for file in files {
                filesArray.append(file.deletingPathExtension().lastPathComponent)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    

    @IBAction func importButton(_ sender: Any) {
       
        let folderPicker: NSOpenPanel = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        let button = folderPicker.runModal()
        if(button.rawValue == NSOKButton) {
            var folderPicked = folderPicker.url
            getFileNamesWithoutExtenion(folder: folderPicked!)
            for file in filesArray {
                
            }
        
        }
    }
    
    
}
