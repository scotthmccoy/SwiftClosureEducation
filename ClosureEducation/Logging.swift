//
//  Logging.swift
//  AutoredirectTool
//
//  Created by Scott McCoy on 3/11/15.
//  Copyright (c) 2015 OpenX. All rights reserved.
//

import Foundation


private let _loggingSemaphore = dispatch_semaphore_create(1)
private var myDateFormatter = NSDateFormatter()



//MARK: OXMDebugLog
public func OXMDebugLogWhereAmI(file: StaticString = __FILE__, line: UWord = __LINE__, column: UWord = __COLUMN__, function: StaticString = __FUNCTION__) {
    
    OXMDebugLogInternal("", file, line, column, function)
}

public func OXMDebugLog(message: String, file: StaticString = __FILE__, line: UWord = __LINE__, column: UWord = __COLUMN__, function: StaticString = __FUNCTION__) {
    
    OXMDebugLogInternal(message, file, line, column, function)
}

internal func OXMDebugLogInternal(message: String, file: StaticString, line: UWord, column: UWord, function: StaticString) {
    //Tokenize file by "/", get the last element
    //TODO: This doesn't print Optional:("Appdelegate.swift") anymore, but I doubt I'm using the ! operator correctly.
    
    let fileString = "\(file)"
    let shortFile = fileString.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "/")).last!
    
    myDateFormatter.dateFormat = "MM-dd HH:mm:ss:SSSS"
    let formattedDate = myDateFormatter.stringFromDate(NSDate())
    
    let threadName = NSThread.isMainThread() ? "[MAIN] " : ""
    
    let message = "\(threadName)\(formattedDate) \(shortFile) \(function) [Line \(line)] \(message)\n"
    

    let logURL = getURLForDoc("log.txt")
    let data = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    
    dispatch_semaphore_wait(_loggingSemaphore, DISPATCH_TIME_FOREVER);


    
    if logURL.checkResourceIsReachableAndReturnError(nil) {
        //File exists
        var err:NSError?
        if let fileHandle = NSFileHandle(forWritingToURL: logURL, error: &err) {
            fileHandle.seekToEndOfFile()
            fileHandle.writeData(data)
            fileHandle.closeFile()
        } else {
            println("Can't open fileHandle \(err)")
        }
    } else {
        //Create the file
        var err:NSError?
        if !data.writeToURL(logURL, options: .DataWritingAtomic, error: &err) {
            println("Can't write \(err)")
        }
    }
    
    print(message)
    dispatch_semaphore_signal(_loggingSemaphore);
}






internal func getURLForDoc(docName:String) -> NSURL {
    
    let fileManager = NSFileManager.defaultManager()
    
    let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    
    let documentDirectory: NSURL = urls.first as! NSURL!

    // This is where the database should be in the documents directory
    let ret = documentDirectory.URLByAppendingPathComponent(docName)
    
    return ret
}

