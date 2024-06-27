
 ![ic_launcher_round](https://user-images.githubusercontent.com/87064627/227796621-c135771d-8554-40aa-b913-9aa6c96a5cf3.png)

# Project Kepler App 
📖 Kepler App is your gateway to the cosmos. It provides up-to-date information on space launches, news, and more, alongside an integrated chatbot powered by OpenAI, offering contextual responses to enhance your space exploration experience.

Inspired by apps like Space Launch Now and Go4liftoff, Kepler App leverages the robust data from the Launch Library API to deliver comprehensive and timely space-related content.

🌌 Features
Space Launches: Get detailed information on upcoming and past space launches.
Space News: Stay updated with the latest news and analytical articles in the field of space exploration.
Interactive Chatbot: An AI-powered chatbot that provides precise answers based on the context of the displayed data.
🛠️ Technologies
State Management: Implemented using BloC.
Architecture: Clean architecture ensuring scalability and maintainability.
Theming: Supports day/night mode with proper theming (see Flutter themes).
Localization: Supports English and Ukrainian.
Authentication: Firebase Auth integration.
Data Storage: Uses Firestore for storing data.

📦 Packages and Tools
- dio: For HTTP requests.
- json_serializable: For code generation.
- bloc: For state management.
- intl: For localization.
- shared_preferences: For local storage of settings like language and theme.
- firebase_auth: For authentication.
- google_sign_in: For Google sign-in.
- cloud_firestore: For cloud data storage (e.g., saving favorite launches).
- connectivity_plus: To check internet connectivity, preventing sign-in and log-out events when offline.

🤖 Chatbot Functionality
The chatbot is powered by OpenAI's GPT-3.5 Turbo, configured to act as an astronomical assistant. It uses context-aware responses to answer user queries effectively, enhancing the user experience with relevant and informative replies.
