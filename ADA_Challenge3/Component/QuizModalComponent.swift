//
//  QuizModalComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 14/05/25.
//

import SwiftUI
import OpenAISwift

struct QuizModalComponent: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    
    @State private var answers: [String] = ["", "", ""]
    
    private let steps: [(title: String, question: String, icon: String)] = [
        ("Leadership Style", "Do you like to lead, work together, or support others in a group?", "person.fill"),
        ("Planning Approach", "Do you plan everything first or figure things out as you go?", "calendar.badge.clock"),
        ("Work Habits", "Do you finish tasks early or work better close to the deadline?", "hourglass")
    ]
    
    var body: some View {
        NavigationStack {
            QuestionStepView(index: 0, steps: steps, dismiss: dismiss, screenWidth: screenWidth, screenHeight: screenHeight, colorScheme: colorScheme, answers: $answers)
        }
    }
}

struct QuestionStepView: View {
    let index: Int
    let steps: [(title: String, question: String, icon: String)]
    var dismiss: DismissAction
    var screenWidth : CGFloat
    var screenHeight : CGFloat
    let colorScheme: ColorScheme
    
    @Binding var answers: [String]
    @State private var navigateToResult = false
    @State private var resultFromGPT: String? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight/40) {
            Spacer().frame(height: screenHeight/24)
            Image(systemName: steps[index].icon)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth/4, height: screenWidth/4)
                .foregroundColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                .frame(maxWidth: .infinity)
            Text("Step \(index + 1) of \(steps.count)")
                .font(.headline)
                .foregroundColor(Color(.secondaryLabel))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 12)
            Text(steps[index].question)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(.label))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            TextField("Enter your answer", text: $answers[index])
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .keyboardType(.default)
                .autocapitalization(.sentences)
                .disableAutocorrection(true)
            Spacer()
            if index < steps.count - 1 {
                NavigationLink(destination: QuestionStepView(index: index + 1, steps: steps, dismiss: dismiss, screenWidth: screenWidth, screenHeight: screenHeight, colorScheme: colorScheme, answers: $answers)) {
                    Text("Next")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            answers[index].isEmpty
                            ? Color(.systemGray3).opacity(0.5)
                            : (colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(answers[index].isEmpty)
            } else {
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    sendToGPT(answers: self.answers, resultFromGPT: self.$resultFromGPT, navigateToResult: self.$navigateToResult, isLoading: self.$isLoading)
                }) {
                    Text("Done")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            answers[index].isEmpty
                            ? Color(.systemGray3).opacity(0.5)
                            : (colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(answers[index].isEmpty)
            }
            
            Spacer().frame(height: screenHeight/30)
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(false)
        .navigationTitle(steps[index].title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
            }
        }
        .navigationDestination(isPresented: $navigateToResult) {
            ResultView(resultText: resultFromGPT ?? "No response.", dismissRoot: dismiss)
        }
        .overlay(
            Group {
                if isLoading {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(.secondaryLabel)))
                        .scaleEffect(1)
                }
            }
        )
    }
    
    private func sendToGPT(answers: [String], resultFromGPT: Binding<String?>, navigateToResult: Binding<Bool>, isLoading: Binding<Bool>) -> Void {
        isLoading.wrappedValue = true
        let combinedAnswers = answers.enumerated().map { index, answer in
            "\(steps[index].question): \(answer)"
        }.joined(separator: "\n")
        let prompt = """
        You are a professional personality evaluation assistant.
        
        Your task is to evaluate a person's working compatibility with Bella.
        Bella's MBTI personality type is ISTP-T (Virtuoso Turbulent). Below are Bella’s key personality traits:
        
        General Characteristics of ISTP (Virtuoso):
        - Independent and individualistic: prefers to work independently, feels more comfortable exploring and learning through direct experience rather than theoretical concepts.
        - Present-focused: does not stick rigidly to long-term plans and prefers flexibility to make spontaneous decisions.
        - Practical skills: highly skilled in technical, mechanical, or analytical fields; enjoys understanding how things work by experimenting directly.
        - Problem-solver: approaches challenges with logical, realistic, and pragmatic thinking.
        
        Additional Characteristics of ISTP-T (Turbulent Variant):
        - More sensitive and prone to self-doubt: often questions personal abilities, especially after making mistakes.
        - Perfectionistic and self-critical: tends to review and doubt past decisions, frequently feeling the need to prove oneself to others.
        - Seeks social acceptance: pays close attention to how others perceive them and worries about being accepted in new social settings.
        - Easily distracted and quick to change interests: often seeks new activities or hobbies as a response to anxiety or boredom.
        
        Based on the following responses from the user, analyze whether this person would be compatible as Bella’s work partner or teammate. 
        Provide a detailed explanation of whether they would be a good match, citing specific behaviors or tendencies that support your evaluation.
        
        IMPORTANT:
        - Do not provide random, vague, or unclear responses.
        - If the user answers are incomplete, irrelevant, or nonsense, respond politely and say you cannot provide a valid evaluation.
        
        User's responses:
        \(combinedAnswers)
        """
        OpenAIViewModel.shared.sendMessage(prompt: prompt) { result in
            DispatchQueue.main.async {
                isLoading.wrappedValue = false
                switch result {
                case .success(let response):
                    resultFromGPT.wrappedValue = response
                    navigateToResult.wrappedValue = true
                case .failure(let error):
                    resultFromGPT.wrappedValue = "Error: \(error.localizedDescription)"
                    navigateToResult.wrappedValue = true
                }
            }
        }
    }
}

struct ResultView: View {
    var resultText: String
    var dismissRoot: DismissAction
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("🧒 Personality Match Report")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                    Text("Here’s what I, Bella’s personality assistant, think about your compatibility 👇")
                        .font(.headline)
                        .foregroundColor(Color(.secondaryLabel))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text(resultText.cleanedGPTText())
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismissRoot()
                }
            }
        }
    }
}

extension String {
    func cleanedGPTText() -> String {
        return self
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: "_", with: "")
            .replacingOccurrences(of: "`", with: "")
            .replacingOccurrences(of: "```", with: "")
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "> ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    QuizModalComponent()
        .preferredColorScheme(.light)
}

#Preview {
    QuizModalComponent()
        .preferredColorScheme(.dark)
}

//#Preview {
//    ResultView(resultText: "Test")
//        .preferredColorScheme(.light)
//}
//
//#Preview {
//    ResultView(resultText: "Test")
//        .preferredColorScheme(.dark)
//}
