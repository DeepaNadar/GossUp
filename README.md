# GossUp - Flutter Firebase Chat App with Google Sign-in
### This Flutter app allows users to sign in using their Google account and interact with other users through a chat interface. The app utilizes Firebase for authentication, real-time messaging, and storage. <br/>
## Features: <br/>
1. **Google Sign-In**: Users can log in using their Google accounts for a seamless authentication process.
1. **Home Screen**: Upon logging in, users are greeted with a home screen. The app bar in the top-left corner features a "Logout" button that allows users to sign out.
1. **Search Functionality**: Users can search for other registered users using the search button. This enables them to find and initiate conversations with other app users.
1. **Account Profile**: Tapping the "Account" button on the home screen opens the user's profile. Here, they can view and update their name, profile picture, and about information.
1. **Chat Screen**: Users can select other users from the list and engage in real-time conversations. The chat interface supports read receipts (blue ticks) to indicate message read status.
1. **Message Management**: Users can copy the text of messages and delete specific messages within a conversation.
1. **Media Sharing**: Users can send images within the chat. They can also delete and download images.
1. **Online Status**: The app displays users' last seen status and indicates whether they are currently online.
1. **Push Notifications**: The app utilizes Firebase Cloud Messaging (FCM) REST API to deliver push notifications. Users receive notifications even when the app is closed, ensuring timely message alerts.
## Screenshots:
![GossUp1](https://github.com/DeepaNadar/GossUp/assets/141585733/c32a229e-90a9-4cb9-8472-3e1c8f16c4a2) ![GossUp2](https://github.com/DeepaNadar/GossUp/assets/141585733/bb10bc4b-c95a-4ee4-8481-8d6e80fd83c2)
![GossUp3](https://github.com/DeepaNadar/GossUp/assets/141585733/157bc653-5617-4296-95fd-220e00b409aa) ![GossUp4](https://github.com/DeepaNadar/GossUp/assets/141585733/4625c5ac-a035-4dea-9590-e42e812b904d)
![GossUp5](https://github.com/DeepaNadar/GossUp/assets/141585733/1e9f22c1-57ec-4958-8469-f35b4c004e13) ![GossUp6](https://github.com/DeepaNadar/GossUp/assets/141585733/3462e3ea-8f7e-4429-8cdb-7e0383ab2e46)
![GossUp7](https://github.com/DeepaNadar/GossUp/assets/141585733/1321dfab-46cc-4944-b29c-41bfa4a759a5) ![GossUp8](https://github.com/DeepaNadar/GossUp/assets/141585733/2697f160-57f7-4903-bfeb-6a238371d6d1)
![GossUp9](https://github.com/DeepaNadar/GossUp/assets/141585733/3bdbb957-2217-4962-8caa-b65beef465b9) ![GossUp10](https://github.com/DeepaNadar/GossUp/assets/141585733/7a12373d-2088-4fe6-9e74-9ba15e7875d6)
![GossUp11](https://github.com/DeepaNadar/GossUp/assets/141585733/ea142464-887f-4149-92ec-0ec644c06e81)
## Dependencies:
- [firebase_core](https://pub.dev/packages/firebase_core): ^2.15.0
- [firebase_auth](https://pub.dev/packages/firebase_auth): ^4.7.2
- [google_sign_in](https://pub.dev/packages/google_sign_in): ^6.1.4
- [cloud_firestore](https://pub.dev/packages/cloud_firestore): ^4.8.4
- [cached_network_image](https://pub.dev/packages/cached_network_image): ^3.2.3
- [image_picker](https://pub.dev/packages/image_picker): ^1.0.2
- [firebase_storage](https://pub.dev/packages/firebase_storage): ^11.2.5
- [emoji_picker_flutter](https://pub.dev/packages/emoji_picker_flutter): ^1.6.1
- [firebase_messaging](https://pub.dev/packages/firebase_messaging): ^14.6.5
- [http](https://pub.dev/packages/http): ^0.13.5
- [flutter_notification_channel](https://pub.dev/packages/flutter_notification_channel): ^2.0.0
- [gallery_saver](https://pub.dev/packages/gallery_saver): ^2.3.2













