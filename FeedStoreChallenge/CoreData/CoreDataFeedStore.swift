//
//  CoreDataFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Alok Subedi on 15/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

public class CoreDataFeedStore: FeedStore {
	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext
	
	private let modelName = "CoreDataFeedModel"
	
	public init(storeURL: URL) throws {
		guard let modelURL = Bundle(for: CoreDataFeedStore.self).url(forResource: modelName, withExtension:"momd") else {
			throw NSError()
		}
		
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
			throw NSError()
		}
		
		let description = NSPersistentStoreDescription(url: storeURL)
		container = NSPersistentContainer(name: modelName, managedObjectModel: model)
		container.persistentStoreDescriptions = [description]
		
		var loadError: Swift.Error?
		container.loadPersistentStores { loadError = $1 }
		try loadError.map { throw $0 }
		
		context = container.newBackgroundContext()
	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		let context = self.context
		context.perform {
			do {
				try self.deleteCache()
				completion(nil)
			} catch {
				completion(nil)
			}
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let context = self.context
		context.perform {
			do {
				try self.deleteCache()
				let cache = CDCache(context: context)
				cache.timeStamp = timestamp
				cache.feed = NSOrderedSet(array: feed.map { local in
					let feed = CDFeedImage(context: context)
					feed.from(local)
					return feed
				})
				
				try context.save()
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		let context = self.context
		context.perform {
			do {
				
				if let cache = try self.fetchCache() {
					completion(.found(feed: cache.localFeedImages, timestamp: cache.timeStamp))
				} else {
					completion(.empty)
				}
			} catch {
				completion(.failure(error))
			}
		}
	}
	
	private func fetchCache() throws -> CDCache? {
		let request = NSFetchRequest<CDCache>(entityName: CDCache.entity().name!)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}
	
	private func deleteCache() throws {
		if let foundCache = try self.fetchCache() {
			context.delete(foundCache)
			try context.save()
		}
	}
}
