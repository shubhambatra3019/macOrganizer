//
//  ViewController.swift
//  mac Organizer
//
//  Created by Shubham Batra on 06/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, FileManagerDelegate  {

    let fileManager:FileManager = FileManager()
    var filesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContents(path: "/Users/shubhambatra/Downloads")
        
    }

    
    //Mark: To get all the Contents of Directory
    func getContents(path: String) {
        do {
            let files  = try fileManager.contentsOfDirectory(atPath: path)
            for file in files {
                let ext = file.fileExtension()
                print(ext)
            }
            print(files.count)
        }
        catch {
            print("Error")
        }
    }
    
    //Mark: Organize all the files in the array containing all file name.
    func organizeFiles(files: [String]) {
        
        
    }
    
    @IBAction func importButton(_ sender: Any) {
   
        let folderPicker: NSOpenPanel = NSOpenPanel()
        
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        
        folderPicker.runModal()
        
        var chosenFolder = folderPicker.url
        
        print(chosenFolder)
        
        do {
        
        let files = try fileManager.contentsOfDirectory(at: chosenFolder!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        print(files)
        }
        catch {
            print(error.localizedDescription)
        }
    
    }
    
    //Mark: Removes Subdirectories inside the Folder.
    func removeFolders(files: [String]) {
        

        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension String {
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    
}
