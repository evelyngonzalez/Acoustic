//
//  RestaurantViewController.swift
//  AppAcoustic
//
//  Created by Evelyn on 20/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import SDWebImage



class RestaurantViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var imageInformation: UIImageView!
    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var nameAddress: UILabel!
    @IBOutlet weak var nameDays: UILabel!
    @IBOutlet weak var nameTime: UILabel!
    @IBOutlet weak var namePayment: UILabel!
    @IBOutlet weak var namePhone: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var buttonPostulateL: UIButton!
    
    
    //Alert postulation
    @IBAction func buttonPostulateAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Estás postulado!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    var restaurant : Restaurant!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.isPagingEnabled = false
        loadData()
        photoCollection.reloadData()


        // Do any additional setup after loading the view.
    }
    
    
    //Load data restaurant
    func loadData (){
        self.nameLabel.text = self.restaurant.name
        self.addressLabel.text = self.restaurant.address
        self.cityLabel.text = self.restaurant.city
        self.dayLabel.text = self.restaurant.day
        self.timeLabel.text = self.restaurant.time
        self.paymentLabel.text = self.restaurant.payment
        self.phoneLabel.text = self.restaurant.phone
    }
 
    
    func elementsGallery () -> Int {
        var count = 0
        for i in restaurant.gallery!{
            var im = i.image
            count+=1
        }
        return count
    }
    
    //set number of item photo collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementsGallery()

    }
    
    //set information on photo collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idRestaurantPhoto", for: indexPath) as! RestourantCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        let r = restaurant.gallery![indexPath.row]
        let imageURL = URL(string: r.image!)
        cell.imageCollectionRestaurante.sd_setImage(with: imageURL)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
