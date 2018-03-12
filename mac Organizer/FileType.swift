//
//  FileType.swift
//  macOrganizer
//
//  Created by Shubham Batra on 12/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Foundation

class fileType {
    
    class func getFileType(fileName: String) -> String {
        let ext = fileName.fileExtension()
        if(isFolder(ext: ext)) {
            return "Folder"
        }
        else if(isPDF(ext: ext)) {
            return "PDFs"
        }
        else if(isImage(ext: ext)) {
            return "Pictures"
        }
        else if(isDocument(ext: ext)) {
            return "Documents"
        }
        else if(isVideo(ext: ext)) {
            return "Videos"
        }
        else if(isPresentation(ext: ext)) {
            return "Presentation"
        }
        else if(isSpreadsheet(ext: ext)) {
            return "Spreadsheet"
        }
        else if(isAudio(ext: ext)) {
            return "Audio"
        }
        else if(isArchive(ext: ext)) {
            return "Archive"
        }
        else {
            return "Unidentified Object"
        }
    }
    
    class func isFolder(ext:String) -> Bool {
        if(ext == "") {
            return true
        }
        else {
            return false
        }
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
            return true
        }
        else {
            return false
        }
        
    }
    
    class func isAudio(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeAudio)) {
            return true
        }
        else {
            return false
        }
    }
    
    class func isVideo(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeMovie)) {
            return true
        }
        else {
            return false
        }
    }
    
    class func isDocument(ext: String) -> Bool {
    
        if(ext == "pages" || ext == "doc" || ext == "docx" || ext == "txt") {
            return true
        }
        else {
            return false
        }
    }
    
    class func isSpreadsheet(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeSpreadsheet)) {
            return true
        }
        else {
            return false
        }
    }
    
    class func isPresentation(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePresentation)) {
            return true
        }
        else {
            return false
        }
    }
    
    class func isArchive(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeArchive)) {
            return true
        }
        else {
            return false
        }
    }
}
