//
//  ViewController.swift
//  MoviesDetailsApp
//
//  Created by saurabh srivastava on 08/12/17.
//  Copyright © 2017 moviees. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var moviesList = [Movies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let movies = realm.objects(Movies.self)
        for movie in movies{
            moviesList.append(movie)
        }
        self.tableView.reloadData()
        getMovie()
         self.tableView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
        self.tableView.register(UINib(nibName: "MoviesDetailsTableCell", bundle: nil), forCellReuseIdentifier: "MoviesDetailsTableCell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovie(){
        let url = URL(string: "http://api.cinemalytics.in/v2/movie/year/2017/?auth_token=C26014879ADC0945063721B823776CDD")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let str = error?.localizedDescription
                let alert = UIAlertController(title: "Error", message: str, preferredStyle: .alert)
                let okACtion = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okACtion)
                self.present(alert, animated: true, completion: nil)
                return
            }
            do{
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]{
                print(json)
                var movies = [Movies]()
                for dict in json{
                    let movie = Movies()
                    movie.updateModel(dict)
                    movies.append(movie)
                    self.moviesList = movies
                }
               
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    try! realm.write{
                        realm.add(self.moviesList, update: true)
                    }
                    self.tableView.reloadData()
                }
                
                
            }
            }
            catch{
                
            }
        }
        task.resume()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoviesDetailsTableCell", for: indexPath) as! MoviesDetailsTableCell
        cell.updateCell(moviesList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeSettings(id: indexPath.row)
        self.tableView.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if moviesList[indexPath.row].open == true{
            return 300
        }
        return 140
    }
    
    func changeSettings(id:Int){
        for i in 0..<moviesList.count{
            if i == id{
                if moviesList[i].open == true{
                    moviesList[i].open = false
                }
                else{
                    moviesList[i].open = true
                }
            }
            else{
                moviesList[i].open = false
            }
        }
    }


}

