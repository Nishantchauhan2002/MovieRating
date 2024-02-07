import UIKit
import SDWebImage

class DetailViewController: UIViewController,RatingAndReviewDelegate {
    
    
//    var mainviewmodel:MainViewModel
//    weak var delegate: RatingAndReviewDelegate?
    
    var ratingUpdatedCallback: ((String) -> Void)?

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    var selectedPath:IndexPath?
    var newRating:String?
    @IBAction func GoBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func rateButton(_ sender: Any) {
        let navigator=RateViewController()
        navigator.delegate=self
        navigator.selectedIndexPath=selectedPath
        navigator.ratingUpdatedCallback={ [weak self] newRating in
            self?.ratingUpdatedCallback?(newRating)
        }
        navigationController?.pushViewController(navigator, animated: true)
        
    }
    var viewmodel:DetailMovieViewModel
    init(viewmodel:DetailMovieViewModel){
        self.viewmodel=viewmodel


        super.init(nibName: "DetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
        
    }
    func configView(){
        self.title="Movie Details"
        titleLabel.text=viewmodel.movieTitle
        descriptionLabel.text=viewmodel.movieDescription
        imageView.sd_setImage(with: viewmodel.movieImage)
        rateLabel.text="Rating \(viewmodel.rating)"
        reviewLabel.text="Good one to watch"
    }
    
    
    func didUpdateRating(newRating: String, index indexPath: IndexPath) {
        print("======detailed viewController UpdateRating \(newRating)")
        rateLabel.text="Rating -- \(newRating)"
    }

    func didUpdateReview(newReview: String) {
        print("====detailed viewController updateReview\(newReview)")
        reviewLabel.text="\(newReview)"
    }
//
//    func didUpdateRating(newRating: String) {
//        print("======detailed viewController UpdateRating \(newRating)")
////        mainviewmodel.updateRating(for: <#T##Int#>, newRating: newRating)
//        rateLabel.text="Rating -- \(newRating)"
//    }
//
//    func didUpdateReview(newReview: String) {
//        print("====detailed viewController updateReview\(newReview)")
//
//        reviewLabel.text="\(newReview)"
//    }
}
