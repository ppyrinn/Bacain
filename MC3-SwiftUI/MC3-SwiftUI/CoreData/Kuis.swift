//
//  Kuis.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 23/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Kuis: NSManagedObject, Identifiable{
    @NSManaged public var idMurid:  UUID
    @NSManaged public var idKuis:  UUID
    @NSManaged public var tanggalKuis: Date

    
}


extension Kuis{
    static func getAllKuis() -> NSFetchRequest<Kuis>{
        let request: NSFetchRequest<Kuis> = Kuis.fetchRequest() as! NSFetchRequest<Kuis>
        
        let sort = NSSortDescriptor(key: "tanggalKuis", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
}

class Jawaban: NSManagedObject, Identifiable{
    @NSManaged public var idJawaban:  UUID
    @NSManaged public var idKuis:  UUID
    @NSManaged public var ejaan: String
    @NSManaged public var score: Int64
}


extension Jawaban{
    static func getAllJawaban() -> NSFetchRequest<Jawaban>{
        let request: NSFetchRequest<Jawaban> = Jawaban.fetchRequest() as! NSFetchRequest<Jawaban>
        
        let sort = NSSortDescriptor(key: "tanggalKuis", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
}
