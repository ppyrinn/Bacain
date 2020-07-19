//
//  Soal.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 19/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Soal: NSManagedObject, Identifiable{
    @NSManaged public var idSoal: UUID
    @NSManaged public var soal: String
    @NSManaged public var gambarSoal: String
    @NSManaged public var level: String

}

extension Soal{
    static func getAllSoal() -> NSFetchRequest<Soal>{
        let request: NSFetchRequest<Soal> = Soal.fetchRequest() as! NSFetchRequest<Soal>
        
        let sort = NSSortDescriptor(key: "level", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
}
