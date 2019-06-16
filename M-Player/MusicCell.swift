//
//  MusicCell.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/12.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // セルに曲情報をセット
    func setCellData(image: UIImage, title: String, artistName: String, albumName: String) {
//        musicImage.image = image.resize(size: CGSize(width: 50, height: 50))
        musicImage.image = image
        titleLabel.text = title
        artistLabel.text = artistName
        albumLabel.text = albumName
    }
}

//extension UIImage {
//
//    func resize(size: CGSize) -> UIImage {
//        let widthRatio = size.width / self.size.width
//        let heightRatio = size.height / self.size.height
//        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
//        let resizedSize = CGSize(width: (self.size.width * ratio), height: (self.size.height * ratio))
//        // 画質を落とさないように以下を修正
//        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
//        draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return resizedImage!
//    }
//}
