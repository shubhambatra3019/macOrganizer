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
        
    }
    
    //Mark: To get all the Contents of Directory
    func getContents(path: String) {
        do {
            let files  = try fileManager.contentsOfDirectory(atPath: path)
            for file in files {
                print(file)
            }
        }
        catch {
            print("Error")
        }
    }
    
    //Mark: Organize all the files in the array containing all file name.
    func organizeFiles(files: [String]) {
        
    }
    
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

