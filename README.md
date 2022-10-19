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

## Company

El objeto **Company** es usado para representar una empresa bajo los requisitos de la DIAN en Colombia para la nómina.

- Propiedades:

| Llave        | Tipo   | Descripción                         |
| ------------ | ------ | ----------------------------------- |
| nit          | String | Número de identificación tributaria |
| legal_name   | String | Razón social                        |
| display_name | String | Nombre comercial                    |

Una respuesta exitosa devuelve los siguiente estructura de datos:

```json
{
    "data": "data"
}
```

### GET /companies

Devuelve una lista de los objetos **Company**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

### GET /companies/{id}

Devuelve un objeto **Company** con el **nit** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo   | Descripción                         | Nota      |
| ----- | ------ | ----------------------------------- | --------- |
| nit   | String | Número de identificación tributaria | Requerido |

### POST /companies

Crea un objeto **Company** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave        | Tipo   | Descripción                         | Nota      |
| ------------ | ------ | ----------------------------------- | --------- |
| nit          | String | Número de identificación tributaria | Requerido |
| legal_name   | String | Razón social                        | Requerido |
| display_name | String | Nombre comercial                    | Opcional  |

### PUT /companies

Actualiza un objeto **Company** con el **nit** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave        | Tipo   | Descripción                         | Nota      |
| ------------ | ------ | ----------------------------------- | --------- |
| nit          | String | Número de identificación tributaria | Requerido |
| legal_name   | String | Razón social                        | Opcional  |
| display_name | String | Nombre comercial                    | Opcional  |

### DELETE /companies/{id}

Elimina un objeto **Company** con el **nit** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo   | Descripción                         | Nota      |
| ----- | ------ | ----------------------------------- | --------- |
| nit   | String | Número de identificación tributaria | Requerido |

## Employee

El objeto **Employee** es usado para representar un empleado de una empresa.

- Propiedades:

| Llave             | Tipo       | Descripción                                                                                         |
| ----------------- | ---------- | --------------------------------------------------------------------------------------------------- |
| id                | String     | Número de cédula                                                                                    |
| company           | String     | Nombre comercial de la empresa                                                                      |
| first_name        | String     | Primer nombre                                                                                       |
| middle_name       | String     | Segundo nombre                                                                                      |
| first_surname     | String     | Primer apellido                                                                                     |
| second_surname    | String     | Segundo apellido                                                                                    |
| full_name         | String     | Nombre completo                                                                                     |
| username          | String     | Nombre de usuario                                                                                   |
| email             | String     | Correo de usuario                                                                                   |
| start_date        | Date       | Fecha de inicio del contrato                                                                        |
| termination_date  | Date       | Fecha de terminación del contrato                                                                   |
| employment        | String     | Contrato                                                                                            |
| employment_status | Enumerated | La situación laboral del empleado, los valores pueden ser: **activo**, **pendiente** o **inactivo** |

Una respuesta exitosa devuelve los siguiente estructura de datos:

```json
{
    "data": "data"
}
```

### GET /employees

Devuelve una lista de los objetos **Employee**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

### GET /employees/{id}

Devuelve un objeto **Employee** con el **id** (número de cédula) proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo   | Descripción      | Nota      |
| ----- | ------ | ---------------- | --------- |
| id    | String | Número de cédula | Requerido |

### POST /employees

Crea un objeto **Employee** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave             | Tipo       | Descripción                                                                                         | Nota      |
| ----------------- | ---------- | --------------------------------------------------------------------------------------------------- | --------- |
| id                | String     | Número de cédula                                                                                    | Requerido |
| company           | String     | NIT de la empresa                                                                                   | Requerido |
| first_name        | String     | Primer nombre                                                                                       | Requerido |
| middle_name       | String     | Segundo nombre                                                                                      | Opcional  |
| first_surname     | String     | Primer apellido                                                                                     | Requerido |
| second_surname    | String     | Segundo apellido                                                                                    | Opcional  |
| username          | String     | Nombre de usuario                                                                                   | Opcional  |
| email             | String     | Correo de usuario                                                                                   | Opcional  |
| start_date        | Date       | Fecha de inicio del contrato                                                                        | Requerido |
| termination_date  | Date       | Fecha de terminación del contrato                                                                   | Requerido |
| employment        | String     | Contrato                                                                                            | Requerido |
| employment_status | Enumerated | La situación laboral del empleado, los valores pueden ser: **activo**, **pendiente** o **inactivo** | Opcional  |

### PUT /employees

Actualiza un objeto **Employee** con el **id** (número de cédula) y los valores proporcionados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave             | Tipo       | Descripción                                                                                         | Nota      |
| ----------------- | ---------- | --------------------------------------------------------------------------------------------------- | --------- |
| id                | String     | Número de cédula                                                                                    | Requerido |
| company           | String     | NIT de la empresa                                                                                   | Opcional  |
| first_name        | String     | Primer nombre                                                                                       | Opcional  |
| middle_name       | String     | Segundo nombre                                                                                      | Opcional  |
| first_surname     | String     | Primer apellido                                                                                     | Opcional  |
| second_surname    | String     | Segundo apellido                                                                                    | Opcional  |
| username          | String     | Nombre de usuario                                                                                   | Opcional  |
| email             | String     | Correo de usuario                                                                                   | Opcional  |
| start_date        | Date       | Fecha de inicio del contrato                                                                        | Opcional  |
| termination_date  | Date       | Fecha de terminación del contrato                                                                   | Opcional  |
| employment        | String     | Contrato                                                                                            | Opcional  |
| employment_status | Enumerated | La situación laboral del empleado, los valores pueden ser: **activo**, **pendiente** o **inactivo** | Opcional  |

### DELETE /employees/{id}

Elimina un objeto **Employee** con el **id** (número de cédula) proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo   | Descripción      | Nota      |
| ----- | ------ | ---------------- | --------- |
| id    | String | Número de cédula | Requerido |

## Periods

El objeto **Period** es usado para representar el periodo de una nómina.

- Propiedades:

| Llave      | Tipo | Descripción     |
| ---------- | ---- | --------------- |
| id         | UUID | Identificación  |
| start_date | Date | Fecha de inicio |
| end_date   | Date | Fecha de fin    |

Una respuesta exitosa devuelve los siguiente estructura de datos:

```json
{
    "data": "data"
}
```

### GET /periods

Devuelve una lista de los objetos **Period**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

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

### POST /periods

Crea un objeto **Period** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave      | Tipo | Descripción     | Nota      |
| ---------- | ---- | --------------- | --------- |
| start_date | Date | Fecha de inicio | Requerido |
| end_date   | Date | Fecha de fin    | Requerido |

### PUT /periods

Actualiza un objeto **Period** con el **id** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave      | Tipo | Descripción     | Nota      |
| ---------- | ---- | --------------- | --------- |
| id         | UUID | Identificación  | Requerido |
| start_date | Date | Fecha de inicio | Requerido |
| end_date   | Date | Fecha de fin    | Requerido |

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

## Payroll

El objeto **Payroll** es usado para representar la nómina de un empleado.

- Propiedades:

| Llave       | Tipo        | Descripción                |
| ----------- | ----------- | -------------------------- |
| id          | UUID        | Identificación             |
| employee    | String      | Cédula del empleado        |
| period      | String      | Identificación del periodo |
| base_salary | Integer     | Salario base               |
| earnings    | Earning[]   | Otros ingresos salariales  |
| deductions  | Deduction[] | Deducciones                |
| taxes       | Tax[]       | Impuestos                  |
| gross_pay   | Integer     | Sueldo bruto               |
| net_pay     | Integer     | Sueldo neto                |

Una respuesta exitosa devuelve los siguiente estructura de datos:

```json
{
    "data": "data"
}
```

### GET /payrolls

Devuelve una lista de los objetos **Payroll**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

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

### POST /payrolls

Crea un objeto **Payroll** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave       | Tipo        | Descripción                | Nota      |
| ----------- | ----------- | -------------------------- | --------- |
| employee    | String      | Cédula del empleado        | Requerido |
| period      | String      | Identificación del periodo | Requerido |
| base_salary | Integer     | Salario base               | Requerido |
| earnings    | Earning[]   | Otros ingresos salariales  | Opcional  |
| deductions  | Deduction[] | Deducciones                | Requerido |
| taxes       | Tax[]       | Impuestos                  | Requerido |

### PUT /payrolls

Actualiza un objeto **Payroll** con el **id** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave       | Tipo        | Descripción                | Nota      |
| ----------- | ----------- | -------------------------- | --------- |
| id          | UUID        | Identificación             | Requerido |
| employee    | String      | Cédula del empleado        | Opcional  |
| period      | String      | Identificación del periodo | Opcional  |
| base_salary | Integer     | Salario base               | Opcional  |
| earnings    | Earning[]   | Otros ingresos salariales  | Opcional  |
| deductions  | Deduction[] | Deducciones                | Opcional  |
| taxes       | Tax[]       | Impuestos                  | Opcional  |

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

## User

El objeto **Employee** es usado para representar un empleado de una empresa.

- Propiedades:

| Llave    | Tipo   | Descripción        |
| -------- | ------ | ------------------ |
| id       | UUID   | Identificación     |
| email    | String | Correo electrónico |
| password | String | Contraseña         |
| company  | String | NIT de la empresa  |

Una respuesta exitosa devuelve los siguiente estructura de datos:

```json
{
    "data": "data"
}
```

### GET /users

Devuelve una lista de los objetos **Employee**.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

### GET /users/{id}

Devuelve un objeto **User** con el **id** proporcionado.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Query y path parameters:

| Llave | Tipo   | Descripción      | Nota      |
| ----- | ------ | ---------------- | --------- |
| id    | String | Número de cédula | Requerido |

### POST /users

Crea un objeto **User** con los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave    | Tipo   | Descripción        | Nota      |
| -------- | ------ | ------------------ | --------- |
| email    | String | Correo electrónico | Requerido |
| password | String | Contraseña         | Requerido |
| company  | String | NIT de la empresa  | Requerido |

### PUT /users

Actualiza un objeto **User** con el **id** y los valores dados.

- Header parameters:

| Llave         | Tipo   | Descripción | Nota      |
| ------------- | ------ | ----------- | --------- |
| Authorization | String | @@@         | Requerido |

- Body parameters:

| Llave | Tipo   | Nota      |
| ----- | ------ | --------- |
| model | Object | Requerido |

- Model parameters:

| Llave    | Tipo   | Descripción        | Nota      |
| -------- | ------ | ------------------ | --------- |
| id       | UUID   | Identificación     | Requerido |
| email    | String | Correo electrónico | Opcional  |
| password | String | Contraseña         | Opcional  |
| company  | String | NIT de la empresa  | Opcional  |

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
