//
//  DiaryViewController.swift
//  AppAcoustic
//
//  Created by Evelyn on 13/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import SDWebImage


class DiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nextEventLabel: UILabel!
    @IBOutlet weak var calendarImage: UIImageView!
    @IBOutlet weak var tableEvent: UITableView!
    
    // Variables
    var events:[Event] = []
    var musician:Musician = Musician(name: "x",image: "https://icdn2.digitaltrends.com/image/atm-hack-720x720.jpg",age:"1",city: "x",genre: "x",instrument: "x",email: "x", photo:[])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableEvent.delegate = self
        tableEvent.dataSource = self
        
        //Associate id de Google in json with User information
        let googleUserId : String = GIDSignIn.sharedInstance().clientID!.replacingOccurrences(of: ".", with:"")
        let url = "https://appacoustic-c25d8.firebaseio.com/eventos/"+googleUserId+".json"
        
        //Use Alamofire for request Event information
        Alamofire.request(url).responseArray {(response: DataResponse<[Event]>) in
        self.events = response.result.value!
        self.loadData ()
        self.tableEvent.reloadData()
        }
    }

    
    //Load data and associates with oulets variables
    func loadData (){
        let googleUserId : String = GIDSignIn.sharedInstance().clientID!.replacingOccurrences(of: ".", with:"")
        let url = "https://appacoustic-c25d8.firebaseio.com/musicos/"+googleUserId+".json"
        Alamofire.request(url)
            .responseObject {(response: DataResponse<Musician>) in
                self.musician = response.result.value!
                self.nameLabel.text = self.musician.name
                let urlImage = URL(string: self.musician.image!)
                self.imageProfile.sd_setImage(with: urlImage)
                self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.width / 2;
                self.imageProfile.clipsToBounds = true;
        }
    }
    
    //Count numbers of rows in tableEvent
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    //Load information in tableEvent
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableEvent.dequeueReusableCell(withIdentifier: "cellEvent", for:indexPath) as? DailyTableViewCell
        let event = self.events[indexPath.row]
        let imageURL = URL(string: event.image!)
        cell?.imageProfile.sd_setImage(with: imageURL)
        cell?.imageProfile.layer.cornerRadius = (cell?.imageProfile.frame.size.width)! / 2;
        cell?.imageProfile.clipsToBounds = true;
        cell?.addressLabel.text = event.address
        cell?.dayLabel.text = event.day
        cell?.timeLabel.text = event.time
        cell?.nameLabel.text = event.name
        return cell!
        }
    
    //Pass information when did select row to MapViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableEvent.deselectRow(at: indexPath, animated: true)
        let event = events[indexPath.row]
        let vController = storyboard?.instantiateViewController(withIdentifier: "MapViewControllerid") as? MapViewController
        self.navigationController?.pushViewController(vController!, animated: true)
        vController?.event = event
    }
    
    //Configuration tableEvent Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
