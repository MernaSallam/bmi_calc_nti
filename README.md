# BMI Calculator App 🧮

A simple and elegant Body Mass Index (BMI) calculator built with **Flutter**.  
This app allows users to input their weight, height, age, and gender, and calculates their BMI with an interpretation and recommendations.

---

## ✨ Features

- 👤 User input: Name, gender, age, weight, and height.
- 📆 Date picker to calculate age.
- 📈 Real-time BMI calculation using API.
- 📊 Displays risk level, summary, and health recommendations.
- 🎨 Clean and modern UI design.

---

## 📁 Project Structure
lib/
├── main.dart

└── features/

    └── BMI_Calc/
    
        ├── data/           # Models & API constants
        
        ├── presentation/
        
        │   ├── UI_Screens/ # Screens like Input & Result
        
        │   ├── components/ # Reusable widgets (buttons, fields...)
        
        │   └── controller/ # BLoC logic


---

## 📦 Packages Used

flutter_bloc

dio

flutter_svg

---

## 👩‍💻 Developed and Designed By
 
 ### Merna Sallam

---
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
