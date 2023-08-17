

import SwiftUI
import Combine
import UnityFramework

struct ContentView: View , IGlamARCommunication{
    
       @ObservedObject var apiDataFetcher = ApiDataFetcher()
       @State private var SliderIntensityValue: Double = 50
       @State private var selectedOption: Int = 0
       @State private var catergory : String = ""
       @State  private var color : String = ""
       @State private var ColorIntensity : QuantumValue? = nil
       @State private var setupDone = false

       private let GAR = GlamARCommunicationHandler.shared
 
    
    //View
    var body: some View {
        // Add vertical space at the top to push content down (410 points minimum)
        Spacer(minLength: 410)
        
        // ZStack to overlay views on top of each other
        ZStack {
            // White rectangle filling the entire screen
            Rectangle()
                .fill(Color.white)
                .opacity(1.0)

            // Main VStack to arrange content vertically
            VStack {
                // ScrollView to display buttons horizontally
                ScrollView(.horizontal) {
                    // HStack to arrange buttons side by side with spacing
                    HStack(spacing: 20) {
                        // Loop through the SkuData to create buttons
                        ForEach(apiDataFetcher.SkuData.indices, id: \.self) { indices in
                            // Each button representing an item from SkuData
                            Button(action: {
                                // Handle button tap here
                                print("Button tapped: \(apiDataFetcher.colorValue[indices])")
                                // Call functions to handle button tap and send data to Unity
                                sendSku(sku: apiDataFetcher.SkuData[indices])
                                SetValues(
                                    category: apiDataFetcher.SkuData[indices].category,
                                    color: apiDataFetcher.colorValue[indices],
                                    colorIntensity: apiDataFetcher.colorIntensity[indices]
                                )
                            }) {
                                // Button content
                                Text(apiDataFetcher.SkuData[indices].name)
                                    .padding()
                                    .frame(width: 140)
                                    .foregroundColor(.white)
                                    .background(Color.init(hex:apiDataFetcher.colorValue[indices]))
                                    .cornerRadius(8)
                                    .font(.system(size: 13))
                            }
                            .frame(height: 40)
                        }
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    .frame(maxWidth: .infinity)
                }
                .onAppear {
                    
                    if !setupDone{
                        
                        
                        initilizeGlamSdk()
                        // Fetch API data when the view appears
                        apiDataFetcher.fetchData { result in
                            switch result {
                            case .success(let skuData):
                                print("Data fetched successfully: \(skuData)")
                                apiDataFetcher.GetDictionaryData(sku: skuData)
                            case .failure(let error):
                                print("Error fetching data: \(error)")
                            }
                        }
                        
                        apiDataFetcher.fetchParticularData(id: 493) { result in
                            switch result {
                            case .success(let jsonString):
                                print("Data fetched successfully: \(jsonString)")
                            case .failure(let error):
                                print("Error fetching data: \(error)")
                            }
                        }
                        
                        setupDone = true
                    }
                }

                // HStack to arrange Picker and its options horizontally
                HStack {
                    // Picker to select style options (Matt, Glitter, Gloss)
                    Picker("Options", selection: $selectedOption) {
                        Text("Matt").tag(0)
                        Text("Glitter").tag(1)
                        Text("Gloss").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onReceive(Just(selectedOption)) { newValue in
                        // Call function to handle Picker option selection
                        setStyle(tag: newValue)
                    }
                }
                .padding([.leading,.trailing,.bottom], 10)

                // Slider to adjust intensity
                Slider(value: $SliderIntensityValue, in: 0...100, onEditingChanged: SliderValueChanged)
                    .padding([.leading, .trailing], 10)
                    .padding(.bottom,5)

                // Text label for the Slider
                Text("Intensity")
                    .font(.system(size: 12))
                    .padding( .bottom, 5)

                // Button to apply makeup
                Button(action: {
                    // Handle button tap here
                    GAR.show()
                    // Print the makeup configuration JSON for debugging
                    print("jsonString show \(apiDataFetcher.applyMakeUpConfigJsonString)")
                    GAR.show()
                    // Apply makeup configuration to Unity using the JSON data
                    GAR.applyMakeupConfig(makeupJsonString: apiDataFetcher.applyMakeUpConfigJsonString)
                }) {
                    // Button content
                    Text("Apply MakeUp")
                        .padding()
                        .frame(width: 140)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .font(.system(size: 13))
                }
                .frame(height: 40)
            }
            .padding(.bottom, 2) // Add spacing at the bottom of the VStack
        }
    }


        // ... Other functions and protocols implementation ...

        // ContentView_Previews is a nested struct to provide previews for ContentView
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
 
    //Icommunication messages
    // Function to handle error messages
    func onErrorMessage(_ type: MessageType, message: String) {
        print("Error message   message type  \(type)   message \(message)")
    }

    // Function to handle success messages
    func onSuccessMessage(_ type: MessageType, message: String) {
        print("onSuccessMessage   message type  \(type)   message \(message)")
    }

    // Function to handle successful response from module launch
    func onSuccessResponseModuleLaunch(_ message: String) {
        // Launch the GlamAR module with the specified category and color values
        GAR.launchModuleByName(category: self.catergory, currentColorValue: self.color)
        // Set the color intensity using the provided value, or "50" as the default if not available
        GAR.setColorIntensity(currentIntensityVal: self.ColorIntensity?.stringValue() ?? "50")
    }

    // Function to handle face tracking status (whether tracking is lost or not)
    func onFaceTrackingLost(_ trackingLost: Bool) {
        print("onFaceTrackingLost   boolean  \(trackingLost)")
    }
    //Initilize Glam Sdk
    func initilizeGlamSdk(){
        // Show GlamAR view
        GAR.show()
        
        // Initialize GlamAR with the API_KEY and set self as the callback
        GAR.InitGlamAR(API_KEY: Constants.API_KEY, callback: self)
    }

    // Function called when the Slider value changes
    func SliderValueChanged(editing: Bool) {
        // Check if the Slider value has finished being edited by the user
        if !editing {
            // Print the Slider intensity value for debugging purposes
            print("Glam communication set color intensity Slider intensity value is \(SliderIntensityValue)")
            
            // Set the color intensity in GlamAR using the Slider value
            GAR.setColorIntensity(currentIntensityVal: "\(SliderIntensityValue)")
        }
    }

    // Function to set category, color, and color intensity values
    func SetValues(category: String, color: String, colorIntensity: QuantumValue?) {
        // Set the received values to the corresponding state variables
        self.catergory = category
        self.color = color
        self.ColorIntensity = colorIntensity
    }
    
    // Function called when a button is tapped
    func sendSku(sku: Sku) {
      // Fetch particular SKU ID using the provided sku.id
        GAR.fetchParticularSKUId(skuId: "\(sku.id)")
    }

    // Function called when a segment in the Picker is clicked
    func setStyle(tag: Int) {
        // Set the selected style ID in GlamAR using the tag value
        GAR.setStyleId(styleId: "\(tag)")
    }

    
}

// Extension to create Color from hex value
extension Color {
    init(hex: String) {
        // Convert hex string to RGB values
        var cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if cleanHex.count == 6 {
            cleanHex = "FF" + cleanHex
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}



