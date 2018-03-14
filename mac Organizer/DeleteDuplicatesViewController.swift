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
    
    //MARK: Get Contents of Directory
    func getFiles(folder: URL) {
        do {
            filesArray.removeAll()
            filesURL.removeAll()
            let files = try fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            filesURL = files
            for file in files {
                filesArray.append(file.lastPathComponent)
            }
            getContentsOfFolderInDirectories(folder: folder)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getContentsOfFolderInDirectories(folder: URL) {
        
        for file in filesArray {
            if(fileType.getFileType(fileName: file) == "Folder")
            {
                let folderURL = folder.appendingPathComponent(file)
                do {
                    let subFiles = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                    filesURL += subFiles
                    for file in subFiles {
                        filesArray.append(file.lastPathComponent)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
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
    
    //MARK: Deletes Duplicates and Archives
    func CleanMac(files: [String]) {
        var i = 0
        for file in files {
            if(isDuplicate(file: file) || isArchiveFile(file: file)) {
                NSWorkspace.shared.recycle([filesURL[i]], completionHandler: { (trashedFiles, error) in
                    if(error != nil) {
                        print(error)
                    }
                    else {
                        print("Moved to trash")
                    }
                })
            }
            i = i+1
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
            var folderPicked = folderPicker.url
            getFiles(folder: folderPicked!)
            CleanMac(files: filesArray)
        }
    }
    
    
}
