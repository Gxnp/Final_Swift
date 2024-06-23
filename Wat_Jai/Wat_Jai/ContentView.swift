
import SwiftUI
import CoreML

struct PredictedValue {
    var predClass: Int64
    var predConf: String
}


extension Double {
    func percentRoundedFormat(toPlaces places: Int) -> String {
        let divisor = pow(10.0, Double(places))
        let toPercentage = self * 100
        let rounded = (toPercentage * divisor).rounded() / divisor
        return String(format: "%.\(places)f", rounded)
    }
}


func testModel(age: String, trestbps: String, chol: String, fbs: String, thalach: String) -> PredictedValue? {
    
    do {
        let config = MLModelConfiguration()
        
        let model = try watjai(configuration: config)
        
        let prediction = try model.prediction(age: Int64(age) ?? 0, trestbps: Int64(trestbps) ?? 0, chol: Int64(chol) ?? 0, fbs: Int64(fbs) ?? 0, thalach: Int64(thalach) ?? 0)
        
        return prediction.targetProbability.map{key, value in
            return PredictedValue(predClass: key, predConf: value.percentRoundedFormat(toPlaces: 2))
        }.sorted(by: { $0.predConf > $1.predConf })[0]
        
        
        
    } catch {
        
    }
    
    
    return nil
}

struct ContentView: View {
    @FocusState private var nameIsFocused: Bool
    
    @State var age = ""
    @State var trestbps = ""
    @State var chol = ""
    @State var fbs = ""
    @State var thalach = ""
    
    @State var predictedValue: PredictedValue?
    @State var showResult = false
    
    func predict() {
        predictedValue = testModel(age: age, trestbps: trestbps, chol: chol, fbs: fbs, thalach: thalach)
        
    }
    
    func allFieldsFilled() -> Bool {
        if Int64(age) != nil && Int64(trestbps) != nil && Int64(chol) != nil && Int64(fbs) != nil
            && Int64(thalach) != nil{
            return true
        }
        return false
    }
    
    var body: some View {
        
        
        
        //        VStack{
        //            Text("WatJai")
        //                .padding()
        //
        //
        //            Text("Age :")
        //            TextField("Your age...", text: $age)
        //                .keyboardType(.numberPad)
        //
        //            Text("Resting Blood Pressure:")
        //            TextField("A number in range [94-200] mmHg", text: $trestbps)
        //                .keyboardType(.numberPad)
        //
        //            Text("Serum Cholesterol:")
        //            TextField("Input", text: $chol)
        //                .keyboardType(.numberPad)
        //
        //            Text("Max Heart Rate:")
        //            TextField("Input", text: $thalach)
        //                .keyboardType(.numberPad)
        //
        //            Text("Fasting Blood Sugar:")
        //            TextField("Input", text: $fbs)
        //                .keyboardType(.numberPad)
        //
        //            Button(action: predict) {
        //                Text("Predict")
        //            }.disabled(!allFieldsFilled())
        //                .background(allFieldsFilled() ? .white : .gray)
        //
        //            if let predictedValue = predictedValue {
        //                Text("\(predictedValue.predClass == 0 ? "No" : "Yes")")
        //                Text("Confidence: \(predictedValue.predConf)")
        //            }
        //
        //
        //        }
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .nevBlue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
            ScrollView{
                NavigationStack{
                    ZStack{
                        
                        VStack {
                            
                            Image("watjai1")
                                .resizable()
                                .frame(width:250 , height:70)
                            
                            
                            Spacer()
                            
                            VStack {
                                Text(" Fill in the blanks")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Text("Age :")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    TextField("Your age...", text: $age)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(.roundedBorder)
                                        .focused($nameIsFocused)
                                        .toolbar {
                                            ToolbarItemGroup(placement: .keyboard) {
                                                Button("Done") {
                                                    nameIsFocused = false
                                                    
                                                }
                                            }
                                        }
                                }
                            }
                            
                            
                            
                            VStack {
                                HStack {
                                    Text("Resting Blood Pressure:")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    TextField("A number in range [94-200] mmHg", text: $trestbps)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numberPad)
                                        .focused($nameIsFocused)
                                    
                                    
                                }
                            }
                            
                            
                            VStack {
                                HStack {
                                    Text("Serum Cholesterol:")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    TextField("Input", text: $chol)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numberPad)
                                        .focused($nameIsFocused)
                                }
                            }
                            
                            
                            
                            
                            
                            VStack {
                                HStack {
                                    Text("Max Heart Rate:")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    TextField("Input", text: $thalach)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numberPad)
                                        .focused($nameIsFocused)
                                }
                            }
                            
                            
                            
                            VStack {
                                HStack {
                                    Text("Fasting Blood Sugar:")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    TextField("Input", text: $fbs)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numberPad)
                                        .focused($nameIsFocused)
                                }
                            }
                            
                            
                            
                            
                            ;Spacer()
                            
                            
                            HStack{
                                
                                Button("Predict"){
                                    predict()
                                    showResult.toggle()
                                }
                            }.disabled(!allFieldsFilled())
                                .fontWeight(.heavy)
                                .font(.title)
                                .padding(10)
                                .foregroundStyle(Color.nevBlue)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                            
                        }.padding()
                            .navigationDestination(isPresented: $showResult) {
                                if predictedValue != nil {
                                    if predictedValue!.predClass == 0 {
                                        con()
                                    } else {
                                        Regret()}
                                }
                            }
                        
                        
                        if let predictedValue = predictedValue {
                            Text("\(predictedValue.predClass == 0 ? "No" : "Yes")")
                            Text("Confidence: \(predictedValue.predConf)")
                        }

                    }
                }
            }
        }
    }
}
    


#Preview {
    ContentView()
}
