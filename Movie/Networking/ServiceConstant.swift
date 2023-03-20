//
//  ServiceConstant.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import Foundation

class ServiceConstant{
    
    public static var shared : ServiceConstant = ServiceConstant()
    
    private init(){}
    
    public var apiKey: String {
        get{
            return "15fe946886608e9b2315244355fb5b94"
        }
    }
    
    public var  serverAddress : String {
        get{
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var  trending : String {
        get{
            return  "trending/movie/day?api_key="
        }
    }
    
    public var upcoming : String {
        get{
            return "movie/upcoming?api_key="
          }
       }    
}

