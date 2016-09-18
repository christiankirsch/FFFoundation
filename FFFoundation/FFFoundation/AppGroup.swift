//
//  AppGroup.swift
//  FFFoundation
//
//  Created by Florian Friedrich on 18/09/2016.
//  Copyright © 2016 Florian Friedrich. All rights reserved.
//

public struct AppGroup {
    public let identifier: String
    
    #if swift(>=3.0)
    public var dataURL: URL? {
        let fileManager = FileManager.default
        return fileManager.containerURL(forSecurityApplicationGroupIdentifier: identifier)
    }
    #else
    public var dataURL: NSURL? {
        let fileManager = NSFileManager.defaultManager()
        return fileManager.containerURLForSecurityApplicationGroupIdentifier(identifier)
    }
    #endif
    
    #if swift(>=3.0)
    public var userDefaults: UserDefaults? {
        return UserDefaults(suiteName: identifier)
    }
    #else
    public var userDefaults: NSUserDefaults? {
        return NSUserDefaults(suiteName: identifier)
    }
    #endif
}
