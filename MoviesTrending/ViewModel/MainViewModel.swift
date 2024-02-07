import Foundation
import UIKit

class MainViewModel{
    
    var isLoading:Observable<Bool>=Observable(false)
    var dataSource:TrendingMovieModel?
    
    var cellDataSource:Observable<[MovieTableCellViewModel]>=Observable(nil)
    
    func numberOfSections() -> Int{
        1
    }
    func numberOfRows(in section:Int) -> Int{
        self.dataSource?.results.count ?? 0
    }
    
    func getData(){
        
//        print("get data is called ")
        if isLoading.value ?? true{
            return
        }
        isLoading.value=true
//        print("Goes in the top trending movies ")
        APICaller.getTrendingMovies {[weak self] result in//to avoid the retain cycle we use this
         
            self?.isLoading.value=false
            switch result{
            case .success(let data):
//                print("Data of the site loded succesfully")
                print("Top trending Movies \(data.results.count)")
                self?.dataSource=data
                self?.mapCellData()
            case .failure(let error):
//                print("Here the error is in the mainviewmodel")
                print(error)
            }
        }
    }
    
    func mapCellData(){
        print("map cell data here")
        self.cellDataSource.value = self.dataSource?.results.compactMap({ MovieTableCellViewModel(movie:
            $0)})
    }
    
    func getMovieTitle(_ movie:Movie) -> String{
        print("getMovieTitle")
        return movie.title ?? movie.name ?? "";
    }
    
    func retrieveModel(with id:Int) -> Movie?{
        print("retrieveModel")
        guard let movie=dataSource?.results.first(where: {$0.id == id})else {

            return nil
        }
        return movie
    }
    
    func updateRating(for movieId: Int, newRating: String) {
            guard let index = dataSource?.results.firstIndex(where: { $0.id == movieId }) else {
                return
            }
            // Update the rating for the found movie
            dataSource?.results[index].voteAverage = Double(newRating) ?? 0.0
            
            // Map the updated data to cell view models
            mapCellData()
        }
}
