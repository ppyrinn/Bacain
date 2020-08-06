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
    @NSManaged public var idMuird : UUID
}


extension Jawaban{
    static func getAllJawaban() -> NSFetchRequest<Jawaban>{
        let request: NSFetchRequest<Jawaban> = Jawaban.fetchRequest() as! NSFetchRequest<Jawaban>
        
        let sort = NSSortDescriptor(key: "tanggalKuis", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
}
