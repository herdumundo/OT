 <%@page import="consultas_java.modelos"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="/chequearsesion.jsp" %>

 <%Connection cn = conexion.crearConexion();
    fuente.setConexion(cn); 
      String combo_nivel = (String) sesionOk.getAttribute("combo_nivel");
      String combo_areas = (String) sesionOk.getAttribute("combo_areas");
      modelos.cargar_roles();
   %>
 
   <input type="button" value="CREAR USUARIO" class="form-control bg-success" data-toggle="modal" id="btn_agregar_usuario" data-target="#modal_add_usuarios"  onclick="limpiar_modal_add_usuarios();">
   <input type="hidden" id="txt_areas_asignadas" >
   
   <div id="grilla_usuarios">
     
    </div>
   
    <form id="form_add_user" action="post">
 
    <div class="modal fade" id="modal_add_usuarios" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">REGISTRO DE NUEVO USUARIO</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <a>NOMBRE</a>
            <input type="text" placeholder="INGRESE NOMBRE"  autocomplete="off"     name="nombre" id="nombre" required>            
            <a>APELLIDO</a>
            <input type="text" placeholder="INGRESE APELLIDO"  autocomplete="off"   name="apellido" id="apellido" required>            
             
            <a>USUARIO</a>
            <input type="text" placeholder="INGRESE USUARIO DE INICIO DE SESION"    name="usuario" id="usuario"  autocomplete="off"  required>
            <a>CONTRASEÑA</a>
            <input type="text" placeholder="INGRESE CONTRASEÑA " id="pass" name="pass" autocomplete="off"  required >
            <a>CORREO ELECTRONICO</a>
            <input type="email" placeholder="INGRESE CORREO " id="correo" name="correo" autocomplete="off"    >
            <a>NIVEL</a>
            <select class="form-control" id="select_nivel_usuario" name="select_nivel_usuario" >
                  <%=combo_nivel%>
            </select>
            <a>TIPO DE ACCESO AL SISTEMA(ROL)</a>
            <select class="form-control" id="select_rol" name="select_rol" >
                <%=consultas_java.modelos.combo_roles%>
            </select>
            <div id="div_areas">
            <a>ASIGNACION DE AREAS</a>
            <select class="form-control selectpicker" title="SELECCIONE AREA" id="select_areas" data-style="btn-dark" name="select_areas" required  multiple data-live-search="true">
                <%=combo_areas%>
            </select>
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
            
            
            
    <form id="form_upd_user" action="post">
 
    <div class="modal fade" id="modal_upd_user" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">EDITAR USUARIO</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
            <div class="modal-body">                
                <input type="hidden" id="txt_id_usuario" name="txt_id_usuario"  placeholder="INGRESE NOMBRE"     required class="form-control">

                
                <a>NOMBRE</a><br>
                <input type="text" id="txt_nombre"  name="txt_nombre"placeholder="INGRESE NOMBRE"     required class="form-control">
                <a>APELLIDO</a><br>
                <input type="text" id="txt_apellido"  name="txt_apellido"placeholder="INGRESE APELLIDO"     required class="form-control">
                <br>
                <a>USUARIO</a>
                <input type="text" id="txt_usuario" name="txt_usuario"placeholder="INGRESE USUARIO"   required class="form-control">
                <a>CORREO</a>
                <input type="email" id="txt_correo"  name="txt_correo" placeholder="INGRESE CORREO ELECTRONICO"      class="form-control">
                
            </div>
          
          <div class="modal-footer">
              <input type="submit" class="form-control btn btn-success"  id="btn_add_usuario" value="EDITAR" >
            <br>
        <button class="form-control btn btn-secondary" type="button" data-dismiss="modal">CANCELAR</button> 
        </div>
         </div>
      </div>
    </div></form> 
            
       