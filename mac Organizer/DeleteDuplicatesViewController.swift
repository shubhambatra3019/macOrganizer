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
    
    //MARK: Get Contents of Directory(Deep Enumeration)
    func getFiles(folder: URL) {
        do {
            filesArray.removeAll()
            let files = try fileManager.subpathsOfDirectory(atPath: folder.path)
            for file in files {
                filesArray.append(file)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Checks if file is a Duplicate
    func isDuplicate(file: String) -> Bool {
        let fileName = file.fileName()
        let length = fileName.characters.count
        if(length >= 4) {
            if(fileName[length-1] == ")" && fileName[length-3] == "(") {
                return true
            }
            else if(fileName[length-1] == "y" && fileName[length-2] == "p" && fileName[length-3] == "o" && fileName[length-4] == "c") {
                return true
            }
        }
        return false
    }
    
    //MARK: Checks if file is Archive
    func isArchiveFile(file: String) -> Bool {
        if(fileType.getFileType(fileName: file) == "Archieves") {
            return true
        }
        else {
            return false
        }
    }
    
    //MARK: Get URL from file Name
    func getFileUrl(file: String, relativeFolder: URL) -> URL {
        let fileURL = NSURL(fileURLWithPath: file, relativeTo: relativeFolder)
        return NSURL.fileURL(withPath: fileURL.path!)
    }
    
    //MARK: Deletes Duplicates and Archives
    func CleanMac(files: [String], folder: URL) {
        for file in files {
            if(isDuplicate(file: file) || isArchiveFile(file: file)) {
                let fileURL = getFileUrl(file: file, relativeFolder: folder)
                NSWorkspace.shared.recycle([fileURL], completionHandler: { (trashedFiles, error) in
                    if(error != nil) {
                        print(error?.localizedDescription)
                    }
                    else {
                        print("Moved to trash")
                    }
                })
            }

        }
    }
    
    //MARK: Button to Pick Folder
    @IBAction func importButton(_ sender: Any) {
        let folderPicker: NSOpenPanel = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        let button = folderPicker.runModal()
        if(button.rawValue == NSOKButton) {
            let folderPicked = folderPicker.url
            getFiles(folder: folderPicked!)
            CleanMac(files: filesArray, folder: folderPicked!)
        }
    }
    
    
}
