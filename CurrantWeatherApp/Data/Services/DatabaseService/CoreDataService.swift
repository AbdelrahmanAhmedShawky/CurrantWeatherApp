//
//  CoreDataService.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation
import CoreData

class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveFromLocalStorage(_ weather: CurrentWeather) {
        clearAllCoreData()
        let request: NSFetchRequest<CurrentWeatherDBEntity> = CurrentWeatherDBEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            let hourlyEntity = results.first ?? CurrentWeatherDBEntity(context: context)
            
            hourlyEntity.time = weather.time as NSObject
            hourlyEntity.temperature2M = weather.temperature2M as NSObject
            
            try context.save()
            print("Weather data saved successfully")
        } catch {
            print("Error saving weather data: \(error.localizedDescription)")
        }
    }
    
     func clearAllCoreData() {
        let entities = self.persistentContainer.managedObjectModel.entities
        entities.flatMap({ $0.name }).forEach(clearDeepObjectEntity)
    }

     func clearDeepObjectEntity(_ entity: String) {
        let context = self.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func loadInLocalStorage() -> CurrentWeather? {
        let request: NSFetchRequest<CurrentWeatherDBEntity> = CurrentWeatherDBEntity.fetchRequest()
        do {
            guard let result = try context.fetch(request).first else {
                print("No weather data found in local storage")
                return nil
            }
            let weatherTime = result.time as! [String]
            let weatherTemp = result.temperature2M as! [Double]
            
            let hourlyModel = CurrentWeather(time: weatherTime, temperature2M: weatherTemp)
            return hourlyModel
        } catch {
            print("Error loading weather data: \(error.localizedDescription)")
            return nil
        }
    }
    
}
