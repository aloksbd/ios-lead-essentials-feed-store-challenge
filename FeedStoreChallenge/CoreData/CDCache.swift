//
//  CDCache+CoreDataClass.swift
//  FeedStoreChallenge
//
//  Created by Alok Subedi on 15/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import CoreData

class CDCache: NSManagedObject {
	@NSManaged var timeStamp: Date
	@NSManaged var feed: NSOrderedSet
	
	var localFeedImages: [LocalFeedImage]{
		return feed.compactMap { ($0 as? CDFeedImage)?.localFeedImage }
	}
}
