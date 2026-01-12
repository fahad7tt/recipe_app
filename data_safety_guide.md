# Google Play Data Safety Guide - Recipe Book

Based on your current codebase, here is how you should answer the Data Safety questions in the Google Play Console.

## 1. Data Collection and Security

| Question | Answer | Reason |
| :--- | :--- | :--- |
| Does your app collect or share any of the required user data types? | **Yes** | Recommended to be safe, as you handle Email, Username, and Photos, even if stored locally. |
| Is all of the user data collected by your app encrypted in transit? | **Yes** | When you eventually add a backend (like Firebase), it handles encryption by default. |
| Do you provide a way for users to request that their data is deleted? | **Yes** | You should provide an email or in-app button for this. |

## 2. Data Types Collected

Select the following categories:

### Personal Info
- **Name**: (Username)
- **Email address**: (User email)

### Photos and Videos
- **Photos**: (Since you use `image_picker` to allow users to add recipe photos)

## 3. Data Usage and Handling

For each data type selected above (Name, Email, Photos), answer as follows:

- **Is this data collected, shared, or both?** -> **Collected**
- **Is this data processed ephemerally?** -> **No** (Stored in Hive)
- **Is this data required for your app, or can users choose whether it's collected?** -> **Required** (For account creation/recipe features)
- **Why is this user data collected?**
  - Select: **App functionality**, **Account management**

---

## 4. Account Deletion URL

Google Play requires a dedicated URL for account deletion. You can use the one I just created for you:

**URL**: `https://recipe--application.web.app/delete-account.html`

(Note: You will need to run `firebase deploy` to make this URL live).

### Important: Fix for Privacy Policy
Your code at `lib/user/profile/privacy_policy.dart` uses a WebView to load your policy. This currently **only works in debug mode**. To make it work for users who download the app from the Play Store, you must add the Internet permission to your main manifest.

I have included this fix in the implementation plan.
