# GossUp - Flutter Firebase Chat App with Google Sign-in
This Flutter app allows users to sign in using their Google account and interact with other users through a chat interface. The app utilizes Firebase for authentication, real-time messaging, and storage. <br/>
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
![GossUp1](https://github.com/d33pa-n/GossUp/assets/141585733/21ac39c5-8e64-43d8-aba9-5153bc07776f) ![GossUp2](https://github.com/d33pa-n/GossUp/assets/141585733/29867bc9-a381-4572-bea1-e58441f3c702) ![GossUp3](https://github.com/d33pa-n/GossUp/assets/141585733/6a9da383-8cbb-45cc-9f50-24ca8ff234ab)
![GossUp4](https://github.com/d33pa-n/GossUp/assets/141585733/797178fc-22d1-4cb0-a13c-0677e2d19b7c) ![GossUp5](https://github.com/d33pa-n/GossUp/assets/141585733/015eeb16-917c-4b83-b201-49d01d36c908) ![GossUp6](https://github.com/d33pa-n/GossUp/assets/141585733/6c4ab963-b847-46cc-8855-d78a71c3f862)
![GossUp7](https://github.com/d33pa-n/GossUp/assets/141585733/948c73fe-0f0f-464f-9a95-7ae0b69d7add) ![GossUp8](https://github.com/d33pa-n/GossUp/assets/141585733/60688b49-b02d-4ae4-80ac-03dcf76a2bfd) ![GossUp9](https://github.com/d33pa-n/GossUp/assets/141585733/98b287c6-e584-4f89-bc44-285626ca00d9)
![GossUp10](https://github.com/d33pa-n/GossUp/assets/141585733/fe75487c-90d3-427b-8afb-8a88d1de6622) ![GossUp11](https://github.com/d33pa-n/GossUp/assets/141585733/020038d1-59ad-4eb9-9889-14b56b35cf13)

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













