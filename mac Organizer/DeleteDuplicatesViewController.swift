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
    var filesURL: [URL] = []
    
    func getFileNamesWithoutExtenion(folder: URL) {
        do {
            filesArray.removeAll()
            filesURL.removeAll()
            let files = try fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            filesURL = files
            for file in files {
                filesArray.append(file.lastPathComponent)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func isDuplicate(file: String) -> Bool {
        
        let fileName = file.fileName()
        print("fileName")
        return true
        
    }
    
    func deleteDuplicates(files: [String]) {
        var i = 0
        for file in files {
            let length = file.characters.count
            //print(length)
            if(length >= 3) {
                if(file[length-1] == ")" && file[length-3] == "(") {
                    NSWorkspace.shared.recycle([filesURL[i]], completionHandler: { (trashedFiles, error) in
                        if(error != nil) {
                            print(error)
                        }
                        else {
                            print("Moved to trash")
                        }
                    })
                }
            }
            i = i+1
        }
    }
    
    
    
 /*   func deleteZipFiles(files: [String]) {
        var i = 
    }
    */
    
    
    @IBAction func importButton(_ sender: Any) {
       
        let folderPicker: NSOpenPanel = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        let button = folderPicker.runModal()
        if(button.rawValue == NSOKButton) {
            var folderPicked = folderPicker.url
            getFileNamesWithoutExtenion(folder: folderPicked!)
            deleteDuplicates(files: filesArray)
        
        }
    }
    
    
}
