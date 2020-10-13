//
//  Secrets.swift
//  Kris
//
//  Created by Kristopher Jackson on 10/13/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import Foundation
import Firebase

let GOOGLE_API_KEY = "AIzaSyAD9ePBI2HZ1u8ScKgIc786N1b_S9jSmfM"
let KRIS_TOKEN = "cyBTZMXGgEJqvPAMU0QIjp:APA91bHWMk7awUcR_8X-xywGUzliCD6531OeR9aCLNNwcAVER-qfpabdLkt0dRc1ox9xuAUYRM5fthJW4o5Ixl6fcYv7MpL34zFybXekvWs4nnQgq00SUk1d6GSNOdvuJfybS69eIF1n"
let KRIS_DEVICE_ID_1 = "480CAAB3-68AA-4488-9FB2-7337EE92C912"
let KRIS_DEVICE_ID_2 = "D6F2432E-99D2-404D-A5BA-BEA5AAFA36AA"
let KRIS_DEVICE_NAME = "KJ_pHQy7umXInI3qoPS"

let user: UserData = {
    let user = UserData()
    user.first = "Kristopher"
    user.last = "Jackson"
    user.summary = "Passionate developer and Computer Science major graduating in May"
    user.birthday = "July 3, 1998"
    user.phone = 2256105747
    user.email = "kristopherrjackson@gmail.com"
    user.pFirst = "Kris"
    user.linkedin = "https://www.linkedin.com/in/kristopherrjackson/"
    user.portfolio = "https://www.instagram.com/krisjackson.portfolio/"
    user.instagram = "https://www.instagram.com/kristopher.r.jackson/"
    user.resume = "https://firebasestorage.googleapis.com/v0/b/krisjackson-84f1b.appspot.com/o/Resume.pdf?alt=media"
    user.website = "https://www.kristopherjackson.com"
    user.stay = "Memphis, Tennessee"
    user.objective = "Building beautiful, cutting-edge products is my passion. My mission is to deliver robust software that inspires others to change the world. I code with passion and lead with purpose, and I am willing to tear down, restructure, and rebuild to transform something into a masterpiece that benefits the lives of others."
    return user
}()

let highschool: Education = {
    let school = Education()
    school.name = "Episcopal School of BR"
    school.phone = 2257533180
    school.state = "Louisiana"
    school.state_abr = "LA"
    school.type = "High School"
    school.website = "https://www.episcopalbr.org"
    school.location = GeoPoint(latitude: 30.422687, longitude: -91.032938)
    school.graduation = "May 2017"
    school.city = "Baton Rouge"
    school.address = "3200 Woodland Ridge Blvd Baton Rouge, LA 70816 United States"
    return school
}()

let college: Education = {
    let school = Education()
    school.name = "Rhodes College"
    school.phone = 8008445969
    school.state = "Tennessee"
    school.state_abr = "TN"
    school.time = "August 2017 - Present"
    school.type = "College"
    school.website = "https://www.rhodes.edu"
    school.major = "Computer Science"
    school.location = GeoPoint(latitude: 35.155687, longitude: -89.988937)
    school.graduation = "May 2021"
    school.city = "Memphis"
    school.address = "2000 North Pkwy Memphis, TN 38112 United States"
    school.classes = "Operating Systems; Computer Networks; Software Engineering; Graphics, Virtual Environments, and Human Computer Interaction; Databases; Distributed Systems; Computer Organization; Discrete Structures; Data Structures and Algorithms; Advanced Algorithms; Object Oriented Programming"
    return school
}()
