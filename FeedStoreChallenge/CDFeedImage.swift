//
//  CDFeedImage+CoreDataClass.swift
//  FeedStoreChallenge
//
//  Created by Alok Subedi on 15/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

public class CDFeedImage: NSManagedObject {
	@NSManaged public var id: UUID?
	@NSManaged public var imageDescription: String?
	@NSManaged public var location: String?
	@NSManaged public var url: URL?
	@NSManaged public var cache: CDCache?
}
