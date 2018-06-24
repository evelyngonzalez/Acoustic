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

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nextEventLabel: UILabel!
    @IBOutlet weak var calendarImage: UIImageView!
    @IBOutlet weak var tableEvent: UITableView!
    @IBOutlet weak var buttonSignOut: UIButton!
    @IBAction func buttonSignOutAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let vController = storyboard?.instantiateViewController(withIdentifier: "ViewControllerid") as? ViewController
        self.navigationController?.pushViewController(vController!, animated: true)

    }
    
    var events:[Event] = []
    var musician:Musician = Musician(name: "x",image: "https://icdn2.digitaltrends.com/image/atm-hack-720x720.jpg",age:"1",city: "x",genre: "x",instrument: "x",email: "x", photo:[])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableEvent.delegate = self
        tableEvent.dataSource = self
        let googleUserId : String = GIDSignIn.sharedInstance().clientID!.replacingOccurrences(of: ".", with:"")
        let url = "https://appacoustic-c25d8.firebaseio.com/eventos/"+googleUserId+".json"
        Alamofire.request(url).responseArray {(response: DataResponse<[Event]>) in
        self.events = response.result.value!
        self.loadData ()
        self.tableEvent.reloadData()
        // Do any additional setup after loading the view.
        }
    }

    func loadData (){
        let googleUserId : String = GIDSignIn.sharedInstance().clientID!.replacingOccurrences(of: ".", with:"")
        let url = "https://appacoustic-c25d8.firebaseio.com/musicos/"+googleUserId+".json"
        Alamofire.request(url)
            .responseObject {(response: DataResponse<Musician>) in
                self.musician = response.result.value!
                self.nameLabel.text = self.musician.name
                let urlImage = URL(string: self.musician.image!)
                /*let data = try? Data(contentsOf: urlImage!)
                self.imageProfile.image = UIImage(data: data!)*/
                self.imageProfile.sd_setImage(with: urlImage)
                self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.width / 2;
                self.imageProfile.clipsToBounds = true;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableEvent.dequeueReusableCell(withIdentifier: "cellEvent", for:indexPath) as? DailyTableViewCell
        let event = self.events[indexPath.row]
        let imageURL = URL(string: event.image!)
       /* let data = try? Data(contentsOf: imageURL!)
        cell?.imageProfile.image = UIImage(data: data!)*/
        cell?.imageProfile.sd_setImage(with: imageURL)
        cell?.imageProfile.layer.cornerRadius = (cell?.imageProfile.frame.size.width)! / 2;
        cell?.imageProfile.clipsToBounds = true;
        cell?.addressLabel.text = event.address
        cell?.dayLabel.text = event.day
        cell?.timeLabel.text = event.time
        cell?.nameLabel.text = event.name
        return cell!
            
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableEvent.deselectRow(at: indexPath, animated: true)
        let event = events[indexPath.row]
        let vController = storyboard?.instantiateViewController(withIdentifier: "MapViewControllerid") as? MapViewController
        self.navigationController?.pushViewController(vController!, animated: true)
        vController?.event = event
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
