//
//  FonikCD.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 03/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class FonikCD: NSManagedObject, Identifiable{
    @NSManaged public var alfabet: String
    @NSManaged public var gambar: String
    @NSManaged public var gambarDesc: String
    @NSManaged public var subTitle: String
    @NSManaged public var isSelected: Bool
}

extension FonikCD{
    static func getAllFonik() -> NSFetchRequest<FonikCD>{
        let request: NSFetchRequest<FonikCD> = FonikCD.fetchRequest() as! NSFetchRequest<FonikCD>
        
        let sort = NSSortDescriptor(key: "alfabet", ascending: true)
        
        request.sortDescriptors = [sort]
        
        return request
    }
}

class Eksplorasi: NSManagedObject, Identifiable {
    @NSManaged public var sukuKata: String
    @NSManaged public var isSelected: Bool
}
extension Eksplorasi{
    static func getAllSukuKata() -> NSFetchRequest<Eksplorasi>{
        let request: NSFetchRequest<Eksplorasi> = Eksplorasi.fetchRequest() as! NSFetchRequest<Eksplorasi>
        
        let sort = NSSortDescriptor(key: "sukuKata", ascending: true)
        
        request.sortDescriptors = [sort]
        
        return request
    }
}
