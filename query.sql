BASE DE DATOS RELACIONAL CONSULTAS:
RUBRICA:
Cada miembro del equipo crea tres (3) consultas para la base de datos relacional, considerando una (1) básica y dos (2) de nivel intermedio que incluyan la creación de procedimientos almacenados y/o funciones, agregaciones, joins, subconsultas. Para cada una de las consultas se indica el propósito de la misma.

FRANCO FELIX YANCE GUTIERREZ:

CONSULTA 01:

-- Esta consulta selecciona todos los datos de la tabla 'usuarios'
SELECT * FROM usuarios;

CONSULTA 02:

-- Esta consulta calcula el salario promedio de las ofertas de trabajo para cada empresa
-- Primero, une las tablas 'empresas', 'oferta_por_empresa' y 'ofertas' basándose en los códigos correspondientes
-- Luego, agrupa los resultados por el nombre de la empresa
-- Finalmente, calcula el salario promedio para cada grupo (cada empresa)
SELECT e.nombre, AVG(o.sueldo) as salario_promedio
FROM empresas e
JOIN oferta_por_empresa oe ON e.codigo = oe.empresas_codigo
JOIN ofertas o ON oe.ofertas_codigo = o.codigo
GROUP BY e.nombre;

CONSULTA 03:

-- Este procedimiento almacenado recupera todas las ofertas de trabajo para una empresa dada
-- El nombre de la empresa se pasa como parámetro (@nombreEmpresa)
-- Primero, une las tablas 'empresas', 'oferta_por_empresa' y 'ofertas' basándose en los códigos correspondientes
-- Luego, selecciona todas las ofertas de trabajo donde el nombre de la empresa coincide con el parámetro dado
CREATE PROCEDURE ObtenerOfertasPorEmpresa(@nombreEmpresa VARCHAR(50))
AS
BEGIN
    SELECT o.*
    FROM empresas e
    JOIN oferta_por_empresa oe ON e.codigo = oe.empresas_codigo
    JOIN ofertas o ON oe.ofertas_codigo = o.codigo
    WHERE e.nombre = @nombreEmpresa;
END;
-- Este comando ejecuta el procedimiento almacenado 'ObtenerOfertasPorEmpresa'
-- Pasamos 'Microsoft' como el parámetro @nombreEmpresa
EXEC ObtenerOfertasPorEmpresa @nombreEmpresa = 'Microsoft';





PEDRO ALEJANDRO RETUERTO DIAZ
–muestra el nombre del campo de trabajo con sueldo mayor a 1000, acorde a un parametro de funcion
CREATE FUNCTION CampoSueldo(@nombre varchar(50)) RETURNS TABLE
AS
RETURN
    SELECT p.campo, o.sueldo
    FROM ofertas AS o
    JOIN postulaciones AS p ON p.codigo = o.codigo
    WHERE o.sueldo > 1000
      AND p.campo LIKE '%' + @nombre + '%';

go;
select * from CampoSueldo('a')
—------------------------------------------------------------------------------------------
–crea una vista para visualizar el nombre de pais, codigo y nombre
CREATE VIEW MostrarNombrePaisCiudad AS
SELECT p.codigo, p.nombre AS nombre_pais, c.nombre AS nombre_ciudad
FROM paises AS p
JOIN ciudades AS c ON p.codigo = c.paises_codigo;
go;
select * from MostrarNombrePaisCiudad
—-------------------------------------------------------------------------------------------
–selecciona las postulaciones que tengan como contenido inicial la palabra desarroll
select * from postulaciones
where campo like'desarroll%'
go;
—--------------------------------------------------------------------------------------------

Cesar Guerrero:
-- Mostrar la ciudad con más instituciones
CREATE VIEW Cantidad_de_instituciones_por_Ciudad
as
	SELECT c.nombre, COUNT(DISTINCT(i.nombre)) as 'Cantidad'
	FROM ciudades as c
	JOIN instituciones as i
	ON c.codigo = i.ciudades_codigo
	GROUP BY c.nombre
	   
SELECT c.nombre
FROM ciudades as c
JOIN instituciones as i
ON c.codigo = i.ciudades_codigo
GROUP BY c.nombre
HAVING COUNT(DISTINCT(i.nombre)) = 
		(SELECT MAX(Cantidad)
		FROM Cantidad_de_instituciones_por_Ciudad as Temporal)


-- Mostrar los nombres de las personas que hayan tenido algun estudio o curso en la UPC.
CREATE PROCEDURE usp_print_usuarios_en_UPC
as
begin
	declare @nombre varchar(100)
	declare cursor_name cursor for

	SELECT DISTINCT CONCAT(u.nombre, ' ', u.apellido_paterno)
	FROM usuarios as u
	JOIN curriculums as cu ON u.curriculums_codigo = cu.codigo
	JOIN curriculums_por_carreras as cpc ON cu.codigo = cpc.curriculums_codigo
	JOIN carreras as ca ON cpc.carreras_codigo = ca.codigo
	JOIN carreras_por_instituciones as cpi ON ca.codigo = cpi.estudios_academicos_codigo
	JOIN instituciones as i ON cpi.instituciones_codigo = i.codigo
	JOIN curriculums_por_certificados as cpce ON cu.codigo = cpce.curriculums_codigo
	JOIN certificaciones as ce ON cpce.certificaciones_codigo = ce.codigo
	JOIN certificaciones_por_instituciones as cepi ON ce.codigo = cepi.certificaciones_codigo
	JOIN instituciones ON cepi.instituciones_codigo = i.codigo
	JOIN curriculums_por_est_compl as cpec ON cu.codigo = cpec.curriculums_codigo
	JOIN estudios_complementarios as ec ON cpec.est_compl_codigo = ec.codigo
	JOIN instituciones as ins ON ec.codigo = ins.codigo
	WHERE i.nombre = 'UPC'
	open cursor_name
	fetch cursor_name into @nombre

	while(@@FETCH_STATUS = 0)
	begin
	print(CONVERT(varchar(100), @nombre))
	fetch cursor_name into @nombre
	end
	close cursor_name
	deallocate cursor_name
end

exec usp_print_usuarios_en_UPC

-- Mostrar los nombres de las personas que tengan las certificacion de SCRUM y hablen ingles

CREATE FUNCTION Usuarios_con_scrum_ingles () returns table
as
return
SELECT CONCAT(u.nombre,' ', u.apellido_paterno) as Nombre
FROM usuarios as u
JOIN curriculums as cu
ON u.curriculums_codigo = cu.codigo
JOIN curriculums_por_certificados as cpce
ON cu.codigo = cpce.curriculums_codigo
JOIN certificaciones as ce
ON cpce.certificaciones_codigo = ce.codigo
JOIN curriculums_por_idiomas as cpi
ON cu.codigo = cpi.curriculums_codigo
JOIN idiomas as idio
ON cpi.idiomas_codigo = idio.codigo
WHERE ce.descripcion LIKE 'SCRUM' AND idio.descripcion = 'Ingles'

select * from Usuarios_con_scrum_ingles()

Raizo Valdivia

Mostrar el nombre de las instituciones con su respectiva ciudad donde se ubica

CREATE VIEW instituciones_alfabetico_por_ciudades 
AS
SELECT ciudades.nombre AS ciudad, instituciones.nombre AS institucion
FROM ciudades
JOIN instituciones ON ciudades.codigo = instituciones.ciudades_codigo

SELECT * 
FROM instituciones_alfabetico_por_ciudades
ORDER BY institucion DESC;



Mostrar las ofertas que tiene cada empresa y de dónde son

CREATE VIEW lista_empresas_ofertas_paises AS
SELECT e.nombre AS empresa, o.puesto, p.nombre AS pais
FROM empresas e
JOIN empresas_por_ciudades ec ON e.codigo = ec.empresas_codigo
JOIN ciudades c ON ec.ciudades_codigo = c.codigo
JOIN paises p ON c.paises_codigo = p.codigo
JOIN oferta_por_empresa oe ON e.codigo = oe.empresas_codigo
JOIN ofertas o ON oe.ofertas_codigo = o.codigo;
SELECT * FROM lista_empresas_ofertas_paises;


Mostrar los datos de la tabla empresas, ordenados dependiendo de quien tenga el correo con más caracteres.

CREATE VIEW empresas_ordenadas AS
SELECT *
FROM empresas
ORDER BY LENGTH(correo_electronico) DESC;
SELECT * FROM empresas_ordenadas;

ALdair Cruz:

-Mostrar el nombre de la empresa y consecuentemente nos muestre el respectivo  país donde pertenece:

CREATE VIEW empresas_por_paises AS
SELECT paises nombre AS pais, empresas nombre AS empresa
FROM paises
JOIN empresas ON paises.codigo = empresas.paises_codigo
ORDER BY empresas.nombre
SELECT * FROM empresas_por_paises

-Mostrar el nombre de las carreras y la universidad a la cual pertenece 

CREATE VIEW carreras_orden_por_instituciones AS
SELECT instituciones.nombre AS institucion, carreras.nombre AS carrera
FROM instituciones
JOIN carreras ON instituciones.codigo = carreras.instituciones_codigo
ORDER BY carreras.nombre DESC;
SELECT * FROM carreras_orden_por_instituciones

- Mostrar el nombre de los postulantes que tengan el AWS Certified y hablen y/o dominen el chino madarín
CREATE FUNCTION Usuarios_con_aws_chinom () RETURNS TABLE AS
RETURN
SELECT CONCAT(u.nombre,' ', u.apellido_paterno) as Nombre
FROM usuarios AS usu
JOIN curriculums AS cur
ON usu.curriculums_codigo = cur.codigo
JOIN curriculums_por_certificados AS cupoce
ON cur.codigo = cupoce.curriculums_codigo
JOIN certificaciones AS cer
ON cupoce.certificaciones_codigo = cer.codigo
JOIN curriculums_por_idiomas AS cupoid
ON cur.codigo = cupoid.curriculums_codigo
JOIN idiomas AS idi
ON cupoid.idiomas_codigo = idi.codigo
WHERE cer.descripcion LIKE 'AWS Certified' AND idio.descripcion = 'Chino Mandarin'

select * from Usuarios_con_aws_chinom()

Alex Espinoza

CONSULTA 1:

Ver los nombres de los usuarios y las carreras que han estudiado

CREATE VIEW vw_UsuariosYCarreras
AS
SELECT u.nombre, ca.descripcion as carrera
FROM usuarios u
JOIN curriculums_por_carreras cpc ON u.curriculums_codigo = cpc.curriculums_codigo
JOIN carreras ca ON cpc.carreras_codigo = ca.codigo;

SELECT * FROM vw_UsuariosYCarreras;



CONSULTA 2:

Obtener el número total de usuarios que han estudiado cada carrera

SELECT ca.descripcion, COUNT(u.codigo) as total_usuarios
FROM usuarios u
JOIN curriculums_por_carreras cpc ON u.curriculums_codigo = cpc.curriculums_codigo
JOIN carreras ca ON cpc.carreras_codigo = ca.codigo
GROUP BY ca.descripcion;



CONSULTA 3:

Obtener una lista de usuarios que han estudiado una carrera específica

CREATE PROCEDURE ObtenerUsuariosPorCarrera(@nombreCarrera VARCHAR(50))
AS
BEGIN
    SELECT u.*
    FROM usuarios u
    JOIN curriculums_por_carreras cpc ON u.curriculums_codigo = cpc.curriculums_codigo
    JOIN carreras ca ON cpc.carreras_codigo = ca.codigo
    WHERE ca.descripcion = @nombreCarrera;
END;

EXEC ObtenerUsuariosPorCarrera @nombreCarrera = 'Ingeniería de Sistemas';

