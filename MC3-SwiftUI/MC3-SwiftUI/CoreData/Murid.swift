//
//  Murid.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 22/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Murid: NSManagedObject, Identifiable{
    @NSManaged public var namaMurid: String
    @NSManaged public var idMurid:  UUID
    @NSManaged public var idKelas:  UUID
    @NSManaged public var progress:  Int64


}

extension Murid{
    static func getAllMurid() -> NSFetchRequest<Murid>{
        let request: NSFetchRequest<Murid> = Murid.fetchRequest() as! NSFetchRequest<Murid>
        
        let sort = NSSortDescriptor(key: "namaMurid", ascending: true)
        
        request.sortDescriptors = [sort]
        
        
        return request
        
    }
}
