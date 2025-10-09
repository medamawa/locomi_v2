//
//  String+Validation.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import Foundation

extension String {

    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isBlank: Bool {
        return trimmed.isEmpty
    }

    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailPredicate.evaluate(with: self)
    }

    var isValidPassword: Bool {
        guard count >= 8 else { return false }

        let hasUppercase = range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = range(of: "[a-z]", options: .regularExpression) != nil
        let hasNumber = range(of: "[0-9]", options: .regularExpression) != nil

        return hasUppercase && hasLowercase && hasNumber
    }

    var isValidUsername: Bool {
        guard count >= 3 else { return false }

        let usernameRegex = "^[a-zA-Z0-9_]+$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: self)
    }
}
