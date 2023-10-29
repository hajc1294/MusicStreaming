# MusicStreaming

Music streaming application built in Swift and integrated with Firebase.

![](https://camo.githubusercontent.com/cbe540fa5f1bd4860434caea1ebe43419ed42d92d54084d529c3a93a67139f10/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f73776966742532302d2532334641373334332e7376673f267374796c653d666f722d7468652d6261646765266c6f676f3d7377696674266c6f676f436f6c6f723d7768697465)

### Implementation

The application was developed in Swift, **MVVM** was used as the architectural pattern to decouple the user interface from the application logic, and the implementation also aims to adhere to the principles specified for **Clean Architecture**.

The application connects to Firebase (streaming server), from which it retrieves playlist data, cover images, and tracks for playback. The following services are used:

- Firebase Firestore Database
- Firebase Storage

The structure for playlist data in the database follows the following format (as can be seen in the source code):

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

