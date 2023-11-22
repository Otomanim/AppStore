//
//  DownloadTableCell.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto 
//

import UIKit

class DownloadTableCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.backgroundColor = .random()
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        return button
    }()
   
    lazy var stackView: UIStackView = {
        
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel, subTitleLabel])
        labelStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView, downloadButton])
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DownloadTableCell: ConfigureCell {
    
    func configure(with app: App) {
        nameLabel.text = app.name
        subTitleLabel.text = app.subheading
    }
}

extension DownloadTableCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func addConstraints() {
        downloadButton.constrainWidth(38)
        imageView.constrainSize(CGSize(width: 52, height: 52))
        stackView.fillSuperview()
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct DownloadTableViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = DownloadTableCell()
            let app = App(tagline: "",
                          name: "Lorem ipsum",
                          subheading: "Lorem ipsum")
            cell.configure(with: app)
            
            return cell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width,
                              height: 80))
    }
}

#endif
