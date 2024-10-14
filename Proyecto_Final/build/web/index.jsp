<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si el usuario está autenticado
    if (session.getAttribute("usuario") == null) {
        // Si no está autenticado redirigir a home.jsp
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            padding-top: 50px;
            transition: all 0.3s ease-in-out;
            z-index: 1000;
        }
        .sidebar h3 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            text-align: center;
            color: #ffffff; 
            text-transform: uppercase; 
            text-shadow: 7px 4px 4px rgba(0, 0, 0, 0.3); 
            margin-bottom: 20px; 
            transition: all 0.3s ease-in-out;
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .sidebar-collapsed {
            width: 60px;
            transition: width 0.3s ease-in-out;
        }

        .sidebar-collapsed h3 {
            display: none;
        }

        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }

        .sidebar a:hover {
            background-color: #5a67d8;
            color: white;
        }

        .sidebar a i {
            margin-right: 20px;
            vertical-align: middle;
            position: relative;
            top: -2px;
        }

        .content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s ease-in-out;
        }

        .content-collapsed {
            margin-left: 60px;
        }

        .logout-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff4d4d;
            color: white;
            border-radius: 50%;
            border: none;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .logout-button:hover {
            background-color: #e63946;
        }

        .toggle-button {
            position: absolute;
            top: 10px;
            left: 10px;
            background: transparent;
            color: white;
            border: none;
            font-size: 24px;
            cursor: pointer;
            outline: none;
            margin-bottom: 50px;
        }
    </style>
</head>
<body>

    <!-- Botón de Cerrar Sesión -->
    <form action="sr_logout" method="post">
        <button type="submit" class="logout-button" title="Cerrar Sesión">
            <i class="material-icons">exit_to_app</i>
        </button>
    </form>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <!-- Botón de Menú Hamburguesa -->
        <button class="toggle-button" id="toggle-sidebar" title="Mostrar/Ocultar Sidebar">
            <i class="material-icons">menu</i>
        </button>
        <h3>Sains Mall</h3>
        <a href="javascript:void(0);" id="ventas-link"><i class="material-icons">storefront</i> <span class="link-text">Ventas</span></a>
        <a href="javascript:void(0);" id="clientes-link"><i class="material-icons">person_pin</i> <span class="link-text">Clientes</span></a>
        <a href="javascript:void(0);" id="proveedores-link"><i class="material-icons">group</i> <span class="link-text">Proveedores</span></a>
        <a href="javascript:void(0);" id="productos-link"><i class="material-icons">local_shipping</i> <span class="link-text">Productos</span></a>
        <a href="javascript:void(0);" id="marcas-link"><i class="material-icons">add_box</i> <span class="link-text">Marcas</span></a>
        <a href="javascript:void(0);" id="empleados-link"><i class="material-icons">person</i> <span class="link-text">Empleados</span></a>
        <a href="javascript:void(0);" id="Puestos-link"><i class="material-icons">switch_account</i> <span class="link-text">Puestos</span></a>
        <a href="javascript:void(0);" id="usuarios-link"><i class="material-icons">account_circle</i> <span class="link-text">Usuarios</span></a>
        <a href="javascript:void(0);" id="roles-link"><i class="material-icons">supervisor_account</i> <span class="link-text">Roles</span></a>
    </div>

    <div class="content" id="content">
        <div id="contenido-dinamico"></div>

        <!-- Verifica si hay mensaje -->
        <%
            String mensaje = (String) session.getAttribute("mensaje");
            if (mensaje != null) {
        %>
        <div class="alert alert-success d-flex align-items-center" role="alert" id="mensajeAlerta">
            <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
            <span id="mensajeTexto"><%= mensaje %></span>
        </div>

        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                var mensajeAlerta = document.getElementById("mensajeAlerta");
                setTimeout(function(){
                    mensajeAlerta.remove();
                }, 2000);
            });
        </script>

        <%
            session.removeAttribute("mensaje");
        %>
        <% } %>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            // Cargar el contenido de empleados
            $('#empleados-link').click(function(){
                $('#contenido-dinamico').load('empleados.jsp');
            });
            // Cargar el contenido de puestos
            $('#Puestos-link').click(function(){
                $('#contenido-dinamico').load('Puestos.jsp');
            });
            // Cargar el contenido de clientes
            $('#clientes-link').click(function(){
                $('#contenido-dinamico').load('clientes.jsp');
            });
            // Cargar el contenido de proveedores
            $('#proveedores-link').click(function(){
                $('#contenido-dinamico').load('proveedores.jsp');
            });
            // Cargar el contenido de marcas
            $('#marcas-link').click(function(){
                $('#contenido-dinamico').load('marcas.jsp');
            });
            // Cargar el contenido de productos
            $('#productos-link').click(function(){
                $('#contenido-dinamico').load('productos.jsp');
            });
            $('#usuarios-link').click(function(){
                $('#contenido-dinamico').load('usuarios.jsp');
            });
            $('#roles-link').click(function(){
                $('#contenido-dinamico').load('roles.jsp');
            });
            
            $('#ventas-link').click(function(){
                $('#contenido-dinamico').load('ventas.jsp');
            });

            // oculta o muestra el sidebar
            $('#toggle-sidebar').click(function() {
                $('#sidebar').toggleClass('sidebar-collapsed');
                $('#content').toggleClass('content-collapsed');

                if ($('#sidebar').hasClass('sidebar-collapsed')) {
                    $('#toggle-sidebar i').text('chevron_right');
                    $('.link-text').hide();
                    $('#sidebar h3').hide();
                } else {
                    $('#toggle-sidebar i').text('menu');
                    $('.link-text').show();
                    $('#sidebar h3').show();
                }
            });
        });
    </script>
</body>
</html>
