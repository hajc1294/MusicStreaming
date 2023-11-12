# MusicStreaming

Music streaming application built in **Swift** and integrated with Firebase.

![](https://camo.githubusercontent.com/cbe540fa5f1bd4860434caea1ebe43419ed42d92d54084d529c3a93a67139f10/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f73776966742532302d2532334641373334332e7376673f267374796c653d666f722d7468652d6261646765266c6f676f3d7377696674266c6f676f436f6c6f723d7768697465)

### Implementation

The application was developed in **Swift**, **MVVM** was used as the architectural pattern to decouple the user interface from the application logic, and the implementation also aims to adhere to the principles specified for **Clean Architecture**.

The application connects to Firebase (streaming server), from which it retrieves playlist data, cover images, and tracks for playback. The following services are used:

- **Firebase Firestore Database**
- **Firebase Storage**

The structure for playlist data in the database has the following format (as can be seen in the source code):

```
{
   id: {
      name (String): name
      band (String): band
      album (String): album
      year (String): year
      duration (String): duration
      image (String): image
      resource (String): resource
   }
}
```

The fields **'image'** and **'resource'** refer to **Firebase Storage** URLs; the first one for downloading the image and the second one for playing the song.

### How to set up?

#### Firebase

To be able to run the project, the following steps are necessary:

- Create a project in **Firebase** and configure it.
- Add your application to the **Firebase** project.
- Enable the necessary services (**Firebase Firestore Database** and **Firebase Storage**).
- Specify the access rules for these services to avoid access denied issues.

If you are using a free plan for the **Firebase** application, keep in mind that downloads to **Firebase Storage** are limited (bandwidth per day).

#### iOS App

All you need to do is add the **GoogleServices-Info.plist** file to the project, which is generated during the **Firebase** configuration stage, and also install the **Firebase SDK** in the project (via **CocoaPods**, **Swift Package Manager**, etc).

Finally, this project uses Swift Package Manager for third-party libraries, and the following ones are used:

- **Firebase SDK**: https://swiftpackageindex.com/firebase/firebase-ios-sdk
- **RxSwift**: https://swiftpackageindex.com/ReactiveX/RxSwift

#### Screenshots

<img src="https://github.com/hajc1294/MusicStreaming/assets/61942641/434389b3-0a37-42e8-930c-57846f5ede0a" width="250">   <img src="https://github.com/hajc1294/MusicStreaming/assets/61942641/7eee86e3-9fc6-4961-9de6-9f4faed39532" width="250">   <img src="https://github.com/hajc1294/MusicStreaming/assets/61942641/ff2724e4-df37-42ae-9054-b9366dc2bbfb" width="250">

### Documentation

Here some important links that can help you:

- Add **Firebase** to your **Apple project**: https://firebase.google.com/docs/ios/setup
- **Cocoapods**: https://guides.cocoapods.org/using/getting-started.html
- **AVPlayer**: https://developer.apple.com/documentation/avfoundation/avplayer/

About the project:

- Credits to activity indicator: https://github.com/erangaeb/dev-notes/blob/master/swift/ViewControllerUtils.swift
- App logo comes from here: https://www.brandcrowd.com/
- Soundwave image comes from here: https://es.vecteezy.com/arte-vectorial/7266126-vector-abstracto-con-ondas-sonoras-dinamicas-fondo-musica-espectro-neon-lines-digital-audio-studio-abstract-background



