# ✨ Login con Animación (Rive + Flutter)

## 🧩 Descripción breve de las funcionalidades  
Esta aplicación muestra una **pantalla de inicio de sesión animada**, donde un personaje reacciona de forma dinámica según las acciones del usuario:  
- 👀 Baja las manos al escribir la contraseña.  
- 🤔 Reacciona mientras se escribe el correo.  
- ✅ Muestra una animación de éxito si las credenciales son correctas.  
- ❌ Muestra una animación de fallo si las credenciales son incorrectas.  

El proyecto tiene como objetivo demostrar la integración entre **Rive** y **Flutter** para crear interfaces interactivas con animaciones fluidas.

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
