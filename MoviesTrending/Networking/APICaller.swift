import Foundation

enum NetworkError:Error{
    case urlError
    case canNotParseData
}

class APICaller{

    private static var checkFlag:Bool = false
    static func getTrendingMovies(
        completionHandler:@escaping (_ result: Result< TrendingMovieModel , NetworkError>) -> Void){
            
                let urlString=NetworkConstant.shared.serverAddress+"/trending/all/day?api_key="+NetworkConstant.shared.key

//                let urlString="https://api.themoviedb.org/3/trending/all/day?api_key=6a63135b42a17c53d400db396c27903f"
                
                guard let url=URL(string: urlString ) else{
                    return completionHandler(.failure(.urlError))
                }
                URLSession.shared.dataTask(with: url) { (dataResponse, urlResponse, error) in
    //                print("here in the session")
                    if error == nil,
                       let data = dataResponse,
                       let resultData = try? JSONDecoder().decode(TrendingMovieModel.self, from: data){
                        completionHandler(.success(resultData))
    //                    print(resultData)
    //                    print("Data loaded success")
                    }else{
    //                    print("Data loaded UNsuccess")

                        completionHandler(.failure(.canNotParseData))
                    }
                }.resume()
    }
}
 
