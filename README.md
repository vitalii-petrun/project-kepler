
 ![ic_launcher_round](https://user-images.githubusercontent.com/87064627/227796621-c135771d-8554-40aa-b913-9aa6c96a5cf3.png)

 
 
# Project Kepler App 
📖 An app about space: launches, news, etc.

Made on Dart&Flutter in educational purposes.

Based on https://thespacedevs.com/llapi API and inspired by Space Launch Now and Go4liftoff apps.

Contains:
- Launch dates of rockets/space missions. ✓
- ? tab with videos from https://www.youtube.com/channel/UCi0Z9L9HrhD7oYpMs2pLxSw channel, in case UA localization is choosen.

Technologies:
- BloC for state management. ✓
- Clean architecture. ✓
- Day/night mode and right theming in general (https://docs.flutter.dev/cookbook/design/themes). ✓
- Localization (ENG/UKR). ✓
- Firebase Auth ✓
- Firestore keeping data ✓
- Introducing screen  ?


Packages and tools used to create app:
- dio (http requests)
- json_serialazible (code gen)
- bloc (state management)
- intl (localization)
- shared_preferences (to locally keep app settings, such as lang or theme)
- firebase_auth 
- google_sign_in 
- cloud_firestore (save favorite launches on cloud)
- connectivity_plus (to check if user has internet, otherwise prevent sign in, log out events)




