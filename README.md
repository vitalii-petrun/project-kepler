
 ![ic_launcher_round](https://user-images.githubusercontent.com/87064627/227796621-c135771d-8554-40aa-b913-9aa6c96a5cf3.png)

# Project Kepler App 
📖 Kepler App provides up-to-date information on space launches, news, and more, alongside an integrated chatbot powered by OpenAI, offering contextual responses to enhance your space exploration experience.

Inspired by apps like Space Launch Now and Go4liftoff, Kepler App leverages the robust data from the Launch Library API to deliver comprehensive and timely space-related content.

🌌 Features
- Space Launches, News and Events: Get detailed information on upcoming and past space launches,the latest news and analytical articles in the field of space exploration and space events
- Saving to favorites + notifications: After loggin in you can save launches, news and events to favs and receive notifications when they're about to start.
- Set your experience: choose beetwen english and ukrainian languages, customize theme and screen refresh rate
- Interactive Chatbot: An AI-powered chatbot that provides precise answers based on the context of the displayed data.
  
🛠️ Technologies
- State Management: Implemented using BloC.
- Architecture: Clean architecture ensuring scalability and maintainability.
- Theming: Supports day/night mode with proper theming (see Flutter themes).
- Localization: Supports English and Ukrainian.
- Authentication: Firebase Auth integration.
- Data Storage: Uses Firestore for storing data.

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
- mockito: For unit testing and mocking dependencies.
- dart_openai: For interacting with OpenAI's API.
- flutter_dotenv: For managing environment variables.
- get_it + injectable: For dependency injection.
- lottie: For adding beautiful animations.

🤖 Chatbot Functionality
- The chatbot is powered by OpenAI's GPT-3.5 Turbo, configured to act as an astronomical assistant. It uses context-aware responses to answer user queries effectively, enhancing the user experience with relevant and informative replies.

🌐 API Integration
- Kepler App uses the [Launch Library 2 API](https://thespacedevs.com/llapi) for space launch data and the [Spaceflight News API](https://thespacedevs.com/snapi) for news and articles. Both APIs come with Swagger documentation, simplifying integration and development.
