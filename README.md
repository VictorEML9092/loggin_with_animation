# ✨ Login with Bear Animtion (Rive + Flutter)

## 🧩 Brief Description of the Functionality  
This application features an animated login screen, where a character dynamically reacts to the user’s actions:  
- 👀 The character lowers its hands when typing the password  
- 🤔 The character reacts while the user types the email   
- ✅ The character plays a success animation when the credentials are valid   
- ❌ The character plays a sad animation when the credentials are invalid Muestra una animación de fallo si las credenciales son incorrectas.  

The goal of this project is to demonstrate the integration of Rive and Flutter for building interactive interfaces with smooth animations.

---

## 🎨 ¿Qué es Rive y qué es State Machine?
**Rive** es una herramienta que permite diseñar y animar gráficos vectoriales en tiempo real. Se integra fácilmente con Flutter, lo que permite controlar animaciones mediante código.  

Una **State Machine** (máquina de estados) en Rive define las **transiciones entre diferentes animaciones**.  
En este proyecto, la State Machine gestiona los estados del personaje (pensando, escribiendo, feliz o triste) dependiendo de las acciones del usuario.

---

## 🛠️ Tecnologías utilizadas
- **Flutter** 🐦  
- **Dart** 💻  
- **Rive** 🎞️  
- **Material Design** 🎨  

---

## 🧱 Estructura básica del proyecto
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

---

## 📚 Academic information
- **Subject:** Grafication
- **Professor:** Rodrigo Fidel Gaxiola Sosa

---

## 🙌 Credits
- Rive animation used in this project: https://rive.app/marketplace/3645-7621-remix-of-login-machine/

---
