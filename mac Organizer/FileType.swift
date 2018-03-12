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
        
        isAudio(ext: fileName.fileExtension())
    }
    
    class func isPDF(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePDF)) {
           return true
        }
        else {
            return false
        }
    }
    
    class func isImage(ext: String) -> Bool {
        
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeImage)) {
            print("File is a Image")
            return true
        }
        else {
            print("File is not a Image")
            return false
        }
        
    }
    
    class func isAudio(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeAudio)) {
            print("File is a Audio")
            return true
        }
        else {
            print("File is not a audio")
            return false
        }
    }
    
}
