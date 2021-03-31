
import UIKit

class DetailsViewController: UIViewController {

    lazy var customView = view as! DetailsView
    let viewModel: ViewModel
    
    override func loadView() {
        view = DetailsView(frame: UIScreen.main.bounds)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.attributedText = viewModel.title.formattedString(font: UIFont.customFont(ofSize: 20, weight: .bold), textColor: .black, lineHeight: 28, letterSpace: 0.2, alignment: .center)
        customView.authorLabel.text = viewModel.authorName
        if let image = viewModel.coverImage {
            setupImageContainerView(image: image)
        }
        customView.textView.attributedText = getMockTextViewText().formattedString(font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .black, lineHeight: 24, letterSpace: 0.5, alignment: .left)
        customView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    private func setupImageContainerView(image: UIImage) {
        let averageColor = image.averageColor()
        customView.imageView.image = image
        customView.imageContainerView.firstColor = averageColor
        customView.imageContainerView.secondColor = averageColor.withAlphaComponent(0)
        customView.imageContainerView.horizontalMode = false
    }
    
    @objc private func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getMockTextViewText() -> String {
        return """
        The end of the 1990s, with the art market finally recovered from its disastrous collapse, Miss Rebecca Farwell has made a killing at Christie’s in New York City, selling a portion of her extraordinary art collection for a rumored 900 percent profit. Dressed in couture YSL, drinking the finest champagne at trendy Balthazar, Reba, as she’s known, is the picture of a wealthy art collector. To some, the elusive Miss Farwell is a shark with outstanding business acumen. To others, she’s a heartless capitalist whose only interest in art is how much she can make.

        But a thousand miles from the Big Apple, in the small town of Pierson, Illinois, Miss Farwell is someone else entirely—a quiet single woman known as Becky who still lives in her family’s farmhouse, wears sensible shoes, and works tirelessly as the town’s treasurer and controller.

        No one understands the ins and outs of Pierson’s accounts better than Becky; she’s the last one in the office every night, crunching the numbers. Somehow, her neighbors marvel, she always finds a way to get the struggling town just a little more money. What Pierson doesn’t see—and can never discover—is that much of that money is shifted into a separate account that she controls, “borrowed” funds used to finance her art habit. Though she quietly repays Pierson when she can, the business of art is cutthroat and unpredictable.

        """
    }
}
