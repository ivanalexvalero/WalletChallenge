# WalletChallenge

[![Apple](https://img.shields.io/badge/iOS-999999?style=for-the-badge&logo=apple&logoColor=white&labelColor=101010)]()
[![Xcode](https://img.shields.io/badge/Xcode-1575F9?style=for-the-badge&logo=xcode&logoColor=white&labelColor=101010)]()
[![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white&labelColor=101010)]()

-
### Mobile iOS Challenge
El challenge consta de crear una billetera virtual con multiples funciones.


El desafío es crear ésta aplicación contemplando las siguientes pantallas:

- Login
- Pantalla principal: Saldo, listado de tarjetas asociadas, botones de acceso a las otras pantallas.
- Agregar una nueva tarjeta.
- Pago con QR. Generar un QR con el nombre y apellido del usuario utilizando la siguiente api [https://rapidapi.com/neutrinoapi/api/qr-code/](https://rapidapi.com/neutrinoapi/api/qr-code/) y presentar el resultado en pantalla.
- Generar un pago, seleccionando la tarjeta deseada suponiendo que la compra será a traves del NFC del celular.

#### Requerimientos:
La app deberá hacer las siguientes acciones:

-  Se deberá almacenar el nombre y apellido del usuario de forma de que se pueda corroborar que la nueva tarjeta
asociada pertenezca al usuario.
- Las tarjetas asociadas podrán ser Visa, Mastercard, American Express, etc. Detectar la marca tarjeta ingresada a partir del primer numero (3 amex, 4 visa, 5 mastercad).
- Se deberá almacenar la información de las mismas encriptada dentro de la base de datos interna de la aplicación. 
- La implementación de NFC no es requerida.


#### Tarjetas de prueba
##### Mastercard 

- Número: 5031 7557 3453 0604
- Código de seguridad: 123
- Fecha de vencimiento 11/25

##### Visa 

- Número: 4509 9535 6623 3704
- Código de seguridad: 123
- Fecha de vencimiento 11/25

##### American Express

- Número: 3711 803032 57522
- Código de seguridad: 1234
- Fecha de vencimiento 11/25



#### Se evaluará:
1. La utilización de algun framework. 
2. La arquitectura de la aplicación.
3. Correcta implementación.