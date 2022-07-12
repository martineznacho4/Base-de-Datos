# Clientes
SELECT * FROM emarket.clientes;

# 1) ¿Cuántos clientes existen?

SELECT COUNT(clientes.ClienteID)
FROM emarket.clientes;

# 2) ¿Cuántos clientes hay por ciudad?

SELECT ciudad, COUNT(ClienteID)
FROM emarket.clientes
GROUP BY ciudad;

# --------------------------------------------------------------------------------------------------

# Facturas

SELECT * FROM emarket.facturas;

# 1) ¿Cuál es el total de transporte?

SELECT SUM(Transporte)
FROM emarket.facturas;

# 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

SELECT envioVia, SUM(transporte)
FROM emarket.facturas
GROUP BY envioVia;

# 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
# cantidad de facturas.

SELECT ClienteID, COUNT(FacturaID) AS cantidadFacturas
FROM emarket.facturas
GROUP BY ClienteID
ORDER BY cantidadFacturas DESC;

# 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

SELECT ClienteID, COUNT(FacturaID) AS cantidadFacturas
FROM emarket.facturas
GROUP BY ClienteID
ORDER BY cantidadFacturas DESC
LIMIT 5;

# 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

SELECT PaisEnvio, COUNT(FacturaID) AS cantidadFacturas
FROM emarket.facturas
GROUP BY PaisEnvio
ORDER BY cantidadFActuras
LIMIT 1;

# 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
# realizó más operaciones de ventas?

SELECT EmpleadoID, COUNT(FacturaID) AS cantidadFacturas
FROM emarket.facturas
GROUP BY EmpleadoID
ORDER BY cantidadFacturas
LIMIT 1;

# --------------------------------------------------------------------------------------------------

# Factura detalle

SELECT * FROM emarket.facturadetalle;

# 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

SELECT ProductoID, COUNT(*) AS cantidad
FROM emarket.facturadetalle
GROUP BY ProductoID
ORDER BY cantidad DESC;

# 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
# cantidad por precio unitario.

SELECT SUM(PrecioUnitario * Cantidad) AS totalFacturado
FROM emarket.facturadetalle;

# 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?

SELECT ProductoID, SUM(PrecioUnitario * Cantidad) AS totalFacturado
FROM emarket.facturadetalle
WHERE ProductoID BETWEEN 30 AND 50
GROUP BY ProductoID;

# 4) ¿Cuál es el precio unitario promedio de cada producto?

SELECT ProductoID, AVG(PrecioUnitario) AS promedio
FROM emarket.facturadetalle
GROUP BY ProductoID;

# 5) ¿Cuál es el precio unitario máximo?

SELECT ProductoID, MAX(PrecioUnitario) AS precioMaximo
FROM emarket.facturadetalle;

# --------------------------------------------------------------------------------------------------

# JOIN

# 1) Generar un listado de todas las facturas del empleado 'Buchanan'.

SELECT * FROM emarket.facturas;

SELECT FacturaID
FROM emarket.facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
WHERE empleados.Apellido = 'Buchanan';

# 2) Generar un listado con todos los campos de las facturas del correo 'Speedy
# Express'.

SELECT * 
FROM emarket.facturas
INNER JOIN correos ON facturas.EnvioVia = correos.CorreoID
WHERE correos.Compania = 'Speedy Express';

# 3) Generar un listado de todas las facturas con el nombre y apellido de los
# empleados.

SELECT FacturaID, concat(empleados.apellido, ' ', empleados.nombre) AS Empleado
FROM emarket.facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID;

# 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío
# “USA”.

SELECT facturas.* 
FROM emarket.facturas
INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID
WHERE clientes.Titulo LIKE '%Owner%' AND clientes.Pais = 'USA';

# 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
# “Leverling” o que incluyan el producto id = “42”.

SELECT facturas.*
FROM emarket.facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
WHERE empleados.Apellido = 'Leverling' OR facturadetalle.ProductoID = 42;


# 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
# “Leverling” y que incluya los producto id = “80” o ”42”.

SELECT facturas.*
FROM emarket.facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
WHERE empleados.Apellido = 'Leverling' AND (facturadetalle.ProductoID = 42 OR facturadetalle.ProductoID = 80);

# 7) Generar un listado con los cinco mejores clientes, según sus importes de
# compras total (PrecioUnitario * Cantidad).

SELECT clientes.ClienteID, compania, SUM(facturadetalle.PrecioUnitario * facturadetalle.Cantidad) AS Total
FROM clientes
INNER JOIN facturas ON clientes.ClienteID = facturas.ClienteID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
GROUP BY ClienteID
ORDER BY Total DESC
LIMIT 5;

# 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
# fecha de factura, país de envío, Total, ordenado de manera descendente por
# fecha de factura y limitado a 10 filas.

SELECT facturas.FacturaID, clientes.contacto, facturas.FechaFactura, facturas.PaisEnvio, SUM(facturadetalle.PrecioUnitario * facturadetalle.Cantidad) AS Total
FROM emarket.facturas
INNER JOIN emarket.clientes ON facturas.ClienteID = clientes.ClienteID
INNER JOIN emarket.facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
GROUP BY FacturaID
ORDER BY facturas.FechaFactura DESC
LIMIT 10;
