<%@page import="modelo.Puesto" %>
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
        <h1 class="text-center">Puestos</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_puesto" onclick="limpiar()">Agregar Puesto</button>
        </div>
        <div class="modal fade" id="modal_puesto" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Puestos</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_puesto" method="post" id="form_puesto" class="form-group">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">ID:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>                 
                            </div>
                            <div class="mb-3">
                                <label for="txt_puesto" class="form-label">Puesto:</label>
                                <input type="text" name="txt_puesto" id="txt_puesto" class="form-control" placeholder="Ejemplo" required>
                            </div>
                            <div class="modal-footer mt-4">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Guardar</button>
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
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
                    <th scope="col">Puesto</th>
                </tr>
            </thead>
            <tbody id="tbl_puesto">
                <%
                    Puesto puesto = new Puesto();
                    DefaultTableModel tabla = new DefaultTableModel();
                    tabla = puesto.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_puesto=" + tabla.getValueAt(t, 0) + ">");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Confirmar eliminacion -->
    <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalConfirmacionLabel">Confirmar Eliminar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Está seguro de que desea eliminar este puesto?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" id="btnConfirmarEliminar">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function limpiar() {
            $("#txt_id").val('0');
            $("#txt_puesto").val('');
        }

        $(document).ready(function() {
            // Cuando el usuario haga clic en el botón de confirmar eliminación
            document.getElementById("btnConfirmarEliminar").addEventListener("click", function() {
                var form = document.getElementById("form_puesto");
                var inputEliminar = document.createElement("input");
                inputEliminar.setAttribute("type", "hidden");
                inputEliminar.setAttribute("name", "btn_eliminar");
                inputEliminar.setAttribute("value", "eliminar");
                form.appendChild(inputEliminar);
                form.submit();
                var modalEl = document.getElementById('modalConfirmacion');
                var modal = bootstrap.Modal.getInstance(modalEl);
                modal.hide();
            });

            // Cuando se haga clic en una fila de la tabla
            $('#tbl_puesto').on('click', 'tr', function() {
                var target = $(this);
                var id_puesto = target.data('id_puesto');
                var puesto = target.find("td").eq(0).html();

                $("#txt_puesto").val(puesto);
                $("#txt_id").val(id_puesto);
                $("#modal_puesto").modal('show');
            });
        });
    </script>
</body>
</html>