//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Дмитрий Геращенко on 09.06.2021.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var rating: Int16
    @NSManaged public var review: String?
  @NSManaged public var date: Date?

}

extension Book : Identifiable {

}
