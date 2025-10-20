//
//  EditProfileViewControllerDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

protocol EditProfileViewControllerDelegate: AnyObject {
    
    func editProfileViewController(_ controller: EditProfileViewController, didUpdate user: User)
}
