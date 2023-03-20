//
//  FavoriteMoviesViewModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 19/03/2023.
//

import Foundation
import CoreData

class FavoriteMoviesViewModel {
    
    let DBManager = FavoriteDataBaseManager.instance
    
    @Published var favoriteMovies : [FavoriteMovie] = []
    
    init(){
     //   fetchFavorite()
    }
    
    
    func isTableViewEmpty() -> Bool {
            return favoriteMovies.isEmpty
        }
    
    //MARK:  FETCH FAVORITES
    func fetchFavorite() -> [FavoriteMovie]{
        let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        request.returnsObjectsAsFaults = false
        do{
            favoriteMovies = try  DBManager.context.fetch(request)
        }catch let error {
            print(error)
        }
        
        return favoriteMovies
    }
    

    //MARK: ADD TO FAVORITES
    func addFavorite( date: String, id: Int64, overView: String,  photo: String, rate: Double , title: String){
        let newFav = FavoriteMovie(context: DBManager.context)
        newFav.date = date
        newFav.id = id
        newFav.overView = overView
        newFav.photo = photo
        newFav.rate = rate
        newFav.title = title
        
        saveData()
    }
    
    //MARK: DELETE FROM FAVORITES

    func deleteFromFavorite(indexPath: IndexPath) {
        let entity = favoriteMovies[indexPath.row]
        DBManager.context.delete(entity)
        print("before delete \(favoriteMovies.count)")
        
        saveData()
        
        // Fetch the object again to check if it still exists
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let fetchedResults = try? DBManager.context.fetch(fetchRequest)
        print("after delete \(fetchedResults?.count ?? 0)")
        
        // Update the local array with the updated data from Core Data
        favoriteMovies = fetchedResults ?? []
        print(favoriteMovies)
    }
    
   
    //MARK: SAVE CONTEXT
    func saveData(){
        DBManager.saveData()
    }
    
}
