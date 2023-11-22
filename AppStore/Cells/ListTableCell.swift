//
//  ListTableCell.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto
//

import UIKit
import SwiftUI

class ListTableCell: UICollectionViewCell, ConfigureCell {
   
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .label
        return label
    }()
    
    let varlabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .random()
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configure(with app: App) {
        nameLabel.text = app.name
    }
}

extension ListTableCell: ViewCode {
    func buildViewHierarchy() {
        
        addSubview(stackView)
    }
    
    func addConstraints() {
        stackView.fillSuperview()
        imageView.constrainSize(CGSize(width: 30,
                                     height: 30))
    }
}

#if canImport(SwiftUI) && DEBUG
struct ListTableViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = ListTableCell()
            let app = App(tagline: "", name: "Lorem ipsum", subheading: "")
            cell.configure(with: app)
            
            return cell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width,
                              height: 35))
    }
}
#endif
