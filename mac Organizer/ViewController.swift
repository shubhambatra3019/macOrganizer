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
    var foldersInOrganized: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //Mark: To get all the Contents of Directory
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
    
    //Mark: Organize all the files in the array containing all file name.
    func organizeFiles(files: [String]) {
        
        
    }
    
    @IBAction func importButton(_ sender: Any) {
        filesArray.removeAll()
        let folderPicker: NSOpenPanel = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        folderPicker.runModal()
        var folderPicked = folderPicker.url
        getContentsOfFolder(folder: folderPicked!)
        checkAndCreateFolder(folderPicked: folderPicked!)
        
        
       /*for file in filesArray {
            let ext = file.fileExtension()
            let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
            if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePDF)) {
            print("Its a PDF")
        }
        }*/
    }
    
    //Mark: Checks if the Organized Folder Already Exists. If not, Creates it.
    
    func checkAndCreateFolder(folderPicked: URL) {
        
        let pathComponent = folderPicked.appendingPathComponent("Organized")
            let filePath = pathComponent.path
            print(filePath)
            if !fileManager.fileExists(atPath: filePath) {
                do {
                    try fileManager.createDirectory(at: pathComponent, withIntermediateDirectories: true, attributes: nil)
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
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
