//creacion de la base de datos empleum y collection empresas
use ('empleum')
db.createCollection("empresas"), {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: ["codigo", "nombre", "telefono", "descripcion"],
        properties: {
          codigo: {
            bsonType: "int"
          },
          nombre: {
            bsonType: "string"
          },
          telefono: {
            bsonType: "string"
          },
          correo_electronico: {
            bsonType: ["string", "null"]
          },
          descripcion: {
            bsonType: "string"
          }
        }
      }
    }
  }
//data de la collection empresas

  db.empresas.insertOne({
    codigo: 10,
    nombre: "GreenTech Solutions",
    telefono: "123456788",
    correo_electronico: "greentech@example.com",
    descripcion: "Empresa líder en tecnología sostenible."
  });
  
  db.empresas.insertOne({
    codigo: 17,
    nombre: "InnovateX Corporation",
    telefono: "678901234",
    correo_electronico: "innovatex@example.com",
    descripcion: "Empresa dedicada a la innovación tecnológica."
  });
  
  db.empresas.insertOne({
    codigo: 31,
    nombre: "Visionary Systems",
    telefono: "890123456",
    correo_electronico: "visionary@example.com",
    descripcion: "Especialistas en soluciones de visión por computadora."
  });
  
  db.empresas.insertOne({
    codigo: 42,
    nombre: "Elite Solutions",
    telefono: "345678912",
    correo_electronico: "elite@example.com",
    descripcion: "Consultoría y desarrollo de software personalizado."
  });
  
  db.empresas.insertOne({
    codigo: 49,
    nombre: "Synergy Enterprises",
    telefono: "789012345",
    correo_electronico: "synergy@example.com",
    descripcion: "Especializados en soluciones de gestión en la nube."
  });
  
  db.empresas.insertOne({
    codigo: 56,
    nombre: "TechnoFusion Solutions",
    telefono: "234567899",
    correo_electronico: "technofusion@example.com",
    descripcion: "Ofrecemos soluciones tecnológicas avanzadas."
  });
  
  db.empresas.insertOne({
    codigo: 63,
    nombre: "BlueWave Corporation",
    telefono: "567890123",
    correo_electronico: "bluewave@example.com",
    descripcion: "Líderes en soluciones empresariales de alta calidad."
  });
  
  db.empresas.insertOne({
    codigo: 78,
    nombre: "OptiTech Solutions",
    telefono: "989876543",
    correo_electronico: "optitech@example.com",
    descripcion: "Proveemos soluciones tecnológicas optimizadas."
  });
  
  db.empresas.insertOne({
    codigo: 87,
    nombre: "Quantum Systems",
    telefono: "456789012",
    correo_electronico: "quantum@example.com",
    descripcion: "Expertos en sistemas tecnológicos avanzados."
  });
  
  db.empresas.insertOne({
    codigo: 91,
    nombre: "AlphaTech Solutions",
    telefono: "765432189",
    correo_electronico: "alphatech@example.com",
    descripcion: "Soluciones tecnológicas innovadoras para empresas."
  });

  db.empresas.insertOne(
    {
    codigo:1,
    nombre:"Acme Corporation",
    telefono:"123456789",
    descripcion:"Descripcion de la empresa Acme Corporation"
    }
    );
    
    db.empresas.insertOne(
    {
    codigo:2,
    nombre:"Globex Industries",
    telefono:"987654321",
    correo_electronico:"empresa2@example.com",
    descripcion:"Descripcion de la empresa Globex Industries"
    }
    );
    
    db.empresas.insertOne(
    {
    codigo:3,
    nombre:"Initech Solutions",
    telefono:"555555555",
    correo_electronico:null,
    descripcion:"Descripcion de la empresa Initech Solutions"
    }
    );
    
    db.empresas.updateOne(
    {codigo:1},
    {$set: {money: "dollar"}}
    )
    
    db.empresas.updateOne(
    {codigo: 2},
    {$set: {money: "soles"}}
    )