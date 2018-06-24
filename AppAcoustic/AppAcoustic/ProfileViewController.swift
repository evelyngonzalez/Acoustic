//
//  ProfileViewController.swift
//  AppAcoustic
//
//  Created by Evelyn on 13/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import SDWebImage


class ProfileViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var instrumentLabel: UILabel!
    @IBOutlet weak var instrumentTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deletePhotoButton: UIButton!
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var collectionPhotos: UICollectionView!
    @IBOutlet weak var upPhotoButton: UIButton!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var buttonSignOut: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func buttonSignOutAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let vController = storyboard?.instantiateViewController(withIdentifier: "ViewControllerid") as? ViewController
        self.navigationController?.pushViewController(vController!, animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        /*let alert = UIAlertController(title: "x", message: "x", preferredStyle: UIAlertControllerStyle.alert)*/
        self.enableEditText ()
        editButton.isHidden = true
        saveButton.isHidden = false
        upPhotoButton.isHidden = false
        deletePhotoButton.isHidden = false
        
    }
    
    @IBAction func deletePhotoButtonAction(_ sender: Any) {
        self.photos = []
        self.musician.photo = []
        collectionPhotos.reloadData()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        self.disableEditText()
        //guardar los cambios en firebase

        self.startActivityIndicator()
        
        self.musician.age = self.ageTextField.text
        self.musician.city = self.cityTextField.text
        self.musician.genre = self.genreTextField.text
        self.musician.instrument = self.instrumentTextField.text
        self.musician.email = self.emailTextField.text
        
    
        let jsonData = self.musician.toJSON()

        let googleUserId : String = GIDSignIn.sharedInstance().clientID!.replacingOccurrences(of: ".", with:"")
        let url = URL(string: "https://appacoustic-c25d8.firebaseio.com/musicos/"+googleUserId+".json")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonData, options: [])
        } catch {
            // No-op
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(urlRequest).response { _ in
            self.stopActivityIndicator()
            
            self.editButton.isHidden = false
            self.saveButton.isHidden = true
            self.upPhotoButton.isHidden = true
            self.deletePhotoButton.isHidden = true
        }
    }
    
    @IBAction func upPhotoAction(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller,animated: true, completion: nil)
        
    }
    
    var musician:Musician = Musician(name: "x",image: "https://icdn2.digitaltrends.com/image/atm-hack-720x720.jpg",age:"1",city: "x",genre: "x",instrument: "x",email: "x", photo:[])
    var photos:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionPhotos.delegate = self
        collectionPhotos.dataSource = self
        collectionPhotos.isPagingEnabled = false
        
        saveButton.isHidden = true
        upPhotoButton.isHidden = true
        deletePhotoButton.isHidden = true

        loadData()
        collectionPhotos.reloadData()
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(self.activityIndicator)

        self.ageTextField.borderStyle = UITextBorderStyle.none
        self.cityTextField.borderStyle = UITextBorderStyle.none
        self.emailTextField.borderStyle = UITextBorderStyle.none
        self.instrumentTextField.borderStyle = UITextBorderStyle.none
        self.genreTextField.borderStyle = UITextBorderStyle.none
    }
    
    func startActivityIndicator(){
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(){
        self.activityIndicator.stopAnimating()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.photos.append(image)
        
        let strBase64 = image.sd_imageData()!.base64EncodedString(options: .lineLength64Characters)
        self.musician.photo?.append(strBase64)

        collectionPhotos.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idphoto", for: indexPath) as! PhotoCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.photoImage.image = self.photos[indexPath.row]
        return cell
    }
    
    func loadData (){
        self.startActivityIndicator()
        let googleUserId : String = GIDSignIn.sharedInstance().clientID!.replacingOccurrences(of: ".", with:"")
        let url = "https://appacoustic-c25d8.firebaseio.com/musicos/"+googleUserId+".json"
        Alamofire.request(url)
            .responseObject {(response: DataResponse<Musician>) in
                self.musician = response.result.value!
                    self.name.text = self.musician.name
                    let urlImage = URL(string: self.musician.image!)
                   // let data = try? Data(contentsOf: urlImage!)
                   // self.imageProfile.image = UIImage(data: data!)
                    self.imageProfile.sd_setImage(with: urlImage)
                    self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.width / 2;
                    self.imageProfile.clipsToBounds = true;
                    self.ageTextField.text = self.musician.age
                    self.cityTextField.text = self.musician.city
                    self.genreTextField.text = self.musician.genre
                    self.instrumentTextField.text = self.musician.instrument
                    self.emailTextField.text = self.musician.email
                
                if(self.musician.photo != nil){
                    for strPhoto in self.musician.photo! {
                        let dataDecoded : Data = Data(base64Encoded: strPhoto, options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
                        self.photos.append(decodedimage!)
                    }
                    self.collectionPhotos.reloadData()
                }
            self.disableEditText()
            self.stopActivityIndicator()
        }
    }
    
    func disableEditText (){
        self.emailTextField.isUserInteractionEnabled = false
        self.name.isUserInteractionEnabled = false
        self.ageTextField.isUserInteractionEnabled = false
        self.genreTextField.isUserInteractionEnabled = false
        self.instrumentTextField.isUserInteractionEnabled = false
        self.cityTextField.isUserInteractionEnabled = false
        
        self.ageTextField.borderStyle = UITextBorderStyle.none
        self.cityTextField.borderStyle = UITextBorderStyle.none
        self.emailTextField.borderStyle = UITextBorderStyle.none
        self.instrumentTextField.borderStyle = UITextBorderStyle.none
        self.genreTextField.borderStyle = UITextBorderStyle.none
    }
    
    func enableEditText (){
        self.emailTextField.isUserInteractionEnabled = true
        self.name.isUserInteractionEnabled = true
        self.ageTextField.isUserInteractionEnabled = true
        self.genreTextField.isUserInteractionEnabled = true
        self.instrumentTextField.isUserInteractionEnabled = true
        self.cityTextField.isUserInteractionEnabled = true
        
        self.ageTextField.borderStyle = UITextBorderStyle.roundedRect
        self.cityTextField.borderStyle = UITextBorderStyle.roundedRect
        self.emailTextField.borderStyle = UITextBorderStyle.roundedRect
        self.instrumentTextField.borderStyle = UITextBorderStyle.roundedRect
        self.genreTextField.borderStyle = UITextBorderStyle.roundedRect
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
