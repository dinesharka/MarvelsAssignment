//
//  CharacterDetails.swift
//  MarvelsAssignment
//
//  Created by Arka_Rahul on 27/08/21.
//

import Foundation

// MARK: - Home
struct CharacterDetails {
    var description : String?
    var  url: String?
    var type: String?
   
    /// 'model initializing'
    init(description : String?,url: String?,type: String?) {
        self.description = description
        self.url = url
        self.type = type
    }
}
