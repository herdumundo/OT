 <%@page import="consultas_java.modelos"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="/chequearsesion.jsp" %>

  <input type="button" value="CREAR NUEVO PROVEEDOR TERCERIZADO" class="form-control bg-warning color_letra" data-toggle="modal" id="btn_agregar" data-target="#modal_add_proveedor"  >
   <input type="hidden" id="txt_areas_asignadas" >
   
   <div id="grilla_proveedores">
     
    </div>
   
    <form id="form_add_proveedor" action="post">
 
    <div class="modal fade" id="modal_add_proveedor" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">REGISTRO DE NUEVO PROVEEDOR</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <a>NOMBRE</a>
            <input type="text" placeholder="INGRESE NOMBRE"  autocomplete="off"     name="nombre" id="nombre" required>            
            <a>DIRECCION</a>
            <input type="text" placeholder="INGRESE DIRECCION"  autocomplete="off"   name="direccion" id="direccion" required>            
          
            <a>CIUDAD</a>
            
            <input type="text" placeholder="INGRESE CIUDAD"  autocomplete="off"   name="ciudad" id="ciudad" required>            
          
           
          </div>
          <div class="modal-footer">
              <input type="submit" class="form-control btn btn-success"  id="btn_add_usuario" value="REGISTRAR" >
            <br>
        <button class="form-control btn btn-secondary" type="button" data-dismiss="modal">CANCELAR</button> 

          </div>
        </div>
      </div>
    </div></form>
            
            
            
    <form id="form_upd_proveedor" action="post">
 
    <div class="modal fade" id="modal_upd_proveedor" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">EDITAR OPERARIO</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
            <div class="modal-body">                
                <input type="hidden" id="txt_id_proveedor" name="txt_id_proveedor"      required class="form-control">
            <a>NOMBRE</a>
            <input type="text" placeholder="INGRESE NOMBRE"  autocomplete="off"     name="txt_nombre" id="txt_nombre" required>            
            <a>DIRECCION</a>
            <input type="text" placeholder="INGRESE DIRECCION"  autocomplete="off"   name="txt_direccion" id="txt_direccion" required>            
          
            <a>CIUDAD</a>
            <input type="text" placeholder="INGRESE CIUDAD"  autocomplete="off"   name="txt_ciudad" id="txt_ciudad" required>            
            </div>
          
          <div class="modal-footer">
              <input type="submit" class="form-control btn btn-success"  id="btn_add_usuario" value="EDITAR" >
            <br>
        <button class="form-control btn btn-secondary" type="button" data-dismiss="modal">CANCELAR</button> 
        </div>
         </div>
      </div>
    </div></form> 
            
 