//
//  FavoriteDataBaseManager.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 18/03/2023.
//

import Foundation
import CoreData

class FavoriteDataBaseManager {
    
    static let instance = FavoriteDataBaseManager()
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    private init(){
        container = NSPersistentContainer(name: "FavoriteMovies")
        container.loadPersistentStores{ description , error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        context = container.viewContext
    }
    
    func saveData(){
        do{
            try context.save()
        }catch let error{
            print("error :\(error.localizedDescription)")
        }
    }
}

