<%@page import="modelo.Productos" %>
<%@page import="modelo.Marcas" %>
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
        .img-thumbnail {
            cursor: pointer;
            transition: transform 0.2s;
        }
        .img-thumbnail:hover {
            transform: scale(1.05);
        }
        .modal-img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Productos</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_productos" onclick="limpiar()">Agregar Producto</button>
        </div>

        <div class="modal fade" id="modal_productos" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Productos</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_productos" method="post" enctype="multipart/form-data" class="form-group" id="form_producto">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">ID:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="txt_producto" class="form-label">Producto:</label>
                                <input type="text" name="txt_producto" id="txt_producto" class="form-control" placeholder="Ingrese el producto" required>
                            </div>
                            <div class="mb-3">
                                <label for="drop_marca" class="form-label">Marca:</label>
                                <select name="drop_marca" id="drop_marca" class="form-select">
                                   <%
                                      Marcas marcas = new Marcas();
                                      HashMap<String,String> drop = marcas.drop_marcas();
                                      for(String i: drop.keySet()){
                                        out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                      }
                                   %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="txt_descripcion" class="form-label">Descripción:</label>
                                <input type="text" name="txt_descripcion" id="txt_descripcion" class="form-control" placeholder="Ingrese la descripción" required>
                            </div>
                            <div class="mb-3">
                                <label for="file_imagen" class="form-label">Imagen:</label>
                                <input type="file" name="file_imagen" id="file_imagen" class="form-control" accept="image/*" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_precio" class="form-label">Precio Costo:</label>
                                <input type="number" name="txt_precio" id="txt_precio" class="form-control" placeholder="Ingrese el precio de costo" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_precio_v" class="form-label">Precio Venta:</label>
                                <input type="number" name="txt_precio_v" id="txt_precio_v" class="form-control" placeholder="Ingrese el precio de venta" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_existencia" class="form-label">Existencia:</label>
                                <input type="number" name="txt_existencia" id="txt_existencia" class="form-control" placeholder="Ingrese la existencia" required>
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
                    <th scope="col">Producto</th>
                    <th scope="col">Marca</th>
                    <th scope="col">Descripción</th>
                    <th scope="col">Imagen</th>
                    <th scope="col">Precio Costo</th>
                    <th scope="col">Precio Venta</th>
                    <th scope="col">Existencia</th>
                </tr>
            </thead>
            <tbody id="tbl_productos">
                <%
                    Productos productos = new Productos();
                    DefaultTableModel tabla = productos.leer();
                    for (int t = 0; t < tabla.getRowCount(); t++) {
                        out.println("<tr data-id_producto='" + tabla.getValueAt(t, 0) + "' data-id_marca='" + tabla.getValueAt(t, 2) + "' data-fecha_ingreso='" + tabla.getValueAt(t, 9) + "'>");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                        out.println("<td><img src='" + tabla.getValueAt(t, 5) + "' alt='Producto' class='img-thumbnail' width='100' height='100' data-bs-toggle='modal' data-bs-target='#modalImagen' data-src='" + tabla.getValueAt(t, 5) + "'></td>");
                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
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
                        ¿Está seguro de que desea eliminar este producto?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" id="btnConfirmarEliminar">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="modalImagen" tabindex="-1" aria-labelledby="modalImagenLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalImagenLabel">Visualización de Imagen</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="imagenAmpliada" src="" alt="Producto" class="modal-img">
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
                $("#txt_producto").val('');
                $("#drop_marca").val(1);
                $("#txt_descripcion").val('');
                $("#file_imagen").val('');
                $("#txt_precio").val('');
                $("#txt_precio_v").val('');
                $("#txt_existencia").val('');
            }

            $(document).ready(function() {
                // Clic en el boton eliminar
                $("#btnConfirmarEliminar").on("click", function() {
                    $("#form_producto").append('<input type="hidden" name="btn_eliminar" value="eliminar">');
                    $("#form_producto").submit();
                });

                // Clic en una fila para editar
                $('#tbl_productos').on('click', 'tr', function() {
                    var target = $(this);
                    var id_producto = target.data('id_producto');
                    var producto = target.find("td").eq(0).html();
                    var id_marca = target.data('id_marca');
                    var descripcion = target.find("td").eq(2).html();
                    var precio_costo = target.find("td").eq(4).html();
                    var precio_venta = target.find("td").eq(5).html();
                    var existencia = target.find("td").eq(6).html();
                    
                    $("#txt_id").val(id_producto);
                    $("#txt_producto").val(producto);
                    $("#drop_marca").val(id_marca);
                    $("#txt_descripcion").val(descripcion);
                    $("#txt_precio").val(precio_costo);
                    $("#txt_precio_v").val(precio_venta);
                    $("#txt_existencia").val(existencia);
                    $("#modal_productos").modal('show');
                });
                
                // Clic en la imagen para ampliarla
                $('#tbl_productos').on('click', '.img-thumbnail', function() {
                    var imgSrc = $(this).data('src');
                    $('#imagenAmpliada').attr('src', imgSrc);
                    $('#modalImagen').modal('show');
                });
            });
        </script>
    </div>
</body>
</html>