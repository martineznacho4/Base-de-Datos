# E-market

# Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
# ● Id de la factura - DONE
# ● fecha de la factura - DONE
# ● nombre de la empresa de correo EnvioVia -> CorreoID | correos - DONE
# ● nombre del cliente | clientes DONE
# ● categoría del producto vendido DONE
# ● nombre del producto DONE
# ● precio unitario
# ● cantidad


SELECT facturas.FacturaID, facturas.FechaFactura, correos.CorreoID, clientes.Compania, categorias.CategoriaNombre, productos.ProductoNombre, facturadetalle.PrecioUnitario, facturadetalle.Cantidad

FROM emarket.facturas

INNER JOIN correos ON facturas.EnvioVia = correos.CorreoID

INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID

INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
INNER JOIN productos ON facturadetalle.ProductoID = productos.ProductoID
INNER JOIN categorias ON productos.CategoriaID = categorias.CategoriaID;

#ORDER BY facturas.FacturaID, CategoriaNombre, ProductoNombre;



# -- -------------------------------------------------------------------------------------

# 1. Listar todas las categorías junto con información de sus productos. Incluir todas
# las categorías aunque no tengan productos.

SELECT categorias.CategoriaNombre, productos.ProductoNombre
FROM emarket.categorias
LEFT JOIN productos ON productos.CategoriaID = categorias.CategoriaID;


# 2. Listar la información de contacto de los clientes que no hayan comprado nunca
# en emarket.

SELECT clientes.Contacto
FROM emarket.clientes
LEFT JOIN emarket.facturas ON facturas.ClienteID = clientes.ClienteID
WHERE facturas.ClienteID IS NULL;

# 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
# la información de contacto de su proveedor. Tener en cuenta que puede haber
# productos para los cuales no se indicó quién es el proveedor.

SELECT productos.ProductoNombre, categorias.CategoriaNombre, proveedores.Contacto
FROM 


# 4. Para cada categoría listar el promedio del precio unitario de sus productos.

# 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
# nunca hayan comprado en e-market.

# 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
# listado con todas las empresas de correo, y la cantidad de facturas
# correspondientes. Realizar la consulta utilizando RIGHT JOIN.







