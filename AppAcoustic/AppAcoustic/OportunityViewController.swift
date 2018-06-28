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
    
    //Outlets
    @IBOutlet weak var imageOportunity: UIImageView!
    @IBOutlet weak var oportunityTable: UITableView!

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
        }
    }

    //set count number of rows in restaurant table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restourants.count
    }
    
    
    //set information in cell to oportunity table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oportunityTable.dequeueReusableCell(withIdentifier: "oportunitycellid", for:indexPath) as? OportunityTableViewCell
        let restoran = self.restourants[indexPath.row]
        let imageURL = URL(string: restoran.image!)
        cell?.restaurantImage.sd_setImage(with: imageURL)
        cell?.restaurantImage.layer.cornerRadius = (cell?.restaurantImage.frame.size.width)! / 2;
        cell?.restaurantImage.clipsToBounds = true;
        cell?.addressLabel.text = restoran.address
        cell?.nameLabel.text = restoran.name
        cell?.cityLabel.text = restoran.city
        return cell!
        
    }
    
    //set configure height to oportunity table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    //pass information to restaurant view controller when selected row
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
