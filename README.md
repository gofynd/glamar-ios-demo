# iOS SDK

## iOS SDK Introduction


With GlamAR iOS SDK, you can apply different SKUs such as lipstick, blush, eyeliner and eyeshadow.

Note :-
- You can only apply SKUs that you’ve already configured in the Admin Panel.
- With the GlamAR SDK, you can take snapshots of the preview, change the makeup opacity and even capture a video recording.
- Because the GlamAR SDK can apply makeup in real-time, you can use it in applications such as displaying your shop’s cataolgue.

### Note:

* Before running or building the app or project you need to enter the API key, you can access one from the admin panel dashboard. The API key has to be passed when you are initializing the GlamARCommunication class.

```swift
    GAR.InitGlamAR(API_KEY: "GlamAR Activation Key", callback: self)
```


## Integrating Unity as a Library into an iOS Project

There are two ways through which you can integrate Unity as a library into any iOS project i.e. in an existing project and in a new project. Let’s understand each way separately:

### Download the GlamAR iOS SDK

Download the [GlamAR SDK Bundle for iOS](https://cdn.pixelbin.io/v2/glamar-fynd-835885/OYXZ4F/original/glamar_ios_sdk.zip) from the attached link. Once downloaded, extract the archive into your project’s root directory.

### **Requirements**

Before proceeding with the integration, ensure your development environment meets the following prerequisites:

* Xcode 9.4 or later version.

### Integrating into a New Project

#### **Creating the iOS Project**

When starting from scratch, you simply have to follow the next steps to clone an empty application with GlamAR SDK pre-integrated in it:
Step 1:  Clone the sample application project from the git repository by running the following command:

```
git clone https://gitlab.com/fynd/regrowth/aml/glamar/samples/glamar-ios-sample
```

Step 2: Open the IosSdkGlamAr*.xcodeproj* file with Xcode.

**Important Notes:**

* When creating the XCode project, ensure you select "**Storyboard**" as the **Interface** option and "**UIKit App Delegate**" as the project **Life Cycle**. These settings are essential for the initial Unity integration. However, rest assured that we will later convert this to a SwiftUI app.
* As this project will utilise SwiftUI, don't overlook the crucial step of setting the minimum iOS deployment target to 13.0. This ensures compatibility and a seamless experience for users across different devices.

Once your project is all set up as per the above instructions, continue to the next section Integrating into an Existing Project to start the integration process.

### Integrating into an Existing Project

This comprehensive documentation outlines the process of seamlessly integrating Unity as a Library into a standard iOS application. For a deeper understanding of Unity as a Library, you may refer to Unity’s official resources.

**Note:** If you have no project setup, visit the **Creating the iOS Project** section to learn how to set up the iOS Xcode project with GlamAR SDK.

#### **Steps to Integrate GlamAR SDK with iOS**

To establish a seamless connection between the exported Unity project and our SwiftUI app, follow these steps:

1. Open the *SwiftyUnitySdk.xcworkspace*, which currently comprises the *IosSdkGlamAr* project only.
2. In **Finder**, locate the *glamar_ios_sdk* folder and drag the *Unity-iPhone.xcodeproj* file into the **Navigator** panel **** of Xcode.

![Screenshot 1](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_1.png)
**(i)** At this point, your root workspace folder should contain the below-mentioned two project folders:

* YourProject: Represents the main iOS app.
* glamar_ios_sdk: Created by exporting the Unity game as an iOS project and Swift files.

1. Now, both *IosSdkGlamAr**.xcodeproj* and *Unity-iPhone.xcodeproj* are part of the same workspace.
    1. If your *Unity-iPhone.xcodeproj* appears in red after dragging, ensure that you set the **Location** to "**Relative to Workspace**" in the **Utilities** panel of the project.
    ![Screenshot 2](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_2.png)
2. Next, from the **Standard Editor **panel navigate to the *IosSdkGlamAr* project and select the *IosSdkGlamAr* target. Under the General tab, scroll down to the "**Frameworks, Libraries, and Embedded Content**" section. Click on the + button to add a new framework.
    ![Screenshot 3](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_3.png)
3. Include all the frameworks you have utilised in your project.
4. Select *UnityFramework.framework* from the list and add it to the project
    ![Screenshot 4](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_4.png)

1. Add the native side files of the SDK to your workspace, follow these steps:
    1. Navigate to the *`glamar_ios_sdk > NativeFiles`* folder.
    2. Select all three files in the *`NativeFiles`* folder.
    3. Drag and drop the selected files into the *IosSdkGlamAr* folder in the navigator panel, as shown in the image below.
    ![Screenshot 5](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_5.png)
2. After adding the SDK files to your workspace, follow these steps to link the `IosSdkGlamAr-Bridging-Header` header file to your project:
    1. Locate the `IosSdkGlamAr-Bridging-Header` header file in your workspace.
    ![Screenshot 6](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_6.png)
    2. Right-click on the header file and select `Show in Finder`.
    3. Copy the path of the header file.
    ![Screenshot 7](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_7.png)
    4. Open the `Build Settings` of your Xcode project.
    5. Search for `Objective C Bridging Header` and paste the copied path in the corresponding field.
    6. ![Screenshot 8](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_8.png)
    7. This will link the `IosSdkGlamAr-Bridging-Header` header file to your project, allowing you to communicate between Objective-C code and Swift files.
3. Change the **Target Membership** of the header file named *NativeCallProxy.h* from **Project** to **Public**. The file can be found at *Unity-iPhone > Libraries > Plugins > iOS > NativeCallProxy.h* within the **Navigator Panel** on the left-hand side*.* Change the membership from the **Utilities Panel** on the right-hand side.
    ![Screenshot 9](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_9.png)
4. Now, access the *Data* folder within the *Unity-iPhone* project from the **Navigator** panel. In the **Utilities** panel, locate the "**Target Membership**" section. Ensure you check the box next to *UnityFramework* to establish the proper target membership.

    ![Screenshot 10](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_10.png)

1. Next, open **Info.plist** and remove the **Application Scene Manifest** entry. This will temporarily break the app but we’ll resolve it later in the **AppDelegate**.

    ![Screenshot 11](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_11.png)
2. Add the `MediaPipeUnity` framework to your project, follow these steps:
    1. In Finder, navigate to `glamar_ios_sdk > UnityBuild > Frameworks > com.github.homuler.mediapipe > RunTime > Plugins > iOS > MediaPipeUnity`.
    2. Select the `MediaPipeUnity` framework and add it to your native app framework.
    3. Create a new folder in your project to store all the frameworks that you have included externally. You can do this by using the `Add Files` option and naming the folder `Frameworks`.
    ![Screenshot 12](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_12.png)
    4. Copy the `MediaPipeUnity` framework from `UnityBuilds > Frameworks > com.github.homuler.mediapipe > RunTime > Plugins > iOS > MediaPipeUnity` and paste it into the newly created `Frameworks` folder.
    ![Screenshot 13](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_13.png)
    6. Link the `MediaPipeUnity` framework to your project, copy the path of the `Frameworks` folder.
    ![Screenshot 14](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_14.png)
    7. Open the `Build Settings` of your native project and search for `Framework Search Paths`.
    8. Paste the copied path into the corresponding field.
    ![Screenshot 15](https://cdn.pixelbin.io/v2/glamar-fynd-835885/flpU0e/original/documents/glamar_ios_15.png)
    9. This will link the `MediaPipeUnity` framework to your project. If you have added any other frameworks externally, make sure to keep them in the `Frameworks` folder that you created, as its location has been linked in your build settings. Otherwise, you may encounter linker errors.

**Note:** Ensure that a physical iOS device is connected to your system while you try to build the project.

## GlamAR SDK Calls

1. In the `contentView.swift` file, we need to add a final step to create the user interface and set up the button click methods. To do this, we will create a function that will be called on each button click.
    First, we need to create a private constant `GAR` to access the shared instance of `GlamArCommunication`. This will allow us to interact with the GlamAR SDK.

```
private let GAR = GlamArCommunication.shared
```

1. Next, we will create a function `initilizeGlamSdk()` that will be called on each button click. This function will show the GlamAR view and initialize the GlamAR SDK with the API key and set `self` as the callback.

```
func initilizeGlamSdk() {
    // Show GlamAR view
GAR.show()
    
    // Initialize GlamAR with the API_KEY and set self as the callback
GAR.InitGlamAR(API_KEY: Constants.API_KEY, callback: self)
}
```

This function can now be called on each button click to initialize and show the GlamAR view. Make sure to replace `Constants.API_KEY` with your own API key.

1. We also need to create a function `sendSku(sku: Sku)` that will be called when a button is tapped or when makeup is applied. This function will fetch a particular SKU ID using the provided `sku.id`.

```
// Function called when a button is tapped or to apply makeup
func sendSku(sku: Sku) {
    // Fetch particular SKU ID using the provided sku.id
GAR.fetchParticularSKUId(skuId: "\(sku.id)")
}
```

This function can now be called to fetch a particular SKU ID using the provided `sku.id`. Make sure to pass in a valid `Sku` object when calling this function.


### GlamAR SDK Methods

|Method	|Parameter	|Details	|
|---	|---	|---	|
|glamARCommunication.fetchParticularSKUId(String);	|1. SKU ID as a string	|Verifies the SKU ID sent by the user.	|
|glamARCommunication.launchModuleByName(String category, String currentColorVal)	|1. Category name as a string 2. Color hex value as a string 	|Launches the module according to the category sent and color value applied.	|
|glamARCommunication.setColorIntensity(Int currentIntensityVal)	|1. Opaqueness percentage as an integer. Minimum value: 1 (completely transparent). Maximum value: 100 (completely opaque)	|Set the opaqueness of the color value by passing the percentage of opaqueness desired.	|
|glamARCommunication.setStyleId(String styleId)	|1. Style ID as a string	|Set the styling for the lipstick module (0 for matte effect, 1 for glitter effect, 2 for glossy effect).	|
|glamARCommunication.applyMakeupConfig(String makeupJsonString)	|1. Makeup JSON object as a string 	|Applies the makeup according to the JSON object sent.	|


## API References

1. Get all SKU items: Use the following endpoint to fetch all SKUs from the admin panel that you have created:


Make sure to include the required parameters in your API requests to successfully retrieve the desired data.

```
GET https://api.glamar.io/frieza/api/v1/core/sdk/sku/${id}
```

**Parameters**:

* `Authorization` (string): Required. Your API key.
* `Content-type` (string): Required. `application/json`.
* `Source` (string): Required. `android`.

1. Get SKU item: Use the following endpoint to fetch a specific SKU item by its ID:

```
GET https://api.glamar.io/frieza/api/v1/core/sdk/sku-list
```

**Parameters**:

* `Authorization` (string): Required. Your API key.
* `Content-type` (string): Required. `application/json`.
* `Source` (string): Required. `android`.

## Events

In order to call the interface functions mentioned in the next sub-section, you need to inherit the *IGlamARCommunication* interface in your own class and implement all the method in the interface to handle all the calls.

### IGlamARCommunication (Interface):

|Callback	|Description	|
|---	|---	|
|onSuccessResponseModuleLaunch(String var1)	|Called when the verification of the passed `skuId` value is successful. Returns the result in `Object` format (a JSON string response).	|
|onFaceTrackingLost(boolean var1)	|Called when the tracking of the face is lost. Returns the result in Boolean format 	|
|onErrorMessage(MessageType var1, String var2)	|Called when an error occurs when calling any method of the `GlamARCommunication` class. Gives the MessageType as enum and returns a string message.	|
|onSuccessMessage(MessageType var1, String var2)	|Called when a method of the `GlamARCommunication` class is successfully executed. Gives the MessageType as enum and returns a string message.	|
|closeGlamAr(message: String)	|Called when close button is pressed from the SDK end. It will unload the GlamAR Player.	|
|onDownloadComplete()	|Called when the required components are download is completed.	|

The response from the Unity side will be contained in the `message` variable. The expected values for error and success messages are listed in the subsequent sub-section. 

**Expected Error Messages:**

|Message Type	|Description	|
|---	|---	|
|CONFIG_FAILED	|When the makeup config is passed with invalid JSON format	|
|GLAM_FAILED	|When wrong category is sent while launching the module.	|
|CAMERA_FAILED	|When camera permission is not set	|
|COLOR_INTENSITY_FAILED	|When a wrong value is passed while setting the color intensity.	|
|*SKU_FAILED*	|When the SKU ID is failed to verified.	|
|COLOR_FAILED	|When the wrong hex color code is sent.	|
|STYLE_FAILED	|When the style ID is set wrong.	|
|IMAGE_PICKER_ENDED	|When the Image Picker couldn't find the permission or permission isn't granted or some interuption has occured.	|
|VALIDATION_FAILED	|When API key is not set or when activity class name is not provided or when camera class reference is not instantiated.	|

**Expected Success Messages:**

|Message Type	|Description	|
|---	|---	|
|*SKU_APPLIED*	|When SKU ID is verified successfully.	|
|*CONFIG_APPLIED*	|When makeup config. JSON is verified successfully.	|
|*GLAM_LOADED*	|When the module is launched successfully.	|
|*GLAM_LOADING*	|When specified module is loading.	|
|*CAMERA_OPENED*	|When the camera permission is accessed successfully.	|
|*COLOR_INTENSITY_APPLIED*	|When the color intensity value is provided and applied successfully.	|
|*COLOR_APPLIED*	|When the color value is applied successfully.	|
|*STYLE_APPLIED*	|When the style ID is set properly.	|
|*SDK_DOWNLOAD_COMPLETE*	|When the SDK compnents is downloaded.	|
|*IMAGE_PICKER_OPENED*	|When the Image Picker from SDK is opened.	|

These callbacks provide useful information for error handling and tracking the success of calls to the `GlamARCommunication` class.


---

## Sample iOS SDK app

See the [Glamar SDK quickstart sample](https://github.com/gofynd/glamar-ios-demo) on Gitlab for an example of this SDK in use.

---
