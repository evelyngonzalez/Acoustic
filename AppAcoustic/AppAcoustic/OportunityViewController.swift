//
//  OportunityViewController.swift
//  AppAcoustic
//
//  Created by Evelyn on 20/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import SDWebImage


class OportunityViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    

   // @IBOutlet weak var imageOportunity: UIImageView!
   // @IBOutlet weak var oportunityLabel: UILabel!
    @IBOutlet weak var oportunityTable: UITableView!
   // @IBOutlet weak var buttonSignOut: UIButton!
    /*@IBAction func buttonSignOutAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let vController = storyboard?.instantiateViewController(withIdentifier: "ViewControllerid") as? ViewController
        self.navigationController?.pushViewController(vController!, animated: true)

    }*/
    
    var restourants:[Restaurant] = []

    var rest: Restaurant = Restaurant (name: "x", image: "", city:"x", address: "x", day: "x", time: "x", payment: "x", phone: "x", gallery:[])

    override func viewDidLoad() {
        super.viewDidLoad()
        oportunityTable.delegate = self
        oportunityTable.dataSource = self
        let url = "https://appacoustic-c25d8.firebaseio.com/restaurantes.json"
        Alamofire.request(url).responseArray {(response: DataResponse<[Restaurant]>) in
            self.restourants = response.result.value!
        self.oportunityTable.reloadData()
        // Do any additional setup after loading the view.
    }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restourants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oportunityTable.dequeueReusableCell(withIdentifier: "oportunitycellid", for:indexPath) as? OportunityTableViewCell
        let restoran = self.restourants[indexPath.row]
        /*let imageURL = URL(string: restoran.image!)
        let data = try? Data(contentsOf: imageURL!)
        cell?.restaurantImage.image = UIImage(data: data!)*/
        let imageURL = URL(string: restoran.image!)
        cell?.restaurantImage.sd_setImage(with: imageURL)
        cell?.addressLabel.text = restoran.address
        cell?.nameLabel.text = restoran.name
        cell?.cityLabel.text = restoran.city
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        oportunityTable.deselectRow(at: indexPath, animated: true)
        let restoran = restourants[indexPath.row]
        let vController = storyboard?.instantiateViewController(withIdentifier: "restourantViewControllerID") as? RestaurantViewController
       self.navigationController?.pushViewController(vController!, animated: true)
        vController?.restaurant = restoran
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
