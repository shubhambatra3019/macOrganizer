//
//  ViewController.swift
//  mac Organizer
//
//  Created by Shubham Batra on 06/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Cocoa

class OrganizeViewController: NSViewController, FileManagerDelegate  {

    let fileManager:FileManager = FileManager()
    
    var filesArray: [String] = []
    
    var foldersInOrganized: [String] = ["Documents", "PDFs", "Pictures", "Audio", "Video", "Spreadsheet", "Presentation", "Archieves", "Duplicates", "Other"]
    
    @IBOutlet var folderPickedLabel: NSTextField!
    
    @IBOutlet weak var InfoLabel: NSTextField!
    
    var folderPicked = ""
    
    let info = "Func: Organizes files in the chosen folder according to the file type. Creates a new folder 'organized' and move unorganized files there in respective filetype folders."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InfoLabel.stringValue = info
        InfoLabel.usesSingleLineMode = false
        InfoLabel.cell?.wraps = true
        NSLayoutConstraint.activate([
            self.view.widthAnchor.constraint(equalToConstant: 500),
            self.view.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    //MARK: Get Contents of Directory
    func getContentsOfFolder(folder: URL) {
        filesArray.removeAll()
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
    
    //MARK: Organize all the files in the array containing all file name.
    func organizeFiles(folderPicked: URL) {
        for file in filesArray {
            let filetype = fileType.getFileType(fileName: file)
            if(filetype != "Folder") {
                let filePath = folderPicked.appendingPathComponent(file)
                var destinationPath = folderPicked.appendingPathComponent("Organized")
                destinationPath = destinationPath.appendingPathComponent(filetype)
                destinationPath = destinationPath.appendingPathComponent(file)
                moveFile(file: file, from: filePath, to: destinationPath)
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
            self.folderPicked = (folderPicker.url?.path)!
            folderPickedLabel.stringValue = (folderPicked)
        }
        else {
            print("Action canceled")
        }
    }
    
    //MARK: Organize Button Pressed
    @IBAction func organizeButtonPressed(_ sender: Any) {
        let folderURL = URL(fileURLWithPath: self.folderPicked)
        getContentsOfFolder(folder: folderURL)
        checkAndCreateFolder(folderPicked: folderURL)
        organizeFiles(folderPicked: folderURL)
        removeEmptyFolders(folderPicked: folderURL)
    }
    
    //MARK: Moves Files
    func moveFile(file: String, from: URL, to: URL) {
        do {
            try fileManager.moveItem(at: from, to: to)
            print("Move Successful")
        }
        catch {
            var destinationUrl = to
            destinationUrl.deleteLastPathComponent()
            destinationUrl.deleteLastPathComponent()
            let randomFileName = generateRandomName(for: file)
            destinationUrl =  destinationUrl.appendingPathComponent("Duplicates").appendingPathComponent(randomFileName)
            do {
                try fileManager.moveItem(at: from, to: destinationUrl)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Remove Empty Folders in Organized
    func removeEmptyFolders(folderPicked: URL) {
        let pathComponent = folderPicked.appendingPathComponent("Organized")
        let filePath = pathComponent.path
        for folder in foldersInOrganized {
            do {
                let subDir = pathComponent.appendingPathComponent(folder)
                let contents = try fileManager.contentsOfDirectory(at: subDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                if(contents.count == 0) {
                    try fileManager.removeItem(at: subDir)
                }
                else {
                    print("Folder has contents")
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Checks if the Organized Folder Already Exists. If not, Creates it.
    func checkAndCreateFolder(folderPicked: URL) {
        let pathComponent = folderPicked.appendingPathComponent("Organized")
        let filePath = pathComponent.path
        if (!fileManager.fileExists(atPath: filePath)) {
            do {
                try fileManager.createDirectory(at: pathComponent, withIntermediateDirectories: true, attributes: nil)
                for folder in foldersInOrganized {
                    let subDirectory = pathComponent.appendingPathComponent(folder)
                    try fileManager.createDirectory(at: subDirectory, withIntermediateDirectories: false, attributes: nil)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        else {
            do {
                for folder in foldersInOrganized {
                    let subDirectory = pathComponent.appendingPathComponent(folder)
                    if(!fileManager.fileExists(atPath: subDirectory.path)) {
                        try fileManager.createDirectory(at: subDirectory, withIntermediateDirectories: false, attributes: nil)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Generates a random new fileName
    func generateRandomName(for file: String) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 10 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        randomString += ".\(file.fileExtension())"
        return randomString
    }
}

//MARK: String Functions
extension String {
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
