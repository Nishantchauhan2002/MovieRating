import UIKit


//weak var delegate: RatingAndReviewDelegate?

class MainViewController: UIViewController{

    var viewModel:MainViewModel=MainViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var cellDataSource:[MovieTableCellViewModel]=[]
    
    override func viewDidLoad()      {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadTableView()
    }
    
    func configureView(){
        self.title="Top Trending Movies"
        view.backgroundColor = .systemBackground
        setUpTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if(cellDataSource.count == 0 ){
            print("get data is called")
            viewModel.getData()
        }
       
    }
    
    
    func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self , let isLoading = isLoading else{
                return
            }
            DispatchQueue.main.async {
                if isLoading{
                    self.activityIndicator.startAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.cellDataSource.bind {[weak self] movies in
            guard let self = self ,let movies = movies else {
                return
            }
            self.cellDataSource=movies
            self.reloadTableView()
        }
    }

    func openDetail(movieId:Int,indexpath:IndexPath,currentRating:String){
//        print("Open Details Called")
        guard let movie=viewModel.retrieveModel(with: movieId)else{
            return
        }
        let detailsMovieViewModel=DetailMovieViewModel(movie: movie)
        let detatilsViewController=DetailViewController(viewmodel: detailsMovieViewModel)

        
        detatilsViewController.ratingUpdatedCallback = { [weak self] newRating in
                print("here in the rating updated cal back ")
                self?.cellDataSource[indexpath.row].rating=newRating
            
                self?.tableView.reloadRows(at: [indexpath], with: .automatic)
            }
        
        DispatchQueue.main.async {
            detatilsViewController.selectedPath=indexpath
            detatilsViewController.newRating=currentRating
//            detatilsViewController.delegate=self
            self.navigationController?.pushViewController(detatilsViewController, animated: true)

        }
    }
    
    
}
