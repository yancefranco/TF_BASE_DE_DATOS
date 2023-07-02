--creacion de la base de datos empleum y sus tablas

use empleum

-- Table: carreras
CREATE TABLE carreras (
    codigo int  NOT NULL,
    descripcion varchar(100)  NOT NULL,
    CONSTRAINT carreras_pk PRIMARY KEY  (codigo)
);

-- Table: carreras_por_instituciones
CREATE TABLE carreras_por_instituciones (
    instituciones_codigo int  NOT NULL,
    estudios_academicos_codigo int  NOT NULL,
    CONSTRAINT carreras_por_instituciones_pk PRIMARY KEY  (instituciones_codigo,estudios_academicos_codigo)
);

-- Table: certificaciones
CREATE TABLE certificaciones (
    codigo int  NOT NULL,
    descripcion varchar(50)  NOT NULL,
    CONSTRAINT certificaciones_pk PRIMARY KEY  (codigo)
);

-- Table: certificaciones_por_instituciones
CREATE TABLE certificaciones_por_instituciones (
    certificaciones_codigo int  NOT NULL,
    instituciones_codigo int  NOT NULL,
    CONSTRAINT certificaciones_por_instituciones_pk PRIMARY KEY  (certificaciones_codigo,instituciones_codigo)
);

-- Table: ciudades
CREATE TABLE ciudades (
    codigo int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    paises_codigo int  NOT NULL,
    CONSTRAINT ciudades_pk PRIMARY KEY  (codigo)
);

-- Table: curriculums
CREATE TABLE curriculums (
    codigo int  NOT NULL,
    CONSTRAINT curriculums_pk PRIMARY KEY  (codigo)
);

-- Table: curriculums_por_carreras
CREATE TABLE curriculums_por_carreras (
    curriculums_codigo int  NOT NULL,
    carreras_codigo int  NOT NULL,
    CONSTRAINT curriculums_por_carreras_pk PRIMARY KEY  (curriculums_codigo,carreras_codigo)
);

-- Table: curriculums_por_certificados
CREATE TABLE curriculums_por_certificados (
    curriculums_codigo int  NOT NULL,
    certificaciones_codigo int  NOT NULL,
    CONSTRAINT curriculums_por_certificados_pk PRIMARY KEY  (curriculums_codigo,certificaciones_codigo)
);

-- Table: curriculums_por_est_compl
CREATE TABLE curriculums_por_est_compl (
    curriculums_codigo int  NOT NULL,
    est_compl_codigo int  NOT NULL,
    CONSTRAINT curriculums_por_est_compl_pk PRIMARY KEY  (curriculums_codigo,est_compl_codigo)
);

-- Table: curriculums_por_idiomas
CREATE TABLE curriculums_por_idiomas (
    curriculums_codigo int  NOT NULL,
    idiomas_codigo int  NOT NULL,
    CONSTRAINT curriculums_por_idiomas_pk PRIMARY KEY  (curriculums_codigo,idiomas_codigo)
);

-- Table: empresas
CREATE TABLE empresas (
    codigo int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    telefono char(9)  NOT NULL,
    correo_electronico varchar(20)  NOT NULL,
    descripcion varchar(50)  NOT NULL,
    CONSTRAINT empresas_pk PRIMARY KEY  (codigo)
);

-- Table: empresas_por_ciudades
CREATE TABLE empresas_por_ciudades (
    ciudades_codigo int  NOT NULL,
    empresas_codigo int  NOT NULL,
    CONSTRAINT empresas_por_ciudades_pk PRIMARY KEY  (ciudades_codigo,empresas_codigo)
);

-- Table: estudios_complementarios
CREATE TABLE estudios_complementarios (
    codigo int  NOT NULL,
    instituciones_codigo int  NOT NULL,
    descripcion varchar(50)  NOT NULL,
    CONSTRAINT estudios_complementarios_pk PRIMARY KEY  (codigo)
);

-- Table: experiencia_laboral
CREATE TABLE experiencia_laboral (
    empresas_codigo int  NOT NULL,
    curriculums_codigo int  NOT NULL,
    puesto varchar(50)  NOT NULL,
    descripcion varchar(100)  NOT NULL,
    fecha_inicio date  NOT NULL,
    fecha_fin int  NOT NULL,
    CONSTRAINT experiencia_laboral_pk PRIMARY KEY  (empresas_codigo,fecha_inicio,curriculums_codigo)
);

-- Table: idiomas
CREATE TABLE idiomas (
    codigo int  NOT NULL,
    descripcion varchar(50)  NOT NULL,
    CONSTRAINT idiomas_pk PRIMARY KEY  (codigo)
);

-- Table: instituciones
CREATE TABLE instituciones (
    codigo int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    tipo varchar(20)  NOT NULL,
    ciudades_codigo int  NOT NULL,
    CONSTRAINT instituciones_pk PRIMARY KEY  (codigo)
);

-- Table: oferta_por_empresa
CREATE TABLE oferta_por_empresa (
    empresas_codigo int  NOT NULL,
    ofertas_codigo int  NOT NULL,
    CONSTRAINT oferta_por_empresa_pk PRIMARY KEY  (empresas_codigo,ofertas_codigo)
);

-- Table: ofertas
CREATE TABLE ofertas (
    codigo int  NOT NULL,
    descripcion varchar(500)  NOT NULL,
    puesto int  NOT NULL,
    sueldo int  NULL,
    CONSTRAINT ofertas_pk PRIMARY KEY  (codigo)
);

-- Table: paises
CREATE TABLE paises (
    codigo int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    CONSTRAINT paises_pk PRIMARY KEY  (codigo)
);

-- Table: postulaciones
CREATE TABLE postulaciones (
    codigo int  NOT NULL,
    campo varchar(100)  NOT NULL,
    CONSTRAINT postulaciones_pk PRIMARY KEY  (codigo)
);

-- Table: postulaciones_por_oferta
CREATE TABLE postulaciones_por_oferta (
    ofertas_codigo int  NOT NULL,
    postulaciones_codigo int  NOT NULL,
    CONSTRAINT postulaciones_por_oferta_pk PRIMARY KEY  (ofertas_codigo,postulaciones_codigo)
);

-- Table: usuarios
CREATE TABLE usuarios (
    codigo int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    apellido_paterno varchar(50)  NOT NULL,
    apellido_materno varchar(50)  NOT NULL,
    numero_contacto char(9)  NOT NULL,
    correo varchar(50)  NOT NULL,
    direccion varchar(100)  NOT NULL,
    bio_corta varchar(150)  NOT NULL,
    postulacion_codigo int  NOT NULL,
    curriculums_codigo int  NOT NULL,
    CONSTRAINT usuarios_pk PRIMARY KEY  (codigo)
);

-- foreign keys
-- Reference: certificaciones_por_instituciones_certificaciones (table: certificaciones_por_instituciones)
ALTER TABLE certificaciones_por_instituciones ADD CONSTRAINT certificaciones_por_instituciones_certificaciones
    FOREIGN KEY (certificaciones_codigo)
    REFERENCES certificaciones (codigo);

-- Reference: certificaciones_por_instituciones_instituciones (table: certificaciones_por_instituciones)
ALTER TABLE certificaciones_por_instituciones ADD CONSTRAINT certificaciones_por_instituciones_instituciones
    FOREIGN KEY (instituciones_codigo)
    REFERENCES instituciones (codigo);

-- Reference: ciudades_paises (table: ciudades)
ALTER TABLE ciudades ADD CONSTRAINT ciudades_paises
    FOREIGN KEY (paises_codigo)
    REFERENCES paises (codigo);

-- Reference: curriculums_por_certificados_certificaciones (table: curriculums_por_certificados)
ALTER TABLE curriculums_por_certificados ADD CONSTRAINT curriculums_por_certificados_certificaciones
    FOREIGN KEY (certificaciones_codigo)
    REFERENCES certificaciones (codigo);

-- Reference: curriculums_por_certificados_curriculums (table: curriculums_por_certificados)
ALTER TABLE curriculums_por_certificados ADD CONSTRAINT curriculums_por_certificados_curriculums
    FOREIGN KEY (curriculums_codigo)
    REFERENCES curriculums (codigo);

-- Reference: curriculums_por_estudiosComplementarios_curriculums (table: curriculums_por_est_compl)
ALTER TABLE curriculums_por_est_compl ADD CONSTRAINT curriculums_por_estudiosComplementarios_curriculums
    FOREIGN KEY (curriculums_codigo)
    REFERENCES curriculums (codigo);

-- Reference: curriculums_por_estudiosComplementarios_estudios_complementarios (table: curriculums_por_est_compl)
ALTER TABLE curriculums_por_est_compl ADD CONSTRAINT curriculums_por_estudiosComplementarios_estudios_complementarios
    FOREIGN KEY (est_compl_codigo)
    REFERENCES estudios_complementarios (codigo);

-- Reference: curriculums_por_estudios_curriculums (table: curriculums_por_carreras)
ALTER TABLE curriculums_por_carreras ADD CONSTRAINT curriculums_por_estudios_curriculums
    FOREIGN KEY (curriculums_codigo)
    REFERENCES curriculums (codigo);

-- Reference: curriculums_por_estudios_estudios (table: curriculums_por_carreras)
ALTER TABLE curriculums_por_carreras ADD CONSTRAINT curriculums_por_estudios_estudios
    FOREIGN KEY (carreras_codigo)
    REFERENCES carreras (codigo);

-- Reference: curriculums_por_idiomas_curriculums (table: curriculums_por_idiomas)
ALTER TABLE curriculums_por_idiomas ADD CONSTRAINT curriculums_por_idiomas_curriculums
    FOREIGN KEY (curriculums_codigo)
    REFERENCES curriculums (codigo);

-- Reference: curriculums_por_idiomas_idiomas (table: curriculums_por_idiomas)
ALTER TABLE curriculums_por_idiomas ADD CONSTRAINT curriculums_por_idiomas_idiomas
    FOREIGN KEY (idiomas_codigo)
    REFERENCES idiomas (codigo);

-- Reference: empresas_por_ciudades_ciudades (table: empresas_por_ciudades)
ALTER TABLE empresas_por_ciudades ADD CONSTRAINT empresas_por_ciudades_ciudades
    FOREIGN KEY (ciudades_codigo)
    REFERENCES ciudades (codigo);

-- Reference: empresas_por_ciudades_empresas (table: empresas_por_ciudades)
ALTER TABLE empresas_por_ciudades ADD CONSTRAINT empresas_por_ciudades_empresas
    FOREIGN KEY (empresas_codigo)
    REFERENCES empresas (codigo);

-- Reference: empresas_por_experienciaLaboral_empresas (table: experiencia_laboral)
ALTER TABLE experiencia_laboral ADD CONSTRAINT empresas_por_experienciaLaboral_empresas
    FOREIGN KEY (empresas_codigo)
    REFERENCES empresas (codigo);

-- Reference: estudiosAcademicos_por_instituciones_estudios_academicos (table: carreras_por_instituciones)
ALTER TABLE carreras_por_instituciones ADD CONSTRAINT estudiosAcademicos_por_instituciones_estudios_academicos
    FOREIGN KEY (estudios_academicos_codigo)
    REFERENCES carreras (codigo);

-- Reference: estudiosAcademicos_por_instituciones_instituciones (table: carreras_por_instituciones)
ALTER TABLE carreras_por_instituciones ADD CONSTRAINT estudiosAcademicos_por_instituciones_instituciones
    FOREIGN KEY (instituciones_codigo)
    REFERENCES instituciones (codigo);

-- Reference: estudios_complementarios_instituciones (table: estudios_complementarios)
ALTER TABLE estudios_complementarios ADD CONSTRAINT estudios_complementarios_instituciones
    FOREIGN KEY (instituciones_codigo)
    REFERENCES instituciones (codigo);

-- Reference: experiencia_laboral_curriculums (table: experiencia_laboral)
ALTER TABLE experiencia_laboral ADD CONSTRAINT experiencia_laboral_curriculums
    FOREIGN KEY (curriculums_codigo)
    REFERENCES curriculums (codigo);

-- Reference: instituciones_ciudades (table: instituciones)
ALTER TABLE instituciones ADD CONSTRAINT instituciones_ciudades
    FOREIGN KEY (ciudades_codigo)
    REFERENCES ciudades (codigo);

-- Reference: oferta_por_empresa_empresas (table: oferta_por_empresa)
ALTER TABLE oferta_por_empresa ADD CONSTRAINT oferta_por_empresa_empresas
    FOREIGN KEY (empresas_codigo)
    REFERENCES empresas (codigo);

-- Reference: oferta_por_empresa_ofertas (table: oferta_por_empresa)
ALTER TABLE oferta_por_empresa ADD CONSTRAINT oferta_por_empresa_ofertas
    FOREIGN KEY (ofertas_codigo)
    REFERENCES ofertas (codigo);

-- Reference: postulaciones_por_oferta_ofertas (table: postulaciones_por_oferta)
ALTER TABLE postulaciones_por_oferta ADD CONSTRAINT postulaciones_por_oferta_ofertas
    FOREIGN KEY (ofertas_codigo)
    REFERENCES ofertas (codigo);

-- Reference: postulaciones_por_oferta_postulaciones (table: postulaciones_por_oferta)
ALTER TABLE postulaciones_por_oferta ADD CONSTRAINT postulaciones_por_oferta_postulaciones
    FOREIGN KEY (postulaciones_codigo)
    REFERENCES postulaciones (codigo);

-- Reference: usuario_postulacion (table: usuarios)
ALTER TABLE usuarios ADD CONSTRAINT usuario_postulacion
    FOREIGN KEY (postulacion_codigo)
    REFERENCES postulaciones (codigo);

-- Reference: usuarios_curriculums (table: usuarios)
ALTER TABLE usuarios ADD CONSTRAINT usuarios_curriculums
    FOREIGN KEY (curriculums_codigo)
    REFERENCES curriculums (codigo);

-- End of file.

--Data de la base de datos empleum

Curriculums:
INSERT INTO curriculums (codigo) VALUES (1);
INSERT INTO curriculums (codigo) VALUES (2);
INSERT INTO curriculums (codigo) VALUES (3);
INSERT INTO curriculums (codigo) VALUES (4);
INSERT INTO curriculums (codigo) VALUES (5);
INSERT INTO curriculums (codigo) VALUES (6);
INSERT INTO curriculums (codigo) VALUES (7);
INSERT INTO curriculums (codigo) VALUES (8);
INSERT INTO curriculums (codigo) VALUES (9);
INSERT INTO curriculums (codigo) VALUES (10);
INSERT INTO curriculums (codigo) VALUES (11);
INSERT INTO curriculums (codigo) VALUES (12);

Países:
INSERT INTO paises (codigo, nombre) VALUES (1, 'Peru');
INSERT INTO paises (codigo, nombre) VALUES (2, 'Chile');
INSERT INTO paises (codigo, nombre) VALUES (3, 'Colombia');
INSERT INTO paises (codigo, nombre) VALUES (4, 'Brasil');
INSERT INTO paises (codigo, nombre) VALUES (5, 'Alemania');
INSERT INTO paises (codigo, nombre) VALUES (6, 'Italia');
INSERT INTO paises (codigo, nombre) VALUES (7, 'Venezuela');
INSERT INTO paises (codigo, nombre) VALUES (8, 'Ecuador');
INSERT INTO paises (codigo, nombre) VALUES (9, 'Brazil');
INSERT INTO paises (codigo, nombre) VALUES (10, 'Qatar');

Idiomas:
INSERT INTO idiomas (codigo, descripcion) VALUES (1, 'Ingles');
INSERT INTO idiomas (codigo, descripcion) VALUES (2, 'Espanol');
INSERT INTO idiomas (codigo, descripcion) VALUES (3, 'Frances');
INSERT INTO idiomas (codigo, descripcion) VALUES (4, 'Aleman');
INSERT INTO idiomas (codigo, descripcion) VALUES (5, 'Italiano');
INSERT INTO idiomas (codigo, descripcion) VALUES (6, 'Portugues');
INSERT INTO idiomas (codigo, descripcion) VALUES (7, 'Ruso');
INSERT INTO idiomas (codigo, descripcion) VALUES (8, 'Chino Mandarin');
INSERT INTO idiomas (codigo, descripcion) VALUES (9, 'Japones');
INSERT INTO idiomas (codigo, descripcion) VALUES (10, 'Arabe');


Carreras:
INSERT INTO carreras (codigo, descripcion) VALUES (1, 'Ingenieria de Software');
INSERT INTO carreras (codigo, descripcion) VALUES (2, 'Medicina');
INSERT INTO carreras (codigo, descripcion) VALUES (3, 'Derecho');
INSERT INTO carreras (codigo, descripcion) VALUES (4, 'Arquitectura');
INSERT INTO carreras (codigo, descripcion) VALUES (5, 'Psicologia');
INSERT INTO carreras (codigo, descripcion) VALUES (6, 'Biologia');
INSERT INTO carreras (codigo, descripcion) VALUES (7, 'Matematicas');
INSERT INTO carreras (codigo, descripcion) VALUES (8, 'Fisica');
INSERT INTO carreras (codigo, descripcion) VALUES (9, 'Quimica');
INSERT INTO carreras (codigo, descripcion) VALUES (10, 'Ingenieria de Sistemas');



Certificaciones:
INSERT INTO certificaciones (codigo, descripcion) VALUES (1, 'SCRUM');
INSERT INTO certificaciones (codigo, descripcion) VALUES (2, 'ITIL');
INSERT INTO certificaciones (codigo, descripcion) VALUES (3, 'CISCO Certified');
INSERT INTO certificaciones (codigo, descripcion) VALUES (4, 'Microsoft Certified');
INSERT INTO certificaciones (codigo, descripcion) VALUES (5, 'AWS Certified');
INSERT INTO certificaciones (codigo, descripcion) VALUES (6, 'ORACLE Certified');
INSERT INTO certificaciones (codigo, descripcion) VALUES (7, 'SCRUM Developer');
INSERT INTO certificaciones (codigo, descripcion) VALUES (8, 'Certified Software Development');
INSERT INTO certificaciones (codigo, descripcion) VALUES (9, 'Six Sigma Certified');
INSERT INTO certificaciones (codigo, descripcion) VALUES (10, 'XP');

Postulaciones
INSERT INTO postulaciones (codigo, campo) VALUES (1, 'Desarrollo de Software');
INSERT INTO postulaciones (codigo, campo) VALUES (2, 'Programador Web');
INSERT INTO postulaciones (codigo, campo) VALUES (3, 'Analista de Ciberseguridad');
INSERT INTO postulaciones (codigo, campo) VALUES (4, 'Administrador de Bases de Datos');
INSERT INTO postulaciones (codigo, campo) VALUES (5, 'Ingeniero de Redes');
INSERT INTO postulaciones (codigo, campo) VALUES (6, 'Analista de Sistemas');
INSERT INTO postulaciones (codigo, campo) VALUES (7, 'Desarrollador de Aplicaciones Móviles');
INSERT INTO postulaciones (codigo, campo) VALUES (8, 'Especialista en Inteligencia Artificial');
INSERT INTO postulaciones (codigo, campo) VALUES (9, 'Experto en Cloud Computing');
INSERT INTO postulaciones (codigo, campo) VALUES (10, 'Arquitecto de Software');

Empresas:
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (1, 'Microsoft', '111111111', 'microsoft@correo.com', 'Software');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (2, 'Apple', '222222222', 'apple@correo.com', 'Productos Gama Alta');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (3, 'Sony', '33333333', ' sony@correo.com', 'Empresa multinacional de entretenimiento');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (4, 'Amazon', '444444444', 'amazon@correo.com', 'Empresa con servicio en la nube');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (5, 'Google LLC', '555555555', 'googleLLC@correo.com', 'Compania que ofrece servicios de busqueda en linea');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (6, 'Samsung', '666666666', 'samsung@correo.com', 'Empresa de consumo y tecnologia');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (7, 'Toyota', '777777777', 'toyota@correo.com', 'Fabricante de automoviles');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (8, 'IBM', '888888888', 'IBM@correo.com', 'Empresa de tecnología y consultoria');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (9, 'Intel Corporation', '999999999', 'intel@correo.com',' Empresa fabricante de procesadores');
INSERT INTO empresas (codigo, nombre, telefono, correo_electronico, descripcion)
VALUES (10, 'AMD Corporation', '101010101', 'AMD@correo.com', 'Empresa fabricante de procesadores y chips');




Ofertas:
INSERT INTO ofertas(codigo, descripcion, puesto, sueldo) 
VALUES (1, 'asistente de gerencia','asistente gerencia',1200);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(2,'practicante de programación','practicante fullstack',800);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(3,'asistencia de gerencia','asistente gerencia',900);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(4,'chofer de gerente','chofer de gerente',700);
INSERT INTO ofertas (codigo,descripcion,puesto,sueldo) 
VALUES(5,'desarrollador web avanzado','desarrollador web',1600);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(6,'secretaria tiempo completo','secretaria',1450);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(7,'profesional especializado en el campo de la ciberseguridad','profesional ciberseguridad',2000);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(8,'asistencia de gerencia','asistente gerencia',1200);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(9,'mantenimiento','operario de limpieza',1100);
INSERT INTO ofertas(codigo,descripcion,puesto,sueldo) 
VALUES(10,'gerente general','gerente zona norte',3200);
—--------------------------------------------------------------------------------

Ciudades:
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (1, 'Lima', 1);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (2, 'Arequipa', 1);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (3, 'Santiago', 2);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (4, 'Iquique', 2);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (5, 'Bogota', 3);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (6, 'Barranquilla', 3);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (7, 'Sao Paulo', 4);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (8, 'Brasilia', 4);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (9, 'Quito', 8);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (10, 'Cartagena', 3)
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (11, 'Guayaquil', 8);
INSERT INTO ciudades (codigo, nombre, paises_codigo) VALUES (12, 'Caracas', 7);

empresas_por_ciudades:

INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (1, 1);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (2, 1);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (2, 2);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (3, 3);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (1, 3);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (5, 3);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (4, 4);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (5, 5);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (6, 6);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (7, 7);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (8, 8);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (9, 9);
INSERT INTO empresas_por_ciudades (ciudades_codigo, empresas_codigo)
VALUES (10, 10);

oferta_por_empresa

INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (1, 1);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (2, 2);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (3, 3);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (4, 4);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (5, 5);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (6, 6);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (7, 7);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (8, 8);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (9, 9);
INSERT INTO oferta_por_empresa (empresas_codigo, ofertas_codigo)
VALUES (10, 10);

curriculums_por_idiomas
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (1, 1);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (1, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (1, 3);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (2, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (3, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (3, 3);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (4, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (5, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (6, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (7, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (8, 1);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (8, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (9, 2);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (10, 1);
INSERT INTO curriculums_por_idiomas (curriculums_codigo, idiomas_codigo)
VALUES (10, 2);

Instituciones

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (1, 'UPC', 'universidad', 1);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (2, 'PUCP', 'universidad', 1);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (3, 'USACH', 'universidad', 3);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (4, 'ITIQ', 'instituto', 4);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (5, 'UC', 'universidad', 3);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (6, 'UPN', 'universidad', 1);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (7, 'UNESP', 'universidad', 4);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (8, 'Cibertec', 'instituto', 1);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (9, 'UCV', 'universidad', 7);

INSERT INTO instituciones (codigo, nombre, tipo, ciudades_codigo)
VALUES (10, 'UCB', 'universidad', 4);



Carreras por instituciones 

INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (1, 1);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (2, 3);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (3, 8);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (4, 5);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (5, 3);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (6, 3);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (7, 5);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (8, 10);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (9, 5);
INSERT INTO carreras_por_instituciones (instituciones_codigo, estudios_academicos_codigo)
VALUES (10, 9);

experiencia laboral

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (1, 1, 'Desarrollador Web', 'Responsable de la creacion y mantenimiento de aplicaciones web.', '2022-01-01', '2022-12-31');
INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (3, 1, 'Desarrollador Backend', 'Responsable del mantenimiento del servicio backend.', '2020-01-01', '2021-12-31');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (2, 2, 'Especialista en Ciberseguridad', 'Encargado de garantizar la seguridad de la infraestructura y los sistemas de la empresa.', '2022-02-01', '2022-11-30');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (3, 3, 'Analista de Redes', 'Responsable del diseño, configuracion y mantenimiento de la infraestructura de redes de la empresa.', '2022-03-01', '2022-10-31');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (4, 4, 'Consultor de Seguridad', 'Encargado de brindar asesoramiento y recomendaciones para mejorar la seguridad de la empresa.', '2022-04-01', '2022-09-30');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (5, 5, 'Ingeniero de Sistemas', 'Responsable del diseño, implementacion y mantenimiento de los sistemas informaticos de la empresa.', '2022-05-01', '2022-08-31');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (6, 6, 'Desarrollador de Aplicaciones Moviles', 'Encargado de crear y mantener aplicaciones moviles para la empresa.', '2022-06-01', '2022-07-31');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (7, 7, 'Especialista en Seguridad de la Información', 'Responsable de proteger la informacion confidencial y garantizar el cumplimiento de politicas de seguridad.', '2022-07-01', '2022-06-30');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (8, 8, 'Administrador de Bases de Datos', 'Encargado del diseño, implementacion y administracion de las bases de datos de la empresa.', '2022-08-01', '2022-05-31');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (9, 9, 'Tecnico de Soporte', 'Responsable de brindar soporte tecnico a los usuarios de la empresa.', '2022-09-01', '2022-04-30');

INSERT INTO experiencia_laboral (empresas_codigo, curriculums_codigo, puesto, descripcion, fecha_inicio, fecha_fin)
VALUES (10, 10, 'Analista de Seguridad de la Informacion', 'Encargado de identificar y mitigar riesgos de seguridad en los sistemas y la infraestructura.', '2022-10-01', '2022-03-31');

curriculums por carrera

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (1, 1);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (1, 5);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (2, 2);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (3, 3);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (4, 4);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (5, 5);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (6, 6);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (7, 7);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (8, 8);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (9, 9);

INSERT INTO curriculums_por_carreras (curriculums_codigo, carreras_codigo)
VALUES (10, 10);

certificaciones por instituciones—---------------------------------

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (1, 1);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (5, 1);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (7, 1);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (2, 2);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (3, 3);
INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (3, 2);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (4, 4);
INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (4, 2);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (5, 5);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (6, 6);
INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (6, 1);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (7, 7);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (8, 8);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (9, 9);

INSERT INTO certificaciones_por_instituciones (certificaciones_codigo, instituciones_codigo)
VALUES (10, 10);


CURRICULUMS POR CERTIFICADOS—------

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (1, 10);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (1, 8);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (1, 6);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (1, 4);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (1, 1);


INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (2, 9);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (2, 10);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (2, 8);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (2, 6);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (2, 4);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (2, 2);

INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (3, 8);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (3, 1);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (4, 7);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (5, 6);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (5, 5);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (6, 5);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (7, 4);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (8, 3);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (9, 2);
INSERT INTO curriculums_por_certificados (curriculums_codigo, certificaciones_codigo)
VALUES (10, 1);
Estudios complementarios
INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (1, 1, 'Curso de Agile Methodology');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (2, 2, 'Curso de Artes Visuales');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (3, 3, 'Curso de Filosofia de las Ciencias');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (4, 4, 'Curso de Aislamiento y Bloqueo');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (5, 5, 'Curso de Diseño, Futuro y Sustentabilidad');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (6, 6, 'Curso de Matematica Financiera');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (7, 2, 'Curso de Finanzas personales');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (8, 1, 'Curso de Diseño Instruccional');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (9, 2, 'Curso de Logistica y SCM');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (10, 5, 'Curso de Transformación Digital');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (11, 1, 'Curso de Data Analytics');

INSERT INTO estudios_complementarios (codigo, instituciones_codigo, descripcion)
VALUES (12, 4, 'Curso de Desarrollo Web');



Curriculum por estudios complementarios

INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (1,2);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (1,10);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (1,11);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (2,4);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (3,6);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (4,8);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (5,10);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (6,12);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (7,1);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (8,3);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (9,5);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (10,7);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (11,9);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (11,7);
INSERT INTO curriculums_por_est_compl (curriculums_codigo, est_compl_codigo)
VALUES (12,11);


USUARIOS:

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (1, 'Juan', 'Pérez', 'Gómez', '123456789', 'juan.perez@example.com', 'Calle Principal 123', 'Desarrollador web con experiencia en PHP y MySQL.', 1, 1);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (2, 'María', 'González', 'López', '987654321', 'maria.gonzalez@example.com', 'Avenida Central 456', 'Especialista en ciberseguridad y auditoría de sistemas.', 2, 2);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (3, 'Carlos', 'Martínez', 'Hernández', '567890123', 'carlos.martinez@example.com', 'Boulevard Principal 789', 'Ingeniero de redes con certificación CCNA.', 3, 3);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (4, 'Ana', 'López', 'Sánchez', '012345678', 'ana.lopez@example.com', 'Carrera Central 012', 'Experta en seguridad informática y análisis forense.', 4, 4);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (5, 'Pedro', 'Ramírez', 'García', '678901234', 'pedro.ramirez@example.com', 'Avenida Principal 345', 'Desarrollador de aplicaciones móviles con experiencia en React Native.', 5, 5);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (6, 'Laura', 'Hernández', 'Rodríguez', '432109876', 'laura.hernandez@example.com', 'Calle Central 567', 'Administradora de bases de datos con conocimientos en SQL Server.', 6, 6);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (7, 'Javier', 'Gutiérrez', 'Santos', '890123456', 'javier.gutierrez@example.com', 'Boulevard Principal 890', 'Experto en seguridad de la información y gestión de riesgos.', 7, 7);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (8, 'Sofía', 'Morales', 'Fernández', '654321098', 'sofia.morales@example.com', 'Avenida Central 567', 'Desarrolladora web full-stack con conocimientos en HTML, CSS y JavaScript.', 8, 8);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (9, 'Luis', 'Gómez', 'Mendoza', '987654321', 'luis.gomez@example.com', 'Calle Principal 234', 'Especialista en seguridad de redes y análisis de vulnerabilidades.', 9, 9);

INSERT INTO usuarios (codigo, nombre, apellido_paterno, apellido_materno, numero_contacto, correo, direccion, bio_corta, postulacion_codigo, curriculums_codigo)
VALUES (10, 'Daniela', 'Castillo', 'Pérez', '321098765', 'daniela.castillo@example.com', 'Avenida Central 789', 'Ingeniera de software con experiencia en desarrollo de aplicaciones empresariales.', 10, 10);

Postulaciones por oferta

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (5, 5);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (7, 2);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (7, 7);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (7, 5);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (2, 5);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (2, 7);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (5, 7);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (5, 2);

INSERT INTO postulaciones_por_oferta (ofertas_codigo, postulaciones_codigo)
VALUES (2, 2);


