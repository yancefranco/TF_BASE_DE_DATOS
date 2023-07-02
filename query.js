/*Consultas en base de datos no RELACIONAL:
RUBRICA:
Cada miembro del equipo crea dos (2) consultas para la base de datos no relacional, considerando el uso de aggregates. Para cada una de las consultas se indica el propósito de las mismas.
FRANCO FELIX YANCE GUTIERREZ
Consulta01:
Consulta01:*/
//Encontrar el número total de empresas sin correo electrónico.

db.empresas.aggregate([
    {
      $match: {
        correo_electronico: null
      }
    },
    {
      $group: {
        _id: null,
        totalEmpresasSinCorreo: { $sum: 1 }
      }
    }
  ])
  


//Consulta 02:
//Encontrar el número total de empresas que tienen un correo electrónico registrado.

db.empresas.aggregate([
    {
      $match: {
        correo_electronico: { $ne: null }
      }
    },
    {
      $group: {
        _id: null,
        totalEmpresasConCorreo: { $sum: 1 }
      }
    }
  ])




/*Cesar Guerrero:
Consulta 1:
Obtener todas las empresas que paguen a sus empleados en dólares:*/

db.empresas.aggregate([
  {
    $match: { money: "dollar" }
  },
  {
    $group: {
      _id: null,
      empresasQuePaganEnDolares: { $push: "$nombre" }
    }
  }
])



/*Consulta 2:
Obtener todas las empresas que paguen a sus empleados en soles:*/
db.empresas.aggregate([
  {
    $match: { money: "soles" }
  },
  {
    $group: {
      _id: null,
      empresasQuePaganEnDolares: { $push: "$nombre" }
    }
  }
])

/*Pedro Retuerto Diaz
MUESTA LA CANTIDAD DE  EMPRESAS QUE TENGAN NUMEROS TELEFONICOS CELULARES, QUE EMPIECEN CON 9*/
db.empresas.aggregate([
    {
      $match: {
        telefono: /^9/
      }
    },
    {
      $group: {
        _id: null,
        EmpresasConNumeroCelular: { $sum: 1 }
      }
    }
  ])
db.empresas.aggregate([
    {
      $match: {
        telefono: /^9/
      }
    },
    {
      $group: {
        _id: null,
        EmpresasConNumeroCelular: { $sum: 1 }
      }
    }
  ])

[
  {
    "_id": null,
    "EmpresasConNumeroCelular": 3
  }
]

//MUESTRA LA CANTIDAD DE EMPRESAS QUE TENGAN EL RUBRO DE LA TECNOLOGIA
  db.empresas.aggregate([
    {
      $match: {
        nombre: /tech/
      }
    },
    {
      $group: {
        _id: null,
        EmpresasDeTecnologia: { $sum: 1 }
      }
    }
  ])
[
  {
    "_id": null,
    "EmpresasDeIndustria": 1
  }
]

 db.empresas.aggregate([
    {
      $match: {
        nombre: /tech/
      }
    },
    {
      $group: {
        _id: null,
        EmpresasDeTecnologia: { $sum: 1 }
      }
    }
  ])
[
  {
    "_id": null,
    "EmpresasDeIndustria": 1
  }
]

//Rai

//Agrega el campo pais a cada doc de empresas rellena el campo con peru si su telefono acaba en 9

db.empresas.aggregate([
  {
    $addFields: {
      pais: {
        $cond: [
          { $regexMatch: { input: "$telefono", regex: /9$/ } },
          "Peru",
          null
        ]
      }
    }
  }
])

//Muestra las empresas en orden alfabético

db.empresas.aggregate([
  { 
   $sort: { nombre: 1 } 
   },
  { 
   $project: { _id: 0, nombre: 1 }
  }
])


//ALDAIR CRUZ:

//Consulta 01: 

//Obtener todas las empresas donde los correos empiecen con la letra “a”.

db.empresas.aggregate([
    {
      $match: {
        correo_electronico: /a^/
      }
    },
    {
      $group: {
        _id: null,
        totalEmpresasCorreoConA: { $sum: 1 }
      }
    }
  ])









//ALEX ESPINOZA 

//Obtener las empresas que no especificaron su tipo de dinero 

db.empresas.aggregate([
  {
    $match: { money: null }
  },
  {
    $group: {
      _id: null,
      empresasSinMonedaEspecifica: { $push: "$nombre" }
    }
  }
]);











//Obtiene el recuento de empresas que tiene y no tienen algún tipo de moneda 


db.empresas.aggregate([
    {
        $group: {
            _id: "$money",
            numberOfCompanies: { $sum: 1 },
            companies: { $push: "$nombre" }
        }
    },
    {
        $sort: { numberOfCompanies: -1 }
    }
]);


