//
//  FileManager.swift
//  DiffTranslations
//
//  Created by Ronaldo Albertini on 07/01/19.
//  Copyright © 2019 Ronaldo Albertini. All rights reserved.
//

import Cocoa

public class FileReader {
    
    public let path: String
    
    fileprivate let file: UnsafeMutablePointer<FILE>!
    
    init?(path: String) {
        self.path = path
        file = fopen(path, "r")
        guard file != nil else { return nil }
    }
    
    public var nextLine: String? {
        var line:UnsafeMutablePointer<CChar>? = nil
        var linecap:Int = 0
        defer { free(line) }
        return getline(&line, &linecap, file) > 0 ? String(cString: line!) : nil
    }
    
    deinit {
        fclose(file)
    }
    
    
}

extension FileReader: Sequence {
    public func  makeIterator() -> AnyIterator<String> {
        return AnyIterator<String> {
            return self.nextLine
        }
    }
}

