import UIKit
import Foundation
import SDWebImage

class MainMovieCell: UITableViewCell, UINavigationControllerDelegate {
    var tableView:UITableView!
    
    public static var identifier:String{
        get{
            return "MainMovieCell"
        }
    }
    
    var rateButtonAction: (() -> Void)?
    
    public static func register() ->UINib{
        UINib(nibName: "MainMovieCell", bundle: nil)
    }
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.addBorder(color: .label, width: 1)
        backView.round(10)
        backView.backgroundColor = .lightGray
        movieImageView.round(5)
    }
    
    
    @IBAction func rateButton(_ sender: UIButton) {
        rateButtonAction?()
    }
  func setupCell(viewModel:MovieTableCellViewModel,tableView:UITableView){
        self.nameLabel.text = viewModel.title
        self.dateLabel.text = viewModel.date
        self.rateLabel.text = viewModel.rating
        self.movieImageView.sd_setImage(with: viewModel.imageUrl)
        
    }

}
