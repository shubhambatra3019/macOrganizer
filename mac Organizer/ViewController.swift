//
//  ViewController.swift
//  mac Organizer
//
//  Created by Shubham Batra on 06/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, FileManagerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      //  print(NSHomeDirectory())
        
        let filemanager:FileManager = FileManager()
        do {
        let documentsUrl = try filemanager.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(documentsUrl)
            
        let files  = try filemanager.contentsOfDirectory(atPath: "/Users/shubhambatra/Downloads")
        
            for file in files {
                print(file)
            }
    }
    
        catch {
            print(error.localizedDescription)
        }
    
    }
    
        
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

