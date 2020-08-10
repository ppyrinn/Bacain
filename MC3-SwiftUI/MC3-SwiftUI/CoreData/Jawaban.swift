//
//  Jawaban.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 04/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Jawaban: NSManagedObject, Identifiable{
    @NSManaged public var idJawaban:  UUID
    @NSManaged public var idKuis:  UUID
    @NSManaged public var ejaan: String
    @NSManaged public var score: Int64
}


extension Jawaban{
    static func getAllJawaban() -> NSFetchRequest<Jawaban>{
        let request: NSFetchRequest<Jawaban> = Jawaban.fetchRequest() as! NSFetchRequest<Jawaban>
        
        let sort = NSSortDescriptor(key: "ejaan", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
    
    static func getJawabanWithId(id: UUID) -> NSFetchRequest<Jawaban>{
        let request: NSFetchRequest<Jawaban> = Jawaban.fetchRequest() as! NSFetchRequest<Jawaban>
            
            let sort = NSSortDescriptor(key: "ejaan", ascending: true)
            
            request.predicate = NSPredicate(format: "idKuis = %@", id as CVarArg)
            
            request.sortDescriptors = [sort]
        
            return request
    }
}
