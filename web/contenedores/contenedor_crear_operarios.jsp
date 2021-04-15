 <%@page import="consultas_java.modelos"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="/chequearsesion.jsp" %>

  
 
   <input type="button" value="CREAR NUEVO OPERARIO" class="form-control bg-danger color_letra" data-toggle="modal"   data-target="#modal_add_operarios"  >
   <input type="hidden" id="txt_areas_asignadas" >
   
   <div id="grilla_operarios">
     
    </div>
   
    <form id="form_add_operario" action="post">
 
    <div class="modal fade" id="modal_add_operarios" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">REGISTRO DE NUEVO OPERARIO</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <a>NOMBRE</a>
            <input type="text" placeholder="INGRESE NOMBRE"  autocomplete="off"     name="nombre" id="nombre" required>            
            <a>APELLIDO</a>
            <input type="text" placeholder="INGRESE APELLIDO"  autocomplete="off"   name="apellido" id="apellido" required>            
              
            <div id="div_areas">
            
            </div>
          </div>
          <div class="modal-footer">
              <input type="submit" class="form-control btn btn-success"  id="btn_add_usuario" value="REGISTRAR" >
            <br>
        <button class="form-control btn btn-secondary" type="button" data-dismiss="modal">CANCELAR</button> 

          </div>
        </div>
      </div>
    </div></form>
            
            
            
    <form id="form_upd_operario" action="post">
 
    <div class="modal fade" id="modal_upd_operario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">EDITAR OPERARIO</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
            <div class="modal-body">                
                <input type="hidden" id="txt_id_operario" name="txt_id_operario"      required class="form-control">

                
                <a>NOMBRE</a><br>
                <input type="text" id="txt_nombre"  name="txt_nombre"placeholder="INGRESE NOMBRE"     required class="form-control">
                <a>APELLIDO</a><br>
                <input type="text" id="txt_apellido"  name="txt_apellido"placeholder="INGRESE APELLIDO"     required class="form-control">
                 
            </div>
          
          <div class="modal-footer">
              <input type="submit" class="form-control btn btn-success"  id="btn_add_usuario" value="EDITAR" >
            <br>
        <button class="form-control btn btn-secondary" type="button" data-dismiss="modal">CANCELAR</button> 
        </div>
         </div>
      </div>
    </div></form> 
            
       