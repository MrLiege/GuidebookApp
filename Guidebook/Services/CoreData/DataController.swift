//
//  DataController.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 07.12.2024.
//

import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Guidebook")
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка с Core Data: \(error.localizedDescription)")
            }
        }
        
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Несохраненная ошибка контекста: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveCountry(_ country: Country) {
        print("Сохранение страны: \(country.name.common)")
        
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name.common == %@", country.name.common)
        
        do {
            let countryEntities = try viewContext.fetch(fetchRequest)
            
            if countryEntities.isEmpty {
                let countryEntity = CountryEntity(context: viewContext)
                countryEntity.id = country.id
                countryEntity.flag = country.flag
                countryEntity.region = country.region
                countryEntity.capital = country.capital as NSObject
                countryEntity.population = Int32(country.population)
                countryEntity.area = country.area
                countryEntity.languages = country.languages as NSObject
                countryEntity.timezones = country.timezones as NSObject
                countryEntity.latlng = country.latlng as NSObject
                
                let nameEntity = NameEntity(context: viewContext)
                nameEntity.common = country.name.common
                nameEntity.official = country.name.official
                countryEntity.name = nameEntity
                
                let flagsEntity = FlagsEntity(context: viewContext)
                flagsEntity.png = country.flags.png
                flagsEntity.svg = country.flags.svg
                countryEntity.flags = flagsEntity
                
                for (_, value) in country.currencies {
                    let currencyEntity = CurrencyEntity(context: viewContext)
                    currencyEntity.name = value.name
                    currencyEntity.symbol = value.symbol
                    countryEntity.addToCurrencies(currencyEntity)
                }
                
                saveContext()
                print("Страна сохранена: \(country.name.common)")
            } else {
                print("Страна уже существует: \(country.name.common)")
            }
        } catch {
            print("Ошибка сохранения страны: \(error)")
        }
    }


    
    func fetchCountries() -> [Country] {
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        
        do {
            let countryEntities = try viewContext.fetch(fetchRequest)
            return countryEntities.map { $0.toCountry() }
        } catch {
            print("Ошибка получения стран: \(error)")
            return []
        }
    }
    
    func deleteCountry(_ country: Country) {
        print("Запуск функции удаления страны: \(country.name.common)")
        
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name.common == %@", country.name.common)
        
        do {
            let countryEntities = try viewContext.fetch(fetchRequest)
            
            if let countryEntity = countryEntities.first {
                print("Найденная сущность для удаления: \(countryEntity)")
                viewContext.delete(countryEntity)
                saveContext()
                print("Сущность удалена: \(countryEntity)")
            } else {
                print("Сущность не найдена для удаления.")
            }
        } catch {
            print("Ошибка удаления страны: \(error)")
        }
    }
}
