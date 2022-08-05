<img id="top" src="./readme/title1.svg"/>

<div align="center">

> Hello world! This is the project’s summary that describes the project plain and simple, limited to the space available.  

**[PROJECT PHILOSOPHY](#project_philosophy) • [WIREFRAMES](#wireframes) • [TECH STACK](#tech_stack) • [IMPLEMENTATION](#implementation) • [HOW TO RUN?](#how_to_run)**

</div>

<br><br>


<img id="project_philosophy" src="./readme/title2.svg"/>

> Medically is a mobile application that allows users to reach out to registered doctors on the platform, place a paid call, rate, review, and add them to their favorites list.

<br>

### User Stories
- As a user, I want to consult an admin for urgent issue without waiting for an appointment.
- As a user, I want to share my experience with the doctor I called.

<br>

### Doctor Stories
- As a doctor, I want to answer or decline incoming calls.
- As a doctor, I want to be able to go online or offline.
- As a doctor, I want to get a revenue from answering to patients calls.

<br>

### Admin Stories
- As an admin, I want to accept or decline requested doctors.
- As an admin, I want to add new domains.
- As an admin, I want to track the stats of all users and doctors.

<br><br>

<div align="center">

**[PROJECT PHILOSOPHY](#project_philosophy) • [WIREFRAMES](#wireframes) • [TECH STACK](#tech_stack) • [IMPLEMENTATION](#implementation) • [HOW TO RUN?](#how_to_run)• [BACK TO TOP](#top)**

</div>

<br><br>

<img id="wireframes" src="./readme/title3.svg"/>

> This design was planned before on paper, then moved to Figma app for the fine details.
Note that I didn't use any styling library or theme, all from scratch.

<br>

| Login                                 | Sign up                                | User - Home                               | User - Favorites                              |
| ------------------------------------- | -------------------------------------- | ----------------------------------------- | --------------------------------------------- |
| <img src="./readme/figma/login.png"/> | <img src="./readme/figma/signup.png"/> | <img src="./readme/figma/user-home.png"/> | <img src="./readme/figma/user-favorite.png"/> |

| User - Logs                                | User - Profile                               | User - Doctor Info                         | Doctor - Reviews                               |
| ------------------------------------------ | -------------------------------------------- | ------------------------------------------ | ---------------------------------------------- |
|  <img src="./readme/figma/user-logs.png"/> | <img src="./readme/figma/user-profile.png"/> | <img src="./readme/figma/doctorinfo.png"/> | <img src="./readme/figma/doctor-reviews.png"/> |

<div align="center">

| Doctor - Logs                               | Doctor - Profile                               |
| ------------------------------------------- | ---------------------------------------------- |
| <img src="./readme/figma/doctor-logs.png"/> | <img src="./readme/figma/doctor-profile.png"/> |

</div>

<br><br>

<div align="center">

**[PROJECT PHILOSOPHY](#project_philosophy) • [WIREFRAMES](#wireframes) • [TECH STACK](#tech_stack) • [IMPLEMENTATION](#implementation) • [HOW TO RUN?](#how_to_run)• [BACK TO TOP](#top)**

</div>

<br><br>

<img id="tech_stack" src="./readme/title4.svg"/>

>Here's a brief high-level overview of the tech stack the app uses:

<br>

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase.
- For the backend, the app uses [Laravel](https://laravel.com/) framework. Laravel is a free and open-source PHP web framework, intended for the development of web applications following the model–view–controller architectural pattern and based on Symfony.
- For persistent storage (database), the app uses [MySQL](https://www.mysql.com/) database.
- For the video call system, the app uses the [agora_uikit](https://pub.dev/packages/agora_uikit) package.
- The app uses the font [Roboto](https://fonts.google.com/specimen/Roboto) as its main font, and the design of the app adheres to the material design guidelines.


<br><br>

<div align="center">

**[PROJECT PHILOSOPHY](#project_philosophy) • [WIREFRAMES](#wireframes) • [TECH STACK](#tech_stack) • [IMPLEMENTATION](#implementation) • [HOW TO RUN?](#how_to_run)• [BACK TO TOP](#top)**

</div>

<br><br>

<img id="implementation" src="./readme/title5.svg"/>

<br>

* User Screens

| Login                                  | Home                                         | Navigation                                | Filter                                     |
| -------------------------------------- | -------------------------------------------- | ----------------------------------------- | ------------------------------------------ |
| <img src="./readme/gifs/login.gif"/>   | <img src="./readme/gifs/home-scroll.gif"/>   | <img src="./readme/gifs/navigation.gif"/> | <img src="./readme/gifs/home-filter.gif"/> |

| Add Balance                                  | Update Image                                  | Review                                | Favoriting                                |
| -------------------------------------------- | --------------------------------------------- | ------------------------------------- | ----------------------------------------- |
| <img src="./readme/gifs/add-balance.gif"/>   | <img src="./readme/gifs/delete-image.gif"/>   | <img src="./readme/gifs/review.gif"/> | <img src="./readme/gifs/unfavorite.gif"/> |



<br>

* Dark Mode


<p align="center">
<img src="./readme/gifs/dark-mode.gif" width="250"/>
</p>

| Home                                   | Favorites                                   | Logs                                   | Profile                                   |
| -------------------------------------- | ------------------------------------------- | -------------------------------------- | ----------------------------------------- |
| <img src="./readme/device/home2.png"/> | <img src="./readme/device/favorites2.png"/> | <img src="./readme/device/logs2.png"/> | <img src="./readme/device/profile2.png"/> |

| Balance                                   | Doctor Info                                  |
| ----------------------------------------- | -------------------------------------------- |
| <img src="./readme/device/balance2.png"/> | <img src="./readme/device/doctorinfo2.png"/> |

<br>

* Doctor Screens


| Profile                                       | Reviews                                         | Logs                                         | Edit                                       |
| --------------------------------------------- | ----------------------------------------------- | -------------------------------------------- | ------------------------------------------ |
| <img src="./readme/gifs/doctor-profile.gif"/> | <img src="./readme/device/doctor-reviews.png"/> | <img src="./readme/device/doctor-logs.png"/> | <img src="./readme/gifs/doctor-edit.gif"/> |

<br>

* Call System


| Calling                                | Video Call                                       | Ringing                                |
| -------------------------------------- | ------------------------------------------------ | -------------------------------------- |
| <img src="./readme/gifs/calling.gif"/> | <img src="/readme/device/call.gif" width="220"/> | <img src="./readme/gifs/ringing.gif"/> |


| Call Responses                             |
| ------------------------------------------ |
| <img src="./readme/device/responses.png"/> |

<br>

* Admin Panel

| Doctors Data                                   |
| ---------------------------------------------- |
| <div align="center"> <img src="./readme/device/admin-doctors.PNG"/> </div> |

| Users Data                                   |
| -------------------------------------------- |
| <div align="center"> <img src="./readme/device/admin-users.PNG"/> </div> |

<div align="center">

| Hamburger Menu                                                    |
| ----------------------------------------------------------------- |
| <img src="./readme/device/admin-hamburger-menu.PNG" width="400"/> |

</div>

| Add Domain                                        | Requests                                        |
| ------------------------------------------------- | ----------------------------------------------- |
| <img src="./readme/device/admin-add-domain.PNG"/> | <img src="./readme/device/admin-requests.PNG"/> |

<div align="center">

| Accept Request                              |
| ------------------------------------------- |
| <img src="./readme/gifs/admin-accept.gif"/> |

</div> 

<br><br>

<div align="center">

**[PROJECT PHILOSOPHY](#project_philosophy) • [WIREFRAMES](#wireframes) • [TECH STACK](#tech_stack) • [IMPLEMENTATION](#implementation) • [HOW TO RUN?](#how_to_run)• [BACK TO TOP](#top)**

</div>

<br><br>

<img id="how_to_run" src="./readme/title6.svg"/>




### Prerequisites

* Flutter
* Android Studio
* Agora account
* 2 Android emulators

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/mohammad-jaffal/medically-project.git
   ```
2. Install packages for the React project
   ```sh
   npm install
   ```
3. Install packages for the Flutter project
   ```sh
   flutter pub get
   ```
4. Start backend server in cmd
   ```sh
   php artisan serve
   ```
5. Create agora project on the [agora](https://console.agora.io/) console and update app id in flutter project, then generate access token for each accepted doctor


<br><br>

<div align="center">

**[PROJECT PHILOSOPHY](#project_philosophy) • [WIREFRAMES](#wireframes) • [TECH STACK](#tech_stack) • [IMPLEMENTATION](#implementation) • [HOW TO RUN?](#how_to_run)• [BACK TO TOP](#top)**

</div>

<br><br>
