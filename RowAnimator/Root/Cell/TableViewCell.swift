
import UIKit

class TableViewCell: UITableViewCell {
    
    let blackTextColor = UIColor.AppColors.black
    var progressV: ProgressView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialise()
    }
    
    func initialise() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
      
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.cornerRadius = 9
        coverImageView.clipsToBounds = true
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 10
        avatarImageView.clipsToBounds = true
        
        titleLabel.numberOfLines = 2
        titleLabel.textColor = blackTextColor
        titleLabel.font = .customFont(ofSize: 14, weight: .bold)
        titleLabel.textAlignment = .left
        
        authorNameLabel.textColor = blackTextColor
        authorNameLabel.font = UIFont.customFont(ofSize: 12, weight: .medium)
        authorNameLabel.textAlignment = .left
        
        progressLabel.textColor = UIColor.AppColors.grey
        progressLabel.font = .systemFont(ofSize: 12, weight: .regular)
        progressLabel.textAlignment = .center
    }
    
    func configure(from model: ViewModel) {
        titleLabel.text = model.title
        authorNameLabel.text = model.authorName
        avatarImageView.image = model.authorImage
        coverImageView.image = model.coverImage
        progressView.setProgress( Float(model.progress * 100), animated: true)
        progressLabel.text = model.progressString
    }

}
