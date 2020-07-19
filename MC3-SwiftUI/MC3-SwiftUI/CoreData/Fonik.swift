//
//  Fonik.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 19/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Fonik: NSManagedObject, Identifiable{
    @NSManaged public var idFonik: UUID
    @NSManaged public var alfabet: String
    @NSManaged public var gambar: String
    @NSManaged public var sound: String

}

extension Fonik{
    static func getAllFonik() -> NSFetchRequest<Fonik>{
        let request: NSFetchRequest<Fonik> = Fonik.fetchRequest() as! NSFetchRequest<Fonik>
        
        let sort = NSSortDescriptor(key: "alfabet", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
}
