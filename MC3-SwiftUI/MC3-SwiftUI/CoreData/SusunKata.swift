//
//  SusunKata.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 19/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import CoreData

class SusunKata: NSManagedObject, Identifiable{
    @NSManaged public var idSusunKata: UUID
    @NSManaged public var kata: String
    @NSManaged public var sound: String

}

extension SusunKata{
    static func getAllKata() -> NSFetchRequest<SusunKata>{
        let request: NSFetchRequest<SusunKata> = SusunKata.fetchRequest() as! NSFetchRequest<SusunKata>
    
        return request
    }
}
