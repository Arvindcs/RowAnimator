
import UIKit


class DismissButton: UIButton {
    
    var topPadding: CGFloat = 0
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if topPadding != 0 {
            let biggerFrame = bounds.insetBy(dx: -topPadding, dy: -topPadding)
            return biggerFrame.contains(point)
        }
        return bounds.contains(point)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        tintColor = .white
        setImage(#imageLiteral(resourceName: "back"), for: .normal)
    }
}
