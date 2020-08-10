//
//  JawabanUpdate.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 10/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class JawabanUpdate: NSManagedObject, Identifiable{
    @NSManaged public var idJawaban:  UUID
    @NSManaged public var idKuis:  UUID
    @NSManaged public var ejaan: String
    @NSManaged public var score: Int64
}


extension JawabanUpdate{
    static func getAllJawaban() -> NSFetchRequest<JawabanUpdate>{
        let request: NSFetchRequest<JawabanUpdate> = JawabanUpdate.fetchRequest() as! NSFetchRequest<JawabanUpdate>
        
        let sort = NSSortDescriptor(key: "tanggalKuis", ascending: true)
        
        request.sortDescriptors = [sort]
    
        return request
    }
}
