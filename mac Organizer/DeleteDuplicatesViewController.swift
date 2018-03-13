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
    
    

    @IBAction func importButton(_ sender: Any) {
        filesArray.removeAll()
        let folderPicker: NSOpenPanel = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        let button = folderPicker.runModal()
        if(button.rawValue == NSOKButton) {
            var folderPicked = folderPicker.url
            func getContentsOfFolder(folder: URL) {
                do {
                    let files = try fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                    for file in files {
                        filesArray.append(file.lastPathComponent)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        
        }
    }
    
    
}
