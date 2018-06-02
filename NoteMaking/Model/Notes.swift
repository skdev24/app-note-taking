//
//  Notes.swift
//  NoteMaking
//
//  Created by Shivam Dev on 01/06/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class Notes {
    var noteTitle: String
    var noteDetail: String
    var noteImage: UIImage
    var favNote: Bool
    var notesPosition: Int
    
    init(title: String, detials: String, image: UIImage, fav: Bool, position: Int) {
        self.noteTitle = title
        self.noteDetail = detials
        self.noteImage = image
        self.favNote = fav
        self.notesPosition = position
    }
}

