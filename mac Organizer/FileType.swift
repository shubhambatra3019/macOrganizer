//
//  FileType.swift
//  macOrganizer
//
//  Created by Shubham Batra on 12/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Foundation

class fileType {
    
    class func getFileType(fileName: String) {
        
        
    }
    
    class func isPDF(fileName: String) -> Bool {
        let ext = fileName.fileExtension()
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePDF)) {
           return true
        }
        else {
            return false
        }
    }
    
    
    
}
