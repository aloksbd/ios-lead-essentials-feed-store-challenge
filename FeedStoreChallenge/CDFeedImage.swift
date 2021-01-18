//
//  CDFeedImage+CoreDataClass.swift
//  FeedStoreChallenge
//
//  Created by Alok Subedi on 15/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import CoreData

class CDFeedImage: NSManagedObject {
	@NSManaged var id: UUID
	@NSManaged var imageDescription: String?
	@NSManaged var location: String?
	@NSManaged var url: URL
	@NSManaged var cache: CDCache
	
	var localFeedImage: LocalFeedImage{
		return LocalFeedImage(id: id, description: imageDescription, location: location, url: url)
	}

	func from(_ localFeedImage: LocalFeedImage) {
		id = localFeedImage.id
		imageDescription = localFeedImage.description
		location = localFeedImage.location
		url = localFeedImage.url
	}
}
