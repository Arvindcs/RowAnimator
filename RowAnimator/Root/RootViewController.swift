
import UIKit

class RootViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    var detailsViewPresentingAnimator: ViewPresentingAnimator?
    var detailsViewDismissingAnimator: ViewDismissingAnimator?
    var viewModelList = [ViewModel]()
    var didSelectItem: ((_ selectedModel: SelectedViewModel) -> Void)?

    //MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTable()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    //MARK:- internal methods
    
    private func loadData() {
        viewModelList = MockData().getData()
    }
    
    private func setupTable() {
        tableView.register(UINib(nibName: "\(TableViewCell.self)", bundle: nil), forCellReuseIdentifier: TableViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showDetailsView(selectedModel: SelectedViewModel, HomeView: UIView) {
        let imageRelativeFrame = view.convert(selectedModel.imageViewParentRelativeFrame, from: HomeView)
        detailsViewPresentingAnimator = ViewPresentingAnimator(originImageFrame: imageRelativeFrame, imageView: selectedModel.imageView)
        detailsViewDismissingAnimator = ViewDismissingAnimator(originImageFrame: imageRelativeFrame, imageView: selectedModel.imageView)
        let viewController = DetailsViewController(viewModel: selectedModel.item)
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        present(viewController, animated: true, completion: nil)
    }
}

//MARK:- UITableViewDataSource & UITableViewDelegate Methods

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.description(), for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configure(from: viewModelList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else {
            return
        }
        let imageRelativeFrame = view.convert(cell.coverImageView.frame, from: cell.containerView)
        let model = SelectedViewModel(item: viewModelList[indexPath.row], imageView: cell.coverImageView, imageViewParentRelativeFrame: imageRelativeFrame)
        DispatchQueue.main.async {
            self.showDetailsView(selectedModel: model, HomeView: self.view)
        }
    }
}

//MARK:- UIViewControllerTransitioningDelegate Methods

extension RootViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return detailsViewPresentingAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return detailsViewDismissingAnimator
    }
}
