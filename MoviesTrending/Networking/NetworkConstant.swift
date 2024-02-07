//
//  NetworkConstant.swift
//  MovieTrending
//
//  Created by Nishant Chauhan on 31/01/24.
//

import Foundation
import UIKit

class NetworkConstant{
    
    public static var shared:NetworkConstant=NetworkConstant()
    
    private init(){
        //singleton
    }
    
    public var key:String{
        get{
             return "6a63135b42a17c53d400db396c27903f"
        }
    }
    public var serverAddress:String{
        get{
            return "https://api.themoviedb.org/3"
        }
    }
    
    public var serverImageAddress:String{
        get{
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
}
