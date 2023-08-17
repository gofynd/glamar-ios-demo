# iOS SDK

With GlamAR iOS SDK, you can apply different SKUs such as lipstick, blush, eyeliner and eyeshadow.

## Installation

> :bulb: **Note** 
> * You can only apply SKUs that you’ve already configured in the Admin Panel.
> * With the GlamAR SDK, you can take snapshots of the preview, change the makeup opacity and even capture a video recording.
> * Because the GlamAR SDK can apply makeup in real-time, you can use it in applications such as displaying your shop’s cataolgue.



Before running or building the app or project you need to enter the API key, you can access one from the admin panel dashboard. The API key has to be passed when you are initializing the GlamARCommunication class.

```swift
    GAR.InitGlamAR(API_KEY: "GlamAR Activation Key", callback: self)
```


## Integrating Unity as a Library into an iOS Project

There are two ways through which you can integrate Unity as a library into any iOS project i.e. in an existing project and in a new project. Let’s understand each way separately:

### Download the GlamAR iOS SDK

Download the [GlamAR iOS SDK](https://cdn.pixelbin.io/v2/glamar-fynd-835885/OYXZ4F/original/glamar_ios_sdk.zip) from the attached link. Once downloaded, extract the archive into your project’s root directory.

### **Requirements**

Before proceeding with the integration, ensure your development environment meets the following prerequisites:

* Xcode 9.4 or later version.

#### **Steps to Integrate GlamAR SDK with iOS**

To establish a seamless connection between the exported Unity project and our SwiftUI app, follow these steps:

1. Open the *SwiftyUnitySdk.xcworkspace*, which currently comprises the *IosSdkGlamAr* project only.
2. In **Finder**, locate the *glamar_ios_sdk* folder and drag the *Unity-iPhone.xcodeproj* file into the **Navigator** panel of **Xcode**.
![Screenshot 1](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_1.png)
**(i)** At this point, your root workspace folder should contain the below-mentioned two project folders:

* YourProject: Represents the main iOS app.
* glamar_ios_sdk: Created by exporting the Unity game as an iOS project and Swift files.

1. Now, both *IosSdkGlamAr**.xcodeproj* and *Unity-iPhone.xcodeproj* are part of the same workspace.
    1. If your *Unity-iPhone.xcodeproj* appears in red after dragging, ensure that you set the **Location** to "**Relative to Workspace**" in the **Utilities** panel of the project.
    ![Screenshot 2](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_2.png)
2. Next, from the **Standard Editor **panel navigate to the *IosSdkGlamAr* project and select the *IosSdkGlamAr* target. Under the General tab, scroll down to the "**Frameworks, Libraries, and Embedded Content**" section. Click on the + button to add a new framework.
    ![Screenshot 3](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_3.png)
3. Include all the frameworks you have utilised in your project.
4. Select *UnityFramework.framework* from the list and add it to the project
    ![Screenshot 4](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_4.png)

1. Add the native side files of the SDK to your workspace, follow these steps:
    1. Navigate to the *`glamar_ios_sdk > NativeFiles`* folder.
    2. Select all three files in the *`NativeFiles`* folder.
    3. Drag and drop the selected files into the *IosSdkGlamAr* folder in the navigator panel, as shown in the image below.
    ![Screenshot 5](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_5.png)
2. After adding the SDK files to your workspace, follow these steps to link the `IosSdkGlamAr-Bridging-Header` header file to your project:
    1. Locate the `IosSdkGlamAr-Bridging-Header` header file in your workspace.
    ![Screenshot 6](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_6.png)
    2. Right-click on the header file and select `Show in Finder`.
    3. Copy the path of the header file.
    ![Screenshot 7](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_7.png)
    4. Open the `Build Settings` of your Xcode project.
    5. Search for `Objective C Bridging Header` and paste the copied path in the corresponding field.
    ![Screenshot 8](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_8.png)
    6. This will link the `IosSdkGlamAr-Bridging-Header` header file to your project, allowing you to communicate between Objective-C code and Swift files.
3. Change the **Target Membership** of the header file named *NativeCallProxy.h* from **Project** to **Public**. The file can be found at *Unity-iPhone > Libraries > Plugins > iOS > NativeCallProxy.h* within the **Navigator Panel** on the left-hand side. Change the membership from the **Utilities Panel** on the right-hand side.
    ![Screenshot 9](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_9.png)
4. Now, access the *Data* folder within the *Unity-iPhone* project from the **Navigator** panel. In the **Utilities** panel, locate the "**Target Membership**" section. Ensure you check the box next to *UnityFramework* to establish the proper target membership.
    ![Screenshot 10](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_10.png)

1. Next, open **Info.plist** and remove the **Application Scene Manifest** entry. This will temporarily break the app but we’ll resolve it later in the **AppDelegate**.
    ![Screenshot 11](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_11.png)
2. Add the `MediaPipeUnity` framework to your project, follow these steps:
    1. In Finder, navigate to `glamar_ios_sdk > UnityBuild > Frameworks > com.github.homuler.mediapipe > RunTime > Plugins > iOS > MediaPipeUnity`.
    2. Select the `MediaPipeUnity` framework and add it to your native app framework.
    3. Create a new folder in your project to store all the frameworks that you have included externally. You can do this by using the `Add Files` option and naming the folder `Frameworks`.
    ![Screenshot 12](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_12.png)
    4. Copy the `MediaPipeUnity` framework from `UnityBuilds > Frameworks > com.github.homuler.mediapipe > RunTime > Plugins > iOS > MediaPipeUnity` and paste it into the newly created `Frameworks` folder.
    ![Screenshot 13](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_13.png)
    6. Link the `MediaPipeUnity` framework to your project, copy the path of the `Frameworks` folder.
    ![Screenshot 14](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_14.png)
    7. Open the `Build Settings` of your native project and search for `Framework Search Paths`.
    8. Paste the copied path into the corresponding field.
    ![Screenshot 15](https://cdn.pixelbin.io/v2/glamar-fynd-835885/YG-lVE/original/documents/glamar_ios_15.png)
    9. This will link the `MediaPipeUnity` framework to your project. If you have added any other frameworks externally, make sure to keep them in the `Frameworks` folder that you created, as its location has been linked in your build settings. Otherwise, you may encounter linker errors.

> :bulb: **Note:** 
>
> Ensure that a physical iOS device is connected to your system while you try to build the project.