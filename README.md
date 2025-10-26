# ✨ Login with Bear Animtion (Rive + Flutter)

## 🧩 Brief Description of the Functionality  
This application features an animated login screen, where a character dynamically reacts to the user’s actions:  
- 👀 The character lowers its hands when typing the password  
- 🤔 The character reacts while the user types the email   
- ✅ The character plays a success animation when the credentials are valid   
- ❌ The character plays a sad animation when the credentials are invalid Muestra una animación de fallo si las credenciales son incorrectas.  

The goal of this project is to demonstrate the integration of Rive and Flutter for building interactive interfaces with smooth animations.

---

## 🎨 What are Rive and State Machine?
**Rive** is a real-time design and animation tool for vector graphics. It integrates easily with Flutter and allows cotrolling animations with code. 

A **State Machine** in Rive defines the **transitions between different animations**.  

In this project, the State Machine manages the character's states (such as looking around, covering its eyes, showing success, or showing failure) depending on the user's actions.

---

## 🛠️ Technologies Used
- **Flutter** 🐦  
- **Dart** 💻  
- **Rive** 🎞️  
- **Material Design** 🎨  

---

## 🧱 Project Structure
```bash
lib/
│
├── main.dart                # Punto de entrada principal
├── screens/
│   └── login_screen.dart    # Pantalla principal del login con animaciones
└── assets/
    └── animated_login_character.riv        # Archivo de animación del personaje (Rive)
pubsec.yaml                  # Dependencies and Flutter configuration
```

---

## 🎥 Demo

![Demo de la aplicación](assets/demo.gif)
---

## 📚 Academic information
- **Subject:** Grafication
- **Professor:** Rodrigo Fidel Gaxiola Sosa

---

## 🙌 Credits
- Rive animation used in this project: https://rive.app/marketplace/3645-7621-remix-of-login-machine/

---
