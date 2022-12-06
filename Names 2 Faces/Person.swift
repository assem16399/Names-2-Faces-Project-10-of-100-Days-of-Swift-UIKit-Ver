//
//  Person.swift
//  Names 2 Faces
//
//  Created by Aasem Hany on 05/12/2022.
//

import UIKit

class Person: NSObject {

    var name: String
    var image: String
    
    init(name:String, image:String)
    {
        self.name = name
        self.image = image
    }
}


