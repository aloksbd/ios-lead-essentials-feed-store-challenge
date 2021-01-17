//
//  CoreDataFeedImage.swift
//  FeedStoreChallenge
//
//  Created by Alok Subedi on 15/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataFeedStore: FeedStore {
	private let container: NSPersistentContainer
	private let modelName = "CoreDataFeedModel"
	
	public init() throws {
		guard let modelURL = Bundle(for: CoreDataFeedStore.self).url(forResource: modelName, withExtension:"momd") else {
			throw NSError()
		}
		
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
			throw NSError()
		}
		
		container = NSPersistentContainer(name: modelName, managedObjectModel: model)
		
		var loadError: Swift.Error?
		container.loadPersistentStores { loadError = $1 }
		try loadError.map { throw $0 }
	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		completion(.empty)
	}
}
