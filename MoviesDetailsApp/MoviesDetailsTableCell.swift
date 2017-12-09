//
//  MoviesDetailsTableCell.swift
//  MoviesDetailsApp
//
//  Created by saurabh srivastava on 08/12/17.
//  Copyright © 2017 moviees. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesDetailsTableCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var dirname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var moviesImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        story.delegate = self
    }
    
    func updateCell(_ movies:Movies){
        story.text = movies.story
        dirname.text = movies.dirName
        name.text = movies.name
        ratings.text = String(movies.rating)
        genre.text = String(movies.genre)?.capitalized
        moviesImage.kf.setImage(with: URL(string:movies.imageUrl))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
