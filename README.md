# Cine Nova — Compra de boletos (Java Swing)

Proyecto escolar de demostración, basado en el storyboard de seis pantallas y el diagrama de arquitectura proporcionados. No realiza pagos reales ni almacena tarjetas de crédito.

## Requisitos
- JDK 21 o superior.
- NetBeans con soporte para Maven, o Maven instalado.
- No requiere MySQL, bases de datos, frameworks ni dependencias externas.

## Ejecutarlo en NetBeans
1. **Archivo → Abrir proyecto** y selecciona la carpeta `CineNovaSwing` que contiene el `pom.xml`.
2. Espera a que NetBeans reconozca el proyecto Maven.
3. Ejecuta la clase `mx.cinenova.App` mediante **Run File** o establece esa clase como main.
4. También puedes usar `mvn compile exec:java` desde la terminal de esta carpeta.

## Recorrido del storyboard
1. Selecciona una de las tres películas de la cartelera.
2. Elige un horario; aparece el mapa con la distribución de la sala.
3. Selecciona asientos disponibles; se actualiza el resumen, **incluyendo la sala**.
4. Pulsa `Realizar pago`; usa exclusivamente una tarjeta ficticia de 16 dígitos (el campo trae precargado `4242 4242 4242 4242`).
5. Revisa banco de prueba, últimos cuatro dígitos y tipo simulado; confirma el pago simulado.
6. Aparecen boletos electrónicos con película, fecha, horario, **sala**, asiento y precio.
7. El botón `Mis boletos` lista los boletos de la ventana cliente actual.

## Arquitectura basada en el diagrama
- `vista.CarteleraView`: GUI Swing y eventos de usuario.
- `controlador.CompraBoletoControlador`: coordina la interacción de la vista con presentación.
- `presentacion.IConsultaModelo` + `IOperacionesModelo`: contratos de la capa de presentación.
- `presentacion.FachadaPresentacionCartelera` y `ControlPresentacionCartelera`: mediadores hacia el modelo.
- `modelo.IConsultasModelo` + `IOperacionesModelo`: contratos del modelo.
- `modelo.FachadaModeloCompra` y `ControlModeloCompra`: reglas de la compra.
- `modelo.Sala`, `Funcion`, `Pelicula`, `Asiento`, `Compra`, `Boleto`: entidades.
- `modelo.Observer` y `SujetoObservado`: aviso de cambios de asientos.
- `ensamblador.Ensamblador`: instancia y conecta capas; comparte un modelo entre varias ventanas.

## Probar dos clientes
Haz clic en `Abrir otro cliente` y selecciona la misma película y horario en las dos ventanas. Compra A3 en una ventana: la otra se actualiza automáticamente y A3 pasa a ocupado. El modelo comprueba la disponibilidad otra vez al confirmar para evitar ventas duplicadas.

## Alcance y decisiones
- Este proyecto utiliza una sola ventana por cliente que cambia progresivamente, al estilo del storyboard original.
- La ocupación es **por función**; una misma sala puede mostrar diferentes reservas según el horario.
- Capacidad de cada sala de ejemplo: 4 filas x 6 columnas = 24 asientos.
- Precio fijo ficticio: $85 MXN. Cartelera y fecha ficticias del 24/10/2026.
- Los datos permanecen **en memoria** y se pierden al cerrar el programa.
- El pago es estrictamente simulado: **no se comunica con bancos ni procesa tarjetas reales**.
- La validación bancaria es ficticia y se muestra un "Banco de prueba"; no debe usarse con tarjetas reales.
- Los asientos se reservan al confirmar (no hay bloqueos temporales); si otro cliente compra el mismo asiento antes, la operación se rechaza.
