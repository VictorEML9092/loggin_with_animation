import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// 3.1 Importar librería para Timer
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true; // Estado inicial

  // 5.1) Variable para controlar si el botón Login está cargando
  // Sirve para mostrar un spinner y evitar que el usuario presione varias veces
  bool _isLoading = false;

  // Cerebro de la lógica de las animaciones
  StateMachineController?
  controller; // El ? sirve para verificar que la variable no sea nulo
  // SMI: State Machine Input
  SMIBool? isChecking; // Activa la movilidad de los ojos
  SMIBool? isHandsUp; // Se tapa los ojos
  SMITrigger? trigSuccess; // Se emociona
  SMITrigger? trigFail; // Se pone triste

  // 2.1 Variable para el seguimiento de los ojos
  SMINumber? numLook; // Sigue el movimiento del cursor

  // 1.1) FocusNode (Nodo donde esta el foco)
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  // 3.2) Timer para detener la mirada al dejar de teclear
  Timer? _typingDebounce;

  // 4.1) Controllers: puede hacer algo con la información, la monitorea
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // 4.2) Errores para mostrar en la UI
  String? emailError;
  String? passError;

  // 4.3) validadores
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String pass) {
    // Mínimo 8, una mayúscula, una minúscula, un dígito y un especial
    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
    );
    return regex.hasMatch(pass);
  }

  // 4.4) Acción al botón
  void _onLogin() async {
    // 5.2) Evitar que se presione el botón mientras está cargando
    // Si ya se está procesando, no hace nada
    if (_isLoading) return;

    // 5.3) Activar estado de carga y actualizar UI
    setState(() {
      _isLoading = true;
    });

    // trim (recortar) sirve para eliminar espacios en un campo de texto
    final email = emailController.text.trim();
    final pass = passController.text;

    // Recalcular errores dinámicamente (solo el primero aplicable)
    String? eError;
    if (email.isNotEmpty && !isValidEmail(email)) {
      eError = 'Email inválido';
    }

    String? pError;
    if (pass.isNotEmpty && pass.length < 8) {
      pError = 'Debe tener al menos 8 caracteres';
    } else if (!RegExp(r'[A-Z]').hasMatch(pass)) {
      pError = 'Debe tener una mayúscula';
    } else if (!RegExp(r'[a-z]').hasMatch(pass)) {
      pError = 'Debe tener una minúscula';
    } else if (!RegExp(r'\d').hasMatch(pass)) {
      pError = 'Debe incluir un número';
    } else if (!RegExp(r'[^A-Za-z0-9]').hasMatch(pass)) {
      pError = 'Debe incluir un carácter especial';
    }
    // 4.5 Para avisar que hubo un cambio
    setState(() {
      emailError = eError;
      passError = pError;
    });

    // 4.6 Cerrar el teclado y bajar las manos
    FocusScope.of(context).unfocus();
    _typingDebounce?.cancel();
    isChecking?.change(false);
    isHandsUp?.change(false);
    numLook?.value = 50.0; // Mirada neutral

    // 5.4 Esperar hasta el siguiente frame completo antes de disparar el trigger
    // Esto garantiza que Rive procese la animación de bajar las manos antes del trigger
    await Future<void>.delayed(
      const Duration(milliseconds: 600),
    ); // Le puse esa cantidad porque es el tiempo necesario para la animación de bajar las manos

    // 5.5 Simular tiempo de carga (~1 segundo)
    await Future.delayed(const Duration(seconds: 1));

    // 4.7 Activar triggers
    if (eError == null && pError == null) {
      trigSuccess?.fire();
    } else {
      trigFail?.fire();
    }

    // 5.6 Desactivar el estado de carga al finalizar
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 1.2) Listeners (Oyentes, escuchadores)
  @override
  void initState() {
    super.initState();
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        // Manos abajo en email
        isHandsUp?.change(false); // Manos abajo en email
        // 2.2 Mirada neutral al enfocar el email
        numLook?.value = 50.0;
        isHandsUp?.change(false);
      }
    });
    passFocus.addListener(() {
      isHandsUp?.change(passFocus.hasFocus); // Manos arriba en password
    });
  }

  @override
  Widget build(BuildContext context) {
    // Para obtener el tamaño de la pantalla del disp.
    // MediaQuery = Consulta de las propiedades de la pantalla
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      // Evita nudge o cámaras frontales para móviles
      body: SafeArea(
        child: Padding(
          // Eje X/horizontal/derecha izquierda
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  // Para vincular las animaciones con el estado de la maquina
                  stateMachines: ["Login Machine"],
                  // Al iniciarse
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    // Verificar que inició bien
                    if (controller == null) return;
                    artboard.addController(
                      controller!,
                    ); // El ! es para decirle que no es nulo
                    isChecking = controller!.findSMI('isChecking');
                    isHandsUp = controller!.findSMI('isHandsUp');
                    trigSuccess = controller!.findSMI('trigSuccess');
                    trigFail = controller!.findSMI('trigFail');
                    // 2.3 Enlazar variable con la animación
                    numLook = controller!.findSMI('numLook');
                  },
                ),
              ),
              // Espacio entre el oso y el texto Emial
              const SizedBox(height: 10),
              // Campo de texto del Email
              TextField(
                focusNode: emailFocus, // Asiganas el focusNode al TextField
                // 4.8) Enlazar el controller al TextField
                controller: emailController,
                onChanged: (value) {
                  // 2.4) Implementando numLook
                  // "Estoy escribiendo"
                  isChecking!.change(true);

                  // 5.8) Validación dinámica de email mientras se escribe
                  String? eError;
                  if (value.isNotEmpty && !isValidEmail(value)) {
                    eError = 'Email inválido';
                  }

                  // Se borra el error si el campo esta vacío
                  if (value.isEmpty) {
                    eError = null;
                  }

                  setState(() {
                    emailError = eError;
                  });

                  // Ajuste de límites de 0 a 100
                  // 80 es una medida de calibración
                  final look = (value.length / 100.0 * 100.0).clamp(0.0, 80.0);
                  numLook?.value = look;

                  // 3.3 Debounce: si vuelve a teclear, reinicia el contador
                  _typingDebounce
                      ?.cancel(); // Cancela cualquier Timer existente
                  _typingDebounce = Timer(
                    const Duration(milliseconds: 3000),
                    () {
                      if (!mounted) {
                        return;
                      }
                      // Mirada neutra
                      isChecking?.change(false);
                    },
                  );
                  // Si es nulo no intenta cargar la animación
                  if (isChecking == null) return;
                  // Activa el seguimiento de los ojos
                  isChecking!.change(true);
                },
                // Para que aparezca el @ en móviles UI/UX
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  // 4.9) Mostrar el texto del error
                  errorText: emailError,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    // Esquinas redondeadas
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // Campo de texto de la contraseña
              TextField(
                focusNode: passFocus, // Asiganas el focusNode al TextField
                // 4.8) Enlazar el controller al TextField
                controller: passController,
                onChanged: (value) {
                  // 5.9) Validación dinámica de password mientras se escribe
                  String? pError;
                  if (value.isNotEmpty && value.length < 8) {
                    pError = 'Debe tener al menos 8 caracteres';
                  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    pError = 'Debe tener una mayúscula';
                  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                    pError = 'Debe tener una minúscula';
                  } else if (!RegExp(r'\d').hasMatch(value)) {
                    pError = 'Debe incluir un número';
                  } else if (!RegExp(r'[^A-Za-z0-9]').hasMatch(value)) {
                    pError = 'Debe incluir un carácter especial';
                  }

                  // Se borra el error si el campo esta vacío
                  if (value.isEmpty) {
                    pError = null;
                  }

                  setState(() {
                    passError = pError;
                  });
                  // Si es nulo no intenta cargar la animación
                  if (isHandsUp == null) return;
                  // Activa el seguimiento de los ojos
                  isHandsUp!.change(true);
                },
                // Para ocultar el texto
                obscureText: _isObscure,
                // Para que aparezca el @ en móviles UI/UX
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  // 4.9) Mostrar el texto del error
                  errorText: passError,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  border: OutlineInputBorder(
                    // Esquinas redondeadas
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Texto "Olvidé contraseña"
              SizedBox(
                width: size.width,
                child: const Text(
                  "Forgot your password?",
                  // Alinear a la derecha
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              // Botón de login
              const SizedBox(height: 10),
              // Botón estilo Android
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                // 5.7) Deshabilitar el botón mientras carga
                onPressed: _isLoading ? null : _onLogin,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.blue)
                    : const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          // En negritas
                          fontWeight: FontWeight.bold,
                          // Subrayado
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1.4) Liberación de recursos / limpieza de focos
  @override
  void dispose() {
    // 4.11) Limpieza de los controllers
    emailController.dispose();
    passController.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    _typingDebounce?.cancel(); // Cancela el Timer si está activo
    super.dispose();
  }
}
