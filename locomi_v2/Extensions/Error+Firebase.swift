//
//  Error+Firebase.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension Error {

    var firebaseAuthErrorInfo: (title: String, message: String) {
        guard let authErrorCode = AuthErrorCode(rawValue: (self as NSError).code) else {
            return (title: "Error", message: localizedDescription)
        }

        switch authErrorCode.code {
        case .emailAlreadyInUse:
            return (
                title: "Email Already Registered",
                message: "This email address is already registered. Please use a different email or try logging in."
            )

        case .invalidEmail:
            return (
                title: "Invalid Email",
                message: "The email address format is invalid. Please check and try again."
            )

        case .weakPassword:
            return (
                title: "Weak Password",
                message: "The password is too weak. Please use a stronger password with at least 6 characters."
            )

        case .networkError:
            return (
                title: "Network Error",
                message: "Unable to connect to the network. Please check your internet connection and try again."
            )

        case .operationNotAllowed:
            return (
                title: "Authentication Error",
                message: "Email/password authentication is not enabled. Please contact support."
            )

        case .tooManyRequests:
            return (
                title: "Too Many Attempts",
                message: "Too many unsuccessful attempts. Please try again later."
            )

        case .userDisabled:
            return (
                title: "Account Disabled",
                message: "This account has been disabled. Please contact support for assistance."
            )

        case .invalidCredential:
            return (
                title: "Invalid Credentials",
                message: "The credentials provided are invalid. Please try again."
            )

        case .wrongPassword:
            return (
                title: "Incorrect Password",
                message: "The password you entered is incorrect. Please try again."
            )

        case .userNotFound:
            return (
                title: "Account Not Found",
                message: "No account found with this email address. Please sign up first."
            )

        case .accountExistsWithDifferentCredential:
            return (
                title: "Account Exists",
                message: "An account already exists with the same email but different sign-in credentials."
            )

        case .requiresRecentLogin:
            return (
                title: "Re-authentication Required",
                message: "This operation requires recent authentication. Please log in again."
            )

        case .credentialAlreadyInUse:
            return (
                title: "Credential In Use",
                message: "This credential is already associated with a different account."
            )

        case .invalidUserToken:
            return (
                title: "Session Expired",
                message: "Your session has expired. Please log in again."
            )

        case .userTokenExpired:
            return (
                title: "Token Expired",
                message: "Your authentication token has expired. Please log in again."
            )

        default:
            return (
                title: "Error",
                message: "An unexpected error occurred: \(localizedDescription)"
            )
        }
    }

    var firestoreErrorInfo: (title: String, message: String) {
        let nsError = self as NSError
        guard let firestoreErrorCode = FirestoreErrorCode.Code(rawValue: nsError.code) else {
            return (title: "Error", message: localizedDescription)
        }

        switch firestoreErrorCode {
        case .cancelled:
            return (
                title: "Operation Cancelled",
                message: "The operation was cancelled."
            )

        case .unknown:
            return (
                title: "Unknown Error",
                message: "An unknown error occurred. Please try again."
            )

        case .invalidArgument:
            return (
                title: "Invalid Data",
                message: "The data provided is invalid. Please check and try again."
            )

        case .deadlineExceeded:
            return (
                title: "Timeout",
                message: "The operation took too long. Please try again."
            )

        case .notFound:
            return (
                title: "Not Found",
                message: "The requested document or collection was not found."
            )

        case .alreadyExists:
            return (
                title: "Already Exists",
                message: "A document with this ID already exists."
            )

        case .permissionDenied:
            return (
                title: "Permission Denied",
                message: "You don't have permission to perform this action."
            )

        case .resourceExhausted:
            return (
                title: "Quota Exceeded",
                message: "Resource quota has been exceeded. Please try again later."
            )

        case .failedPrecondition:
            return (
                title: "Operation Failed",
                message: "The operation failed due to a system state issue."
            )

        case .aborted:
            return (
                title: "Operation Aborted",
                message: "The operation was aborted. Please try again."
            )

        case .outOfRange:
            return (
                title: "Out of Range",
                message: "The operation was attempted past the valid range."
            )

        case .unimplemented:
            return (
                title: "Not Implemented",
                message: "This operation is not implemented or supported."
            )

        case .internal:
            return (
                title: "Internal Error",
                message: "An internal server error occurred. Please try again later."
            )

        case .unavailable:
            return (
                title: "Service Unavailable",
                message: "The service is currently unavailable. Please try again later."
            )

        case .dataLoss:
            return (
                title: "Data Loss",
                message: "Unrecoverable data loss or corruption occurred."
            )

        case .unauthenticated:
            return (
                title: "Not Authenticated",
                message: "You need to be logged in to perform this action."
            )

        default:
            return (
                title: "Error",
                message: "An unexpected error occurred: \(localizedDescription)"
            )
        }
    }
}
