//
//  Kelas.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 19/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class Kelas: NSManagedObject, Identifiable{
    @NSManaged public var idKelas: UUID
    @NSManaged public var namaKelas: String
    @NSManaged public var idSekolah:  UUID
}

extension Kelas{
    static func getAllKelas() -> NSFetchRequest<Kelas>{
        let request: NSFetchRequest<Kelas> = Kelas.fetchRequest() as! NSFetchRequest<Kelas>
        
        let sort = NSSortDescriptor(key: "namaKelas", ascending: true)
        
//        request.predicate = NSPredicate(format: "idSekolah = %@", sekolah.idSekolah as CVarArg)
        
        request.sortDescriptors = [sort]
    
        return request
    }
    
    static func getKelasWithId(id: UUID) -> NSFetchRequest<Kelas>{
        let request: NSFetchRequest<Kelas> = Kelas.fetchRequest() as! NSFetchRequest<Kelas>
            
            let sort = NSSortDescriptor(key: "namaKelas", ascending: true)
            
            request.predicate = NSPredicate(format: "idSekolah = %@", id as CVarArg)
            
            request.sortDescriptors = [sort]
        
            return request
    }
}

