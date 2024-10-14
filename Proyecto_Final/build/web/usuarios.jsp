<%@page import="modelo.Usuarios" %>
<%@page import="modelo.Roles" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-label {
            font-weight: bold;
        }
        .modal-body {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 0.5rem;
        }
        .form-control {
            border-radius: 0.5rem;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
        }
        .modal-footer {
            border-top: none;
        }
        h1 {
            color: #00bfa5;
            font-weight: bold;
            margin-bottom: 2rem;
        }
        .btn-custom {
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
        }
        .table-header {
            background-color: #000000;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Usuarios</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_usuarios" onclick="limpiar()">Agregar Usuario</button>
        </div>

        <div class="modal fade" id="modal_usuarios" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Usuarios</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_usuarios" method="post" class="form-group" id="form_cliente">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">ID:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="txt_usuario" class="form-label">Usuario:</label>
                                <input type="text" name="txt_usuario" id="txt_usuario" class="form-control" placeholder="Ingrese el usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_nombres" class="form-label">Nombre:</label>
                                <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ingrese el nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_apellidos" class="form-label">Apellido:</label>
                                <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ingrese el apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_ce" class="form-label">Correo Electrónico:</label>
                                <input type="email" name="txt_ce" id="txt_ce" class="form-control" placeholder="Ingrese el correo electrónico" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_contrasena" class="form-label">Contraseña:</label>
                                <input type="password" name="txt_contrasena" id="txt_contrasena" class="form-control" placeholder="Ingrese la contraseña">
                            </div>
                            <div class="mb-3">
                                <label for="drop_rol" class="form-label">Rol:</label>
                                <select name="drop_rol" id="drop_rol" class="form-select">
                                   <%
                                      Roles roles = new Roles();
                                      HashMap<String,String> drop = roles.drop_rol();
                                      for(String i: drop.keySet()){
                                        out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                      }
                                   %>
                                </select>
                            </div>
                            <div class="modal-footer mt-4">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Guardar</button>
                                <button type="submit" name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                                <button type="button" class="btn btn-danger" id="btn_eliminar" data-bs-toggle="modal" data-bs-target="#modalConfirmacion">Eliminar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-striped table-bordered mt-4">
            <thead class="table-header">
                <tr>
                    <th scope="col">Usuario</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Apellido</th>
                    <th scope="col">Correo Electrónico</th>
                    <th scope="col">Rol</th>
                </tr>
            </thead>
            <tbody id="tbl_usuarios">
                <%
                    Usuarios usuarios = new Usuarios();
                    DefaultTableModel tabla = usuarios.leer();
                    for (int t = 0; t < tabla.getRowCount(); t++) {
                        out.println("<tr data-id_usuarios='" + tabla.getValueAt(t, 0) + "' data-contrasena='" + tabla.getValueAt(t, 5) + "' data-id_rol='" + tabla.getValueAt(t, 6) + "'>");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>

        <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalConfirmacionLabel">Confirmar Eliminar</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ¿Está seguro de que desea eliminar este usuario?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" id="btnConfirmarEliminar">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/5hb7x1l5F3i5s0l4l7NME57K7lN5e5q5g5d6vA" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMN00AokAGBfS8f8k5PcUtx8RmgQ4Ly4Qo9VV7Si1LpD+plWTo+lFi4iA2cPw0J8" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGhv1BBm4rZr5f9EaZhl8y3tlF8ox8a4f4Y5WeUc0e6e/mGyf4gpPeUyG6g" crossorigin="anonymous"></script>

        <script type="text/javascript">
            function limpiar() {
                $("#txt_id").val(0);
                $("#txt_usuario").val('');
                $("#txt_nombres").val('');
                $("#txt_apellidos").val('');
                $("#txt_ce").val('');
                $("#txt_contrasena").val('');
                $("#drop_rol").val(1);
            }

            $(document).ready(function() {
                // Clic en el boton eliminar
                $("#btnConfirmarEliminar").on("click", function() {
                    $("#form_cliente").append('<input type="hidden" name="btn_eliminar" value="eliminar">');
                    $("#form_cliente").submit();
                });

                // Clic en una fila para editar
                $('#tbl_usuarios').on('click', 'tr', function() {
                    var target = $(this);
                    var id_usuarios = target.data('id_usuarios');
                    var usuario = target.find("td").eq(0).html();
                    var nombres = target.find("td").eq(1).html();
                    var apellidos = target.find("td").eq(2).html();
                    var correo_electronico = target.find("td").eq(3).html();
                    var id_rol = target.data('id_rol');
                    
                    $("#txt_id").val(id_usuarios);
                    $("#txt_usuario").val(usuario);
                    $("#txt_nombres").val(nombres);
                    $("#txt_apellidos").val(apellidos);
                    $("#txt_ce").val(correo_electronico);
                    $("#drop_rol").val(id_rol);
                    $("#modal_usuarios").modal('show');
                });
            });
        </script>
    </div>
</body>
</html>