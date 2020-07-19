//
//  Sekolah.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 17/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Sekolah: NSManagedObject, Identifiable{
    @NSManaged public var namaSekolah: String
    @NSManaged public var idSekolah:  UUID
}

extension Sekolah{
    static func getAllSekolah() -> NSFetchRequest<Sekolah>{
        let request: NSFetchRequest<Sekolah> = Sekolah.fetchRequest() as! NSFetchRequest<Sekolah>
        
        let sort = NSSortDescriptor(key: "namaSekolah", ascending: true)
        
        request.sortDescriptors = [sort]
        
        
        return request
        
    }
}
