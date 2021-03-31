

import UIKit

struct MockData {
    private let titles = [
        "Following You",
        "The Talented Miss Farewell",
        "Impire of Wild",
        "Dispressed",
        "TainTed Canvas",
        "The Talented Miss Farewell",
        "La Sangre De las Besties",
        "Murder to Music"
    ]
    private let authors = [
        "The Designed By Cakamura",
        "Emily Gray Tedrowe",
        "HarperCollins",
        "Alek",
        "Hortasar",
        "Emily Gray Tedrowe",
        "Ivanol",
        "Juh D"
    ]
    func getData() -> [ViewModel] {
        var data = [ViewModel]()
        for index in 1 ... 8 {
            let progress = CGFloat.random(in: 0...1)
            data.append(ViewModel(title: titles[index - 1], authorName: authors[index - 1], authorImage: #imageLiteral(resourceName: "avatar"), progress: progress, progressString: getFormattedProgressString(progress: progress), coverImage: UIImage(named: "book\(index)")))
        }
        return data
    }
    
    private func getFormattedProgressString(progress: CGFloat) -> String {
        let formattedProgress = Int(progress * 100)
        return "\(formattedProgress)%"
    }
}
