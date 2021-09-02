//
//  ComicDesModel.swift
//  MarvelsAssignment
//
//  Created by Arka_Rahul on 27/08/21.
//

import Foundation

// MARK: - ComicDesModel

struct ComicDesModel {
    var name : String?
    var  url: String?
    var type: String?
    var id: String?
    var textObjects: String?
    
    /// 'model initializing'
    
    init(name : String?,url: String?,type: String?,id:String?,textObjects:String?) {
        self.name = name
        self.url = url
        self.type = type
        self.id = id
        self.textObjects = textObjects
    }
}

// MARK: - creatorsDesModel

struct creatorsModel {
    var name : String?
    var  url: String?
    var type: String?
    var id: String?
    var textObjects: String?
    
    /// 'model initializing'
    
    init(name : String?,url: String?,type: String?,id:String?,textObjects:String?) {
        self.name = name
        self.url = url
        self.type = type
        self.id = id
        self.textObjects = textObjects
    }
}
