# Información

¡PayRoll API es el reemplazo a Excel para la liquidación de la nómina!

Puedes usar esta API para calcular la nómina de un empleado y su costo total para la empresa, los métodos GET, POST, UPDATE y DELETE están disponibles para todos los recursos.

La autenticación es requerida para esta API y se hace mediante tokens.

## URL base de la API

Todos los endpoints de la API en la documentación de referencia a continuación son relativos a la siguiente URL base:

```api/v1```

### Uso en Postman

Para empezar rápidamente, usa el siguiente enlace para acceder al espacio de trabajo público de Postman:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/e24f8d8af967f673f50f?action=collection%2Fimport)

---

## Auth

El objeto **Auth** es usado para acceder a todas las peticiones de la API.

- Propiedades:

| Llave    | Tipo   | Descripción        |
| -------- | ------ | ------------------ |
| email    | String | Correo electrónico |
| password | String | Contraseña         |

### GET /auth/login

Devuelve el token de autorización que debe ir en los headers de cada petición.

- Body parameters (form-data):

| Llave    | Tipo   | Nota      |
| -------- | ------ | --------- |
| email    | String | Requerido |
| password | String | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": {
        "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiYTNkNzJjMzItMThmYy00MGU3LWFmZGItYWM5ZjBjNTQ2N2Y4IiwiZXhwIjoxNjY2OTAyMzA3fQ.gI_gIl_5kHOm8ptslq8zi0RLI3DDh0T_uXXjkl1q0sM"
    }
}
```

## User

El objeto **User** es usado para representar un usuario de una empresa.

- Propiedades:

| Llave      | Tipo       | Descripción                                                                     |
| ---------- | ---------- | ------------------------------------------------------------------------------- |
| id         | UUID       | Id del usuario                                                                  |
| full_name  | String     | Nombre completo                                                                 |
| email      | String     | Correo electrónico                                                              |
| password   | String     | Contraseña                                                                      |
| company_id | UUID       | Id de la empresa                                                                |
| role       | Enumarated | El rol del usuario, los valores pueden ser **admin**, **accountant** y **user** |

- El parámetro *company_id* debe hacer referencia a un objeto *Company* ya existente en la base de datos.
- El parámetro `role` puede tomar los valores *admin*, *accountant*, y *user*.

> Las funcionalidades dependen del alcance del rol que se tenga; los usuarios tienen un alcance de usuario, los contadores un alcance sobre su propia empresa y los administradores sobre los datos globales.

| Permiso                                         | User (usuario) | Accountant (contador) | Admin (administrador) |
| ----------------------------------------------- | -------------- | --------------------- | --------------------- |
| Obtener lista de todos los usuarios registrados | Limitado       | Limitado              | Sí                    |
| Consultar un usuario específico                 | Limitado       | Limitado              | Sí                    |
| Registrar un usuario nuevo                      | No             | Limitado              | Sí                    |
| Actualizar los datos de un usuario              | No             | Limitado              | Sí                    |
| Eliminar un usuario                             | No             | Limitado              | Sí                    |

### GET /users

Devuelve una lista de los objetos **User**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": [
        {
            "nombre": "Proident sit consequat",
            "id": "a3d72c32-18fc-40e7-afdb-ac9f0c5467f8",
            "correo": "nisi@est.id",
            "empresa": "Incididunt Qui S.A.S.",
            "rol": "admin"
        },
        {
            "nombre": "Labore Lorem irure",
            "id": "c49cc694-2700-4861-b272-e8c7a7f920c5",
            "correo": "irure@esse.deserunt",
            "empresa": "Exercitation Culpa S.A.S.",
            "rol": "user"
        }
    ]
}
```

### GET /users/{id}

Devuelve un objeto **User** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo   | Descripción    | Nota      |
| ----- | ------ | -------------- | --------- |
| id    | String | Id del usuario | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": {
        "id": "a3d72c32-18fc-40e7-afdb-ac9f0c5467f8",
        "nombre": "Non magna deserunt",
        "correo": "velit@fugiat.ad",
        "empresa": "Et Commodo S.A.S.",
        "rol": "admin"
    }
}
```

### POST /users

Crea un objeto **User** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| user  | Object | Requerido |

- User parameters:

| Llave     | Tipo       | Descripción                                                                                             | Nota      |
| --------- | ---------- | ------------------------------------------------------------------------------------------------------- | --------- |
| full_name | String     | Nombre completo, debe ser de al menos 5 caracteres, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ` | Requerido |
| email     | String     | Correo electrónico, debe tener el formato `string@string.s`                                             | Requerido |
| password  | String     | Contraseña, debe contener al menos 6 caracteres                                                         | Requerido |
| role      | Enumerated | Rol del usuario,  los valores pueden ser **admin**, **accountant** y **user** (valor por defecto)       | Opcional  |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": {
        "id": "f624fa84-9c63-4585-98d3-4bfaac7e852c",
        "nombre": "Enim minim",
        "correo": "in@ullamco.culpa",
        "empresa": "Dolore Laborum S.C.",
        "rol": "admin"
    }
}
```

### PUT /users

Actualiza un objeto **User** con el **id** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| user  | Object | Requerido |

- User parameters:

| Llave     | Tipo       | Descripción                                                                                             | Nota       |
| --------- | ---------- | ------------------------------------------------------------------------------------------------------- | ---------- |
| id        | UUID       | Id del usuario                                                                                          | Requerido  |
| full_name | String     | Nombre completo, debe ser de al menos 5 caracteres, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ` | Requerido  |
| email     | String     | Correo electrónico, debe tener el formato `string@string.s`                                             | Requerido  |
| password  | String     | Contraseña, debe contener al menos 6 caracteres                                                         | Requerido, |
| role      | Enumerated | Rol del usuario,  los valores pueden ser **admin**, **accountant** y **user** (valor por defecto)       | Opcional   |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": {
        "id": "f624fa84-9c63-4585-98d3-4bfaac7e852c",
        "nombre": "Aliquip magna",
        "correo": "duis@ad.nisi",
        "empresa": "Minim Proident S.C.",
        "rol": "admin"
    }
}
```

### DELETE /users/{id}

Elimina un objeto **User** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción    | Nota      |
| ----- | ---- | -------------- | --------- |
| id    | UUID | Identificación | Requerido |

- Una respuesta exitosa devolverá el estatus `204 No Content`.

## Company

El objeto **Company** es usado para representar una empresa bajo los requisitos de la DIAN en Colombia para la nómina.

- Propiedades:

| Llave        | Tipo   | Descripción                         |
| ------------ | ------ | ----------------------------------- |
| id           | UUID   | Id de la empresa                    |
| nit          | String | Número de identificación tributaria |
| legal_name   | String | Razón social                        |
| display_name | String | Nombre comercial                    |

> Las funcionalidades dependen del alcance del rol que se tenga; los usuarios tienen un alcance de usuario, los contadores un alcance sobre su propia empresa y los administradores sobre los datos globales.

| Permiso                                         | User (usuario) | Accountant (contador) | Admin (administrador) |
| ----------------------------------------------- | -------------- | --------------------- | --------------------- |
| Obtener lista de todas las empresas registradas | No             | No                    | Sí                    |
| Consultar una empresa específica                | Limitado       | Limitado              | Sí                    |
| Registrar una empresa nueva                     | No             | No                    | Sí                    |
| Actualizar los datos de una empresa             | No             | No                    | Sí                    |
| Eliminar una empresa                            | No             | No                    | Sí                    |

### GET /companies

Devuelve una lista de los objetos **Company**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": [
        {
            "id": "9c45a373-9692-4ffd-ad42-3a758e5023fc",
            "nit": "9772103295",
            "nombre_legal": "Bergnaum Inc S.C.",
            "nombre_comercial": "Bergnaumapp",
            "empleados": 3
        },
        {
            "id": "9c2acd38-d6dd-434c-8bf0-1b9f1a5e853b",
            "nit": "9602482828",
            "nombre_legal": "Christiansen-Schoen S. en C.",
            "empleados": 3
        }
    ]
}
```

### GET /companies/{id}

Devuelve un objeto **Company** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción      | Nota      |
| ----- | ---- | ---------------- | --------- |
| id    | UUID | Id de la empresa | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": {
        "id": "6abe93fc-1c34-48e8-a9f6-9af0fc8429bc",
        "nit": "9011261473",
        "nombre_legal": "Lorem aute S.A.S.",
        "nombre_comercial": "Excepteur deserunt",
        "empleados": 4
    }
}
```

### POST /companies

Crea un objeto **Company** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave   | Tipo   | Nota      |
| ------- | ------ | --------- |
| company | Object | Requerido |

- Company parameters:

| Llave        | Tipo   | Descripción                                                                       | Nota      |
| ------------ | ------ | --------------------------------------------------------------------------------- | --------- |
| nit          | String | Número de identificación tributaria, debe ser un número único de mínimo 8 dígitos | Requerido |
| legal_name   | String | Razón social, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ`                 | Requerido |
| display_name | String | Nombre comercial, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ`             | Opcional  |

- Ejemplo de respuesta exitosa:

```json
{
    "data": {
        "id": "aca084c0-5d73-496f-bb9e-4aeaa26e6b3c",
        "nit": "687639574",
        "nombre_legal": "Aliquip non",
        "nombre_comercial": "Ut ullamco",
        "empleados": 0
    }
}
```

### PUT /companies

Actualiza un objeto **Company** con el **nit** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave   | Tipo   | Nota      |
| ------- | ------ | --------- |
| company | Object | Requerido |

- Company parameters:

| Llave        | Tipo   | Descripción                                                                       | Nota      |
| ------------ | ------ | --------------------------------------------------------------------------------- | --------- |
| id           | UUID   | Id de la empresa                                                                  | Requerido |
| nit          | String | Número de identificación tributaria, debe ser un número único de mínimo 8 dígitos | Requerido |
| legal_name   | String | social, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ`                       | Requerido |
| display_name | String | Nombre comercial, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ`             | Opcional  |

- Ejemplo de respuesta exitosa:

```json
{
    "data": {
        "id": "aca084c0-5d73-496f-bb9e-4aeaa26e6b3c",
        "nit": "687639574",
        "nombre_legal": "Aliquip non",
        "nombre_comercial": "Ut ullamco",
        "empleados": 0
    }
}
```

### DELETE /companies/{id}

Elimina un objeto **Company** con el **nit** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción      | Nota      |
| ----- | ---- | ---------------- | --------- |
| id    | UUID | Id de la empresa | Requerido |

- Una respuesta exitosa devolverá el estatus `204 No Content`.

## Employee

El objeto **Employee** es usado para representar un empleado de una empresa.

- Propiedades:

| Llave            | Tipo       | Descripción                                                                                                                                    |
| ---------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| id               | UUID       | Id del empleado                                                                                                                                |
| card_id          | String     | Número de cédula                                                                                                                               |
| company_id       | UUID       | Id de la empresa a la que pertenece                                                                                                            |
| full_name        | String     | Nombre completo                                                                                                                                |
| risk_class       | Enumerated | La clase de riesgo del empleado, los valores pueden ser: **i**, **ii**, **iii**, **iv**, **v** y **vi**                                        |
| job_title        | String     | Título o cargo                                                                                                                                 |
| base_salary      | Decimal    | Salario base                                                                                                                                   |
| start_date       | Date       | Fecha de contratación                                                                                                                          |
| termination_date | Date       | Fecha de terminación del contrato                                                                                                              |
| contract_type    | Enumerated | El tipo de contrato del empleado, los valores pueden ser **work or labor**, **fixed-term**, **indefinite**, **apprenticeship** y **temporary** |

> Las funcionalidades dependen del alcance del rol que se tenga; los usuarios tienen un alcance de usuario, los contadores un alcance sobre su propia empresa y los administradores sobre los datos globales.

| Permiso                                          | User (usuario) | Accountant (contador) | Admin (administrador) |
| ------------------------------------------------ | -------------- | --------------------- | --------------------- |
| Obtener lista de todos los empleados registrados | Limitado       | Limitado              | Sí                    |
| Consultar un empleado específico                 | Limitado       | Limitado              | Sí                    |
| Registrar un empleado nuevo                      | No             | Limitado              | Sí                    |
| Actualizar los datos de una empresa              | No             | Limitado              | Sí                    |
| Eliminar un usuario                              | No             | Limitado              | Sí                    |

### GET /employees

Devuelve una lista de los objetos **Employee**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": [
        {
            "empleado": {
                "nombre": "Veniam exercitation exercitation",
                "id": "48596e4b-70a4-4597-8112-364bb47ebf73",
                "empresa": "Lorem dolor",
                "puesto": "Excepteur nulla ex",
                "contrato": "contrato de aprendizaje",
                "cedula": "11111185369",
                "arl": "v",
                "salario": "750000.0",
                "contratacion": "2022-07-18",
                "terminacion": "2023-01-17"
            }
        },
        {
            "empleado": {
                "nombre": "Sunt reprehenderit fugiat",
                "id": "c0ca303e-d7d1-4d09-88fd-de98e0326fe2",
                "empresa": "Mollit id",
                "puesto": "Irure deserunt",
                "contrato": "término fijo",
                "cedula": "1569372642",
                "arl": "iii",
                "salario": "1300000.0",
                "contratacion": "2022-07-18",
                "terminacion": "2023-11-17"
            }
        }
    ]
}
```

### GET /employees/{card_id}

Devuelve un objeto **Employee** con el **card_id** (número de cédula) proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave   | Tipo   | Descripción         | Nota      |
| ------- | ------ | ------------------- | --------- |
| card_id | String | Cédula del empleado | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "datos": {
        "nombre": "Do nisi do",
        "id": "48596e4b-70a4-4597-8112-364bb47ebf73",
        "empresa": "Aliqua aute",
        "puesto": "Magna amet",
        "contrato": "contrato de aprendizaje",
        "cedula": "11111185369",
        "arl": "v",
        "salario": "750000.0",
        "contratacion": "2022-07-18",
        "terminacion": "2023-01-17"
    }
}
```

### POST /employees

Crea un objeto **Employee** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave    | Tipo   | Nota      |
| -------- | ------ | --------- |
| employee | Object | Requerido |

- Employee parameters:

| Llave            | Tipo       | Descripción                                                                                                                                    | Nota      |
| ---------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| card_id          | String     | Número de cédula, debe ser número único de al menos 8 dígitos                                                                                  | Requerido |
| company_nit      | String     | NIT de la empresa a la que pertenece el empleado                                                                                               | Requerido |
| full_name        | String     | Nombre completo, debe ser de al menos 5 caracteres, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ`                                        | Requerido |
| risk_class       | Enumerated | La clase de riesgo del empleado, los valores pueden ser: **i**, **ii**, **iii**, **iv**, **v** y **vi**                                        | Requerido |
| job_title        | String     | Título o cargo                                                                                                                                 | Requerido |
| base_salary      | Decimal    | Salario base                                                                                                                                   | Requerido |
| start_date       | Date       | Fecha de contratación                                                                                                                          | Requerido |
| termination_date | Date       | Fecha de terminación del contrato                                                                                                              | Requerido |
| contract_type    | Enumerated | El tipo de contrato del empleado, los valores pueden ser **work or labor**, **fixed-term**, **indefinite**, **apprenticeship** y **temporary** | Requerido |

### PUT /employees

Actualiza un objeto **Employee** con el **id** (número de cédula) y los valores proporcionados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave    | Tipo   | Nota      |
| -------- | ------ | --------- |
| employee | Object | Requerido |

- Employee parameters:

| Llave            | Tipo       | Descripción                                                                                                                                    | Nota      |
| ---------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| card_id          | String     | Número de cédula, debe ser número único de al menos 8 dígitos                                                                                  | Requerido |
| company_nit      | String     | NIT de la empresa a la que pertenece el empleado\|                                                                                             | Requerido |
| full_name        | String     | Nombre completo, debe ser de al menos 5 caracteres, los caracteres aceptados son `a-zA-Z áéíúóúÁÉÍÓÚñÑ`                                        | Requerido |
| risk_class       | Enumerated | La clase de riesgo del empleado, los valores pueden ser: **i**, **ii**, **iii**, **iv**, **v** y **vi**                                        | Requerido |
| job_title        | String     | Título o cargo                                                                                                                                 | Requerido |
| base_salary      | Decimal    | Salario base                                                                                                                                   | Requerido |
| start_date       | Date       | Fecha de contratación                                                                                                                          | Requerido |
| termination_date | Date       | Fecha de terminación del contrato                                                                                                              | Requerido |
| contract_type    | Enumerated | El tipo de contrato del empleado, los valores pueden ser **work or labor**, **fixed-term**, **indefinite**, **apprenticeship** y **temporary** | Requerido |

### DELETE /employees/{id}

Elimina un objeto **Employee** con el **id** (número de cédula) proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave   | Tipo   | Descripción         | Nota      |
| ------- | ------ | ------------------- | --------- |
| card_id | String | Cédula del empleado | Requerido |

- Una respuesta exitosa devolverá el estatus `204 No Content`.

## Periods

El objeto **Period** es usado para representar el periodo de una nómina.

- Propiedades:

| Llave      | Tipo       | Descripción                                                                    |
| ---------- | ---------- | ------------------------------------------------------------------------------ |
| id         | UUID       | Identificación                                                                 |
| start_date | Date       | Fecha de inicio                                                                |
| end_date   | Date       | Fecha de fin                                                                   |
| state      | Enumerated | El estado del periodo, los valores pueden ser **paid**, **draft** y **failed** |
| company_id | UUID       | Id de la empresa a la que pertenece el periodo                                 |

> Las funcionalidades dependen del alcance del rol que se tenga; los usuarios tienen un alcance de usuario, los contadores un alcance sobre su propia empresa y los administradores sobre los datos globales.

| Permiso                                         | User (usuario) | Accountant (contador) | Admin (administrador) |
| ----------------------------------------------- | -------------- | --------------------- | --------------------- |
| Obtener lista de todos los periodos registrados | Limitado       | Limitado              | Sí                    |
| Consultar un periodo específico                 | Limitado       | Limitado              | Sí                    |
| Registrar un periodo nuevo                      | No             | Limitado              | Sí                    |
| Actualizar los periodos de una empresa          | No             | Limitado              | Sí                    |
| Eliminar un periodo                             | No             | Limitado              | Sí                    |

### GET /periods

Devuelve una lista de los objetos **Period**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": [
        {
            "periodo": {
                "id": "e95dce88-c457-473c-9b55-3503e2a12266",
                "empresa": "Halvorson-Lindgren S.C.",
                "fecha_inicio": "2022-10-01",
                "fecha_fin": "2022-10-31",
                "estado": "borrador"
            }
        },
        {
            "periodo": {
                "id": "627e714c-6180-40ab-8330-9b2e66e7ec24",
                "empresa": "Halvorson-Lindgren S.C.",
                "fecha_inicio": "2022-09-01",
                "fecha_fin": "2022-09-30",
                "estado": "fallido"
            }
        }
    ]
}
```

### GET /periods/{id}

Devuelve un objeto **Period** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción    | Nota      |
| ----- | ---- | -------------- | --------- |
| id    | UUID | Identificación | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": {
        "id": "e95dce88-c457-473c-9b55-3503e2a12266",
        "empresa": "Halvorson-Lindgren S.C.",
        "fecha_inicio": "2022-10-01",
        "fecha_fin": "2022-10-31",
        "estado": "borrador"
    }
}
```

### POST /periods

Crea un objeto **Period** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave  | Tipo   | Nota      |
| ------ | ------ | --------- |
| period | Object | Requerido |

- Period parameters:

| Llave       | Tipo       | Descripción                                                                                                                                                          | Nota      |
| ----------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| start_date  | Date       | Fecha de inicio, debe estar en el periodo comprendido entre dos años antes de la fecha actual y el principio del mes actual, además debe ser el primer día de un mes | Requerido |
| end_date    | Date       | Fecha de fin, debe estar en el periodo comprendido entre dos años antes de la fecha actual y el final del mes actual, además debe ser el último día de un mes        | Requerido |
| state       | Enumerated | El estado del periodo, los valores pueden ser **paid**, **draft** y **failed**                                                                                       | Requerido |
| company_nit | String     | NIT de la empresa a la que pertenece el periodo                                                                                                                      | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": {
        "id": "125970b3-dd7f-41a3-bae1-4f2b1a8f98d7",
        "empresa": "Christiansen-Schoen S. en C.",
        "fecha_inicio": "2022-10-01",
        "fecha_fin": "2022-10-31",
        "estado": "borrador"
    }
}
```

### PUT /periods

Actualiza un objeto **Period** con el **id** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave  | Tipo   | Nota      |
| ------ | ------ | --------- |
| period | Object | Requerido |

- Period parameters:

| Llave       | Tipo       | Descripción                                                                                                                                                          | Nota      |
| ----------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| id          | UUID       | Identificación del periodo                                                                                                                                           | Requerido |
| start_date  | Date       | Fecha de inicio, debe estar en el periodo comprendido entre dos años antes de la fecha actual y el principio del mes actual, además debe ser el primer día de un mes | Requerido |
| end_date    | Date       | Fecha de fin, debe estar en el periodo comprendido entre dos años antes de la fecha actual y el final del mes actual, además debe ser el último día de un mes        | Requerido |
| state       | Enumerated | El estado del periodo, los valores pueden ser **paid**, **draft** y **failed**                                                                                       | Requerido |
| company_nit | String     | NIT de la empresa a la que pertenece el periodo                                                                                                                      | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": {
        "id": "125970b3-dd7f-41a3-bae1-4f2b1a8f98d7",
        "empresa": "Christiansen-Schoen S. en C.",
        "fecha_inicio": "2022-10-01",
        "fecha_fin": "2022-10-31",
        "estado": "pagado"
    }
}
```

### DELETE /periods/{id}

Elimina un objeto **Period** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción    | Nota      |
| ----- | ---- | -------------- | --------- |
| id    | UUID | Identificación | Requerido |

- Una respuesta exitosa devolverá el estatus `204 No Content`.

## Payroll

El objeto **Payroll** es usado para representar la nómina de un empleado.

- Propiedades:

| Llave               | Tipo    | Descripción                              |
| ------------------- | ------- | ---------------------------------------- |
| id                  | UUID    | Identificación                           |
| employee_id         | UUID    | Id del empleado                          |
| period_id           | UUID    | Identificación del periodo               |
| salary_income       | Decimal | Otros ingresos salariales                |
| non_salary_income   | Decimal | Otros ingresos no salariales             |
| deduction           | Decimal | Deducciones                              |
| employee_healthcare | Decimal | Costo de salud pagado por el empleado    |
| employee_pension    | Decimal | Fondo de pensión pagado por el empleado  |
| solidarity_fund     | Decimal | Fondo de solidaridad                     |
| subsistence_account | Decimal | Cuenta de subistencia                    |
| compensation_fund   | Decimal | Caja de compensación                     |
| icbf                | Decimal | ICBF                                     |
| sena                | Decimal | SENA                                     |
| severance           | Decimal | Cesantias                                |
| interest            | Decimal | Intereses sobre las cesantías            |
| premium             | Decimal | Prima de servicios                       |
| vacation            | Decimal | Vacaciones                               |
| employer_healthcare | Decimal | Costo de salud pagado por el empleador   |
| employer_pension    | Decimal | Fondo de pensión pagado por el empleador |
| arl                 | Decimal | ARL                                      |

> Las funcionalidades dependen del alcance del rol que se tenga; los usuarios tienen un alcance de usuario, los contadores un alcance sobre su propia empresa y los administradores sobre los datos globales.

| Permiso                                        | User (usuario) | Accountant (contador) | Admin (administrador) |
| ---------------------------------------------- | -------------- | --------------------- | --------------------- |
| Obtener lista de todas las nóminas registradas | Limitado       | Limitado              | Sí                    |
| Consultar una nómina específica                | Limitado       | Limitado              | Sí                    |
| Registrar una nómina nueva                     | No             | Limitado              | Sí                    |
| Actualizar los datos de una nómina             | No             | Limitado              | Sí                    |
| Eliminar una nómina                            | No             | No                    | Sí                    |

### GET /payrolls

Devuelve una lista de los objetos **Payroll**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": [
        {
            "nomina": {
                "id": "f79fcfec-d6f4-4489-9e67-2d4b53e211cc",
                "empresa": "Halvorson-Lindgren S.C.",
                "empleado": "Contessa Von Sr",
                "fecha_inicial": "2022-10-01",
                "fecha_final": "2022-10-31",
                "dias": 30,
                "salario_base": "428105263.0",
                "ingresos_salariales": "421001.0",
                "ingresos_no_salariales": "524528.0",
                "deducciones": "710281.0",
                "auxilio_transporte": "0.0",
                "salud_empleado": "17145191.64",
                "pension_empleado": "17145191.64",
                "fondo_solidaridad": "4286297.91",
                "cuenta_subsistencia": "4286297.96",
                "caja_compensacion": "17145191.64",
                "icbf": "12858893.73",
                "sena": "8572595.82",
                "cesantias": "35719149.25",
                "intereres": "4286298.0",
                "prima": "35719149.25",
                "vacaciones": "17859574.62",
                "salud_empleador": "364335322.35",
                "pension_empleador": "51435574.92",
                "arl": "2237447.51",
                "pago_empleado": "384953003.85",
                "costo_total": "978695461.09"
            }
        },
        {
            "nomina": {
                "id": "965f8f0e-10b8-459a-b380-9442fe1abd3a",
                "empresa": "Halvorson-Lindgren S.C.",
                "empleado": "Lewis Rath",
                "fecha_inicial": "2022-10-01",
                "fecha_final": "2022-10-31",
                "dias": 30,
                "salario_base": "21914903.0",
                "ingresos_salariales": "843008.0",
                "ingresos_no_salariales": "414588.0",
                "deducciones": "445668.0",
                "auxilio_transporte": "0.0",
                "salud_empleado": "893179.64",
                "pension_empleado": "893179.64",
                "fondo_solidaridad": "223294.91",
                "cuenta_subsistencia": "223294.96",
                "caja_compensacion": "893179.64",
                "icbf": "669884.73",
                "sena": "446589.82",
                "cesantias": "1860790.92",
                "intereres": "223295.0",
                "prima": "1860790.92",
                "vacaciones": "930395.46",
                "salud_empleador": "18980067.35",
                "pension_empleador": "2679538.92",
                "arl": "1554132.57",
                "pago_empleado": "20079293.85",
                "costo_total": "52856576.33"
            }
        }
    ]
}
```

### GET /payrolls/{id}

Devuelve un objeto **Payroll** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción    | Nota      |
| ----- | ---- | -------------- | --------- |
| id    | UUID | Identificación | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "nomina": {
        "id": "f79fcfec-d6f4-4489-9e67-2d4b53e211cc",
        "empresa": "Halvorson-Lindgren S.C.",
        "empleado": "Contessa Von Sr",
        "fecha_inicial": "2022-10-01",
        "fecha_final": "2022-10-31",
        "dias": 30,
        "salario_base": "428105263.0",
        "ingresos_salariales": "421001.0",
        "ingresos_no_salariales": "524528.0",
        "deducciones": "710281.0",
        "auxilio_transporte": "0.0",
        "salud_empleado": "17145191.64",
        "pension_empleado": "17145191.64",
        "fondo_solidaridad": "4286297.91",
        "cuenta_subsistencia": "4286297.96",
        "caja_compensacion": "17145191.64",
        "icbf": "12858893.73",
        "sena": "8572595.82",
        "cesantias": "35719149.25",
        "intereres": "4286298.0",
        "prima": "35719149.25",
        "vacaciones": "17859574.62",
        "salud_empleador": "364335322.35",
        "pension_empleador": "51435574.92",
        "arl": "2237447.51",
        "pago_empleado": "384953003.85",
        "costo_total": "978695461.09"
    }
}
```

### POST /payrolls

Crea un objeto **Payroll** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave   | Tipo   | Nota      |
| ------- | ------ | --------- |
| payroll | Object | Requerido |

- Payroll parameters:

| Llave       | Tipo | Descripción                                           | Nota      |
| ----------- | ---- | ----------------------------------------------------- | --------- |
| start_date  | Date | Fecha de inicio del periodo cuya nómina se va a pagar | Requerido |
| company_nit | Nit  | NIT de la empresa                                     | Requerido |

- Ejemplo de respuesta exitosa:

```json
{
    "data": [
        {
            "nomina": {
                "id": "6dd00504-56a9-4d59-b36a-85b509f03787",
                "empresa": "Adipisicing Duis S.A.S",
                "empleado": "Veniam excepteur",
                "fecha_inicial": "2022-10-01",
                "fecha_final": "2022-10-31",
                "dias": 30,
                "salario_base": "4000000.0",
                "ingresos_salariales": "0.0",
                "ingresos_no_salariales": "0.0",
                "deducciones": "0.0",
                "auxilio_transporte": "0.0",
                "salud_empleado": "160000.0",
                "pension_empleado": "160000.0",
                "fondo_solidaridad": "40000.0",
                "cuenta_subsistencia": "0.0",
                "caja_compensacion": "160000.0",
                "icbf": "0.0",
                "sena": "0.0",
                "cesantias": "333333.33",
                "intereres": "40000.0",
                "prima": "333333.33",
                "vacaciones": "166666.67",
                "salud_empleador": "0.0",
                "pension_empleador": "480000.0",
                "arl": "20880.0",
                "pago_empleado": "3640000.0",
                "costo_total": "5534213.33"
            }
        }
    ]
}
```

### PUT /payrolls

Actualiza un objeto **Payroll** con el **id** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave   | Tipo   | Nota      |
| ------- | ------ | --------- |
| payroll | Object | Requerido |

- Payroll parameters:

| Llave             | Tipo    | Descripción                              | Nota      |
| ----------------- | ------- | ---------------------------------------- | --------- |
| employee          | String  | Cédula del empleado                      | Requerido |
| period            | Date    | Fecha de inicio del periodo de la nómina | Requerido |
| salary_income     | Decimal | Otros ingresos salariales                | Opcional  |
| non_salary_income | Decimal | Otros ingresos no salariales             | Opcional  |
| deduction         | Decimal | Deducciones                              | Opcional  |

- Ejemplo de respuesta exitosa:

```json
{
    "nomina": {
        "id": "6dd00504-56a9-4d59-b36a-85b509f03787",
        "empresa": "Halvorson-Lindgren S.C.",
        "empleado": "Esse Culpa",
        "fecha_inicial": "2022-10-01",
        "fecha_final": "2022-10-31",
        "dias": 30,
        "salario_base": "4000000.0",
        "ingresos_salariales": "100.0",
        "ingresos_no_salariales": "200.0",
        "deducciones": "500000.0",
        "auxilio_transporte": "0.0",
        "salud_empleado": "160008.0",
        "pension_empleado": "160008.0",
        "fondo_solidaridad": "40002.0",
        "cuenta_subsistencia": "0.0",
        "caja_compensacion": "160008.0",
        "icbf": "0.0",
        "sena": "0.0",
        "cesantias": "333350.0",
        "intereres": "40002.0",
        "prima": "333350.0",
        "vacaciones": "166675.0",
        "salud_empleador": "0.0",
        "pension_empleador": "480024.0",
        "arl": "20881.04",
        "pago_empleado": "3140082.0",
        "costo_total": "5534390.04"
    }
}
```

### DELETE /payrolls/{id}

Elimina un objeto **Period** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo | Descripción    | Nota      |
| ----- | ---- | -------------- | --------- |
| id    | UUID | Identificación | Requerido |

- Una respuesta exitosa devolverá el estatus `204 No Content`.

## Error

La llave **Error** se usa para indicar que existe un problema con los parámetros insertados.

### Usuario

Los errores de usuario cubren los códigos en el rango **001** - **010**:

| Código | Llave     | Solución                                                |
| ------ | --------- | ------------------------------------------------------- |
| 001    | full_name | Añadir el nombre                                        |
| 002    | full_name | Ingresar un nombre de más de 5 caracteres               |
| 003    | full_name | Utilizar únicamente el alfabeto español                 |
| 004    | email     | Añadir la llave                                         |
| 005    | email     | Ingresar un correo único                                |
| 006    | email     | Ingresar un correo válido                               |
| 007    | password  | Añadir la contraseña                                    |
| 008    | password  | Ingresar una contraseña de más de 6 caracteres          |
| 009    | role      | Añadir el rol                                           |
| 010    | role      | Verificar que el rol sea *admin*, *accountant* o *user* |

### Empresa

Los errores de usuario cubren los códigos en el rango **011** - **021**:

| Código | Llave        | Solución                                            |
| ------ | ------------ | --------------------------------------------------- |
| 011    | nit          | Añadir el NIT                                       |
| 012    | nit          | Ingresar un NIT único                               |
| 013    | nit          | Ingresar un NIT de más de 8 dígitos                 |
| 014    | nit          | Utilizar únicamente números                         |
| 015    | legal_name   | Añadir la razón social                              |
| 016    | legal_name   | Ingresar una razón social única                     |
| 017    | legal_name   | Ingresar una razón social de más de 3 caracteres    |
| 018    | legal_name   | Utilizar únicamente el alfabeto español             |
| 019    | display_name | Ingresar un nombre comercial de más de 3 caracteres |
| 020    | display_name | Ingresar un nombre comercial único                  |
| 021    | display_name | Utilizar únicamente el alfabeto español             |

### Empleado

Los errores de empleado cubren los códigos en el rango **022** - **041**:

| Código | Llave                       | Solución                                                                                                               |
| ------ | --------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| 022    | card_id                     | Añadir la cédula                                                                                                       |
| 023    | card_id                     | Ingresar una cédula única                                                                                              |
| 024    | card_id                     | Ingresar una cédula de más de 8 dígitos                                                                                |
| 025    | card_id                     | Utilizar únicamente números                                                                                            |
| 026    | full_name                   | Añadir el nombre                                                                                                       |
| 027    | full_name                   | Ingresar un nombre de más de 5 caracteres                                                                              |
| 028    | full_name                   | Utilizar únicamente el alfabeto español                                                                                |
| 029    | risk_class                  | Añadir la clase de riesgo de la ARL                                                                                    |
| 030    | risk_class                  | Verificar que la clase sea *i*, *ii*, *iii*, *iv*, *v* o *vi*                                                          |
| 031    | job_title                   | Añadir el cargo o título del empleo                                                                                    |
| 032    | job_title                   | Ingresar un cargo de más de 3 caracteres                                                                               |
| 033    | job_title                   | Utilizar únicamente el alfabeto español                                                                                |
| 034    | base_salary                 | Añadir el salario base                                                                                                 |
| 035    | base_salary                 | Utilizar únicamente números                                                                                            |
| 036    | start_date                  | Añadir la fecha de contratación                                                                                        |
| 037    | start_date                  | Verificar que la fecha esté en el rango entre la fecha de hoy hace 77 años y la fecha del día posterior al actual      |
| 038    | termination_date            | Verificar que la fecha esté en el rango entre la fecha del día posterior al actual y la fecha de hoy dentro de 77 años |
| 039    | contract_type               | Añadir el tipo de contrato                                                                                             |
| 040    | contract_type               | Verificar que el tipo de contrato sea *work or labor*, *fixed-term*, *indefinite*, *apprenticeship* o *temporary*      |
| 041    | base_salary o contract_type | Revisar que el salario base se corresponda con el salario mínimo legal vigente teniendo en cuenta el tipo de contrato  |

### Periodo

Los errores de periodo cubren los códigos en el rango **042** - **050**:

| Código | Llave                 | Solución                                                                                                         |
| ------ | --------------------- | ---------------------------------------------------------------------------------------------------------------- |
| 042    | start_date            | Añadir la fecha de inicio                                                                                        |
| 043    | start_date            | Verificar que la fecha esté en el rango entre la fecha de hoy hace 2 años y la fecha del comienzo del mes actual |
| 044    | end_date              | Añadir la fecha de fin                                                                                           |
| 045    | end_date              | Verificar que la fecha esté en el rango entre la fecha de hoy hace 2 años y la fecha del final del mes actual    |
| 046    | state                 | Añadir el estado del periodo                                                                                     |
| 047    | state                 | Verificar que el estado del periodo sea *paid*, *draft* o *failed*                                               |
| 048    | start_date o end_date | Verificar que las fechas tengan el formato AAAA-MM-DD                                                            |
| 049    | start_date o end_date | Verificar que las fechas inicial y final se correspondan con el inicio y fin del mes respectivamente             |
| 050    | start_date o end_date | Verificar que el periodo no esté repetido                                                                        |

### Nómina

Los errores de nómina cubren los códigos en el rango **051** - **055**:

| Código | Llave             | Solución                                                               |
| ------ | ----------------- | ---------------------------------------------------------------------- |
| 051    | salary_income     | Utilizar únicamente números                                            |
| 052    | non_salary_income | Utilizar únicamente números                                            |
| 053    | deduction         | Utilizar únicamente números                                            |
| 054    | employee o period | Verificar que el periodo no esté repetido para el empleado en cuestión |
| 055    |                   | Verificar que no se estén ingresando parámetros adicionales            |

### Frecuentes

Es posible encontrarse con otros errrores no definidos aquí, ten en cuenta las siguientes recomendaciones:

1. Una nómina no puede ser creada si no existe un periodo asociado a una empresa con al menos un trabajador

2. Un periodo no puede ser creado sin una empresa
