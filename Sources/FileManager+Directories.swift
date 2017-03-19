//
//  FileManager+Directories.swift
//  FFFoundation
//
//  Created by Florian Friedrich on 18/09/2016.
//  Copyright © 2016 Florian Friedrich. All rights reserved.
//

import class Foundation.FileManager
import struct ObjectiveC.ObjCBool

public extension FileManager {
    public func createDirectoryIfNeeded(at url: URL, attributes: [String: Any]? = nil) throws {
        var isDir: ObjCBool = false
        let exists = fileExists(atPath: url.path, isDirectory: &isDir)
        if !exists || (exists && !isDir.boolValue) {
            try createDirectory(at: url, withIntermediateDirectories: true, attributes: attributes)
        }
    }
}