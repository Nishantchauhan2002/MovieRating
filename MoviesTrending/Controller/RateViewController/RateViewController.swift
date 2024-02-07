import UIKit

protocol RatingAndReviewDelegate{
    
    func didUpdateRating(newRating: String,index: IndexPath)
    func didUpdateReview(newReview: String)
    
}

class RateViewController: UIViewController {
    var delegate: RatingAndReviewDelegate?
    var selectedIndexPath: IndexPath?
    
    var ratingUpdatedCallback: ((String) -> Void)?
    
    
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var cosmoViewFull: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    var startRating:Float=3.7
    
    
    
    @IBOutlet weak var ratingSlider: UISlider!
    

    func updateRatingAndReview1(){
        
        
    let updatedRating=rateLabel.text ?? ""
    let updatedReview=reviewText.text ?? ""
        print("RateviewCotroller delegateCaller")
        delegate?.didUpdateRating(newRating: updatedRating,index: selectedIndexPath!)
        delegate?.didUpdateReview(newReview: updatedReview)
    }
    
    @IBAction func rateButtonClicked(_ sender: UIButton) {
        
        let ratingValue=rateLabel.text
        print(ratingValue ?? "2")
        print(reviewText.text ?? "nil")
        
        
        self.updateRatingAndReview1()
        navigationController?.popViewController(animated: true)
        
        ratingUpdatedCallback?(((ratingValue ?? "")))
//        
//        let alert=UIAlertController(title: "Thanks !! ", message: "Thanks for rating us ", preferredStyle: .alert);
//        let okAction=UIAlertAction(title: "OK", style: .default,handler: { _ in
//            
//            
//            
//            //self.navigationController?.popViewController(animated: true)
//            
//            
//            
//            
//        })
//        alert.addAction(okAction)
//        present(alert,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        cosmoViewFull.didTouchCosmos = didTouchCosmos
        cosmoViewFull.didFinishTouchingCosmos = didFinishTouchingCosmos
        ratingSlider.value = startRating //3.7 slider
        updateRating()
    }
    
    private func updateRating() {
        let value = Double(ratingSlider.value)
        cosmoViewFull.rating = value
        self.rateLabel.text = (RateViewController.formatValue(value))
    }
    @IBAction func onSliderChanged(_ sender: UISlider) {
        updateRating()
    }
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        ratingSlider.value = Float(rating)
        rateLabel.text = RateViewController.formatValue(rating)
        rateLabel.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        ratingSlider.value = Float(rating)
        self.rateLabel.text = RateViewController.formatValue(rating)
        rateLabel.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
