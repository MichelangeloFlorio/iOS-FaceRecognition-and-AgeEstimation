//
//  ViewController.swift
//  faceID
//
//  Created by Davide on 20/05/2020.
//  Copyright © 2020 Davide. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let menuNames = ["FACE DETECTION", "LABELS", "AGE ESTIMATION"]
    let menuImages = [UIImage(named: "pic_camera2"), UIImage(named: "pic_labels2"), UIImage(named: "pic_age2")]
    let menuDescriptions = ["Detect people and recognize them", "Discover all the people into the dataset", "Estimate people's age"]
    let menuButtons = ["DETECT", "EXPLORE", "ESTIMATE"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func btn_camera(_ sender: UIButton) {
        self.animateView(sender)
        let cameraController = UIStoryboard(name: "Camera", bundle: nil).instantiateViewController(withIdentifier: "Camera") as! CameraController
        self.present(cameraController, animated: true, completion: nil)

    }
    
    fileprivate func animateView(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0.3, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    @IBAction func btn_labels(_ sender: UIButton) {
        self.animateView(sender)
        let listController = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "List") as! ListController
        self.present(listController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.menuLabel.text = menuNames[indexPath.row]
        cell.menuImage.image = menuImages[indexPath.row]
        cell.menuImage.layer.cornerRadius = 10.0
        cell.menuDescription.text = menuDescriptions[indexPath.row]
        let btn = UIButton(frame: CGRect(x: 20, y: 190, width: 150,height: 40))
        btn.contentHorizontalAlignment = .center
        btn.tag = indexPath.row
        btn.setTitle(menuButtons[indexPath.row], for: .normal)
        btn.setTitleColor(.white, for: .normal)
        if indexPath.row == 0 {
            btn.addTarget(self, action: #selector(self.btn_camera), for: .touchUpInside)
        }
        else if indexPath.row == 1 {
            btn.addTarget(self, action: #selector(self.btn_labels), for: .touchUpInside)
        } else {
            btn.addTarget(self, action: #selector(self.btn_age), for: .touchUpInside)
        }
        btn.isUserInteractionEnabled = true
        btn.backgroundColor = UIColor(red: 0.1, green: 0.15, blue: 0.3, alpha: 10)
        btn.layer.cornerRadius = 10.0
        cell.addSubview(btn)
        
        //This creates the shadows and modifies the cards a little bit
        cell.layer.cornerRadius = 10.0
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuNames.count
    }
    
    @IBAction func btn_age(_ sender: UIButton) {
        self.animateView(sender)
        let ageController = UIStoryboard(name: "Age", bundle: nil).instantiateViewController(withIdentifier: "Age") as! AgeController
        self.present(ageController, animated: true, completion: nil)
    }
}

