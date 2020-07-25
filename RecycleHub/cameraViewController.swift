//
//  cameraViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/20/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit

class cameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var jarButton: UIButton!
    @IBOutlet weak var cardboardButton: UIButton!
    @IBOutlet weak var waterBottleButton: UIButton!
    @IBOutlet weak var canButton: UIButton!
    @IBOutlet weak var wineButton: UIButton!
    @IBOutlet weak var milkButton: UIButton!
    
    var detailsViewColor = "Red"
    var detailsViewImage = UIImage(named: "Jar")
    
    override func viewDidLoad() {
        centerView.layer.cornerRadius = 60
        centerView.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = 20
        cameraButton.showsTouchWhenHighlighted = true
        
        jarButton.layer.cornerRadius = 35
        jarButton.showsTouchWhenHighlighted = true
        cardboardButton.layer.cornerRadius = 35
        cardboardButton.showsTouchWhenHighlighted = true
        waterBottleButton.layer.cornerRadius = 35
        waterBottleButton.showsTouchWhenHighlighted = true
        canButton.layer.cornerRadius = 35
        canButton.showsTouchWhenHighlighted = true
        wineButton.layer.cornerRadius = 35
        wineButton.showsTouchWhenHighlighted = true
        milkButton.layer.cornerRadius = 35
        milkButton.showsTouchWhenHighlighted = true
    }
    
    var prediction: String = "nil"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? DetailsViewController
        vc?.viewColor = detailsViewColor
        vc?.viewImage = detailsViewImage
        vc?.prediction = prediction
        prediction = "nil"
    }
    
    @IBAction func jarButtonPressed(_ sender: Any) {
        detailsViewColor = "Red"
        detailsViewImage = UIImage(named: "Jar")
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    @IBAction func cardboardButtonPressed(_ sender: Any) {
        detailsViewColor = "Blue"
        detailsViewImage = UIImage(named: "Cardboard")
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    @IBAction func canButonPressed(_ sender: Any) {
        detailsViewColor = "Purple"
        detailsViewImage = UIImage(named: "Can")
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    @IBAction func milkButtonPressed(_ sender: Any) {
        detailsViewColor = "Orange"
        detailsViewImage = UIImage(named: "Milk")
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    @IBAction func waterButtonPressed(_ sender: Any) {
        detailsViewColor = "Green"
        detailsViewImage = UIImage(named: "Water")
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    @IBAction func wineButtonPressed(_ sender: Any) {
        detailsViewColor = "Yellow"
        detailsViewImage = UIImage(named: "Wine")
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        detailsViewColor = "Camera"
        let alert = UIAlertController(title: "Select Image From:", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.launchCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photos Library", style: .default, handler: { _ in
            self.showPhotosLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func launchCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "There's no camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showPhotosLibrary(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private lazy var module: TorchModule = {
        if let filePath = Bundle.main.path(forResource: "model", ofType: "pt"),
            let module = TorchModule(fileAtPath: filePath) {
            return module
        } else {
            fatalError("Can't find the model file!")
        }
    }()

    private lazy var labels: [String] = {
        if let filePath = Bundle.main.path(forResource: "words", ofType: "txt"),
            let labels = try? String(contentsOfFile: filePath) {
            return labels.components(separatedBy: .newlines)
        } else {
            fatalError("Can't find the text file!")
        }
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                self.detailsViewImage = image
                self.predictImage(image: image)
                self.performSegue(withIdentifier: "detailsSegue", sender: nil)
            }
        }
    }
    
    func predictImage(image: UIImage) {
        let resizedImage = image.resized(to: CGSize(width: 224, height: 224))
        guard var pixelBuffer = resizedImage.normalized() else {
            return
        }
        guard let outputs = module.predict(image: UnsafeMutableRawPointer(&pixelBuffer)) else {
            return
        }
        let zippedResults = zip(labels.indices, outputs)
        let sortedResults = zippedResults.sorted { $0.1.floatValue > $1.1.floatValue }.prefix(3)
        for result in sortedResults {
            if(prediction == "nil") {
                prediction = "\(labels[result.0]) \n\n"
            }
        }
    }
    
}
