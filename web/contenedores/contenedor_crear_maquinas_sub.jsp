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
   %>
    <input type="button" value="CREAR MAQUINA"   href="#modalx-flipOut" class=" modalx-flipOut_open form-control bg-success color_letra"  onclick="ir_grilla_maquinas();">
    <input type="button" value="CREAR PARTES DE LA MAQUINA"  href="#modal_submaq" class="modal_submaq_open form-control bg-success color_letra"   onclick="ir_grilla_subcategoria();">
    <input type="button" value="ASOCIAR MAQUINAS Y PARTES"  href="#modal_vinculacion" class="modal_vinculacion_open form-control bg-dark color_letra"  onclick="cargar_subcat();" >
    <input type="hidden" id="txt_areas_asignadas" >
 
    
             
    <div id="modalx-flipOut" class="body-modalx">
        <h3 class="text-center"><i class="fa fa-cube"></i><br><span class="txt-destaque1" id="div_titulo">REGISTRO DE NUEVA MAQUINA</span><hr></h3>
            <p class="txt-modalx"> </p>
                <form id="form_add_maquina" action="post">
                    <div class="modal-body">
                        <a>NOMBRE</a>
                        <input type="text" placeholder="INGRESE NOMBRE DE LA MAQUINA"  autocomplete="off"     name="maquina" id="maquina" required>            
                        <input type="hidden"    name="ids_areas" id="ids_areas"  >            
                        <div id="div_areas">
                            <a>ASIGNACION DE AREAS</a>
                            <select class="form-control  " title="SELECCIONE AREA" id="select_areas" data-style="btn-dark" name="select_areas" required  multiple data-live-search="true">
                                <%out.println(modelos.cargar_areas());%>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="form-control btn btn-success"  id="btn_add_usuario" value="REGISTRAR" >
                        <br>
                        <button class="modalx-flipOut_close  pull-right form-control btn btn-secondary" type="button"  >CANCELAR</button> 
                    </div>
                
                </form>
                   <div id="div_grilla_maquina"></div>
                <br>
		<button class="modalx-flipOut_close btn-close-modalx pull-right">CERRAR&nbsp;<i class="fa fa-times-circle"></i>
		</button>
		<br>
		<br>
		<br>
	</div>
                
                
     
        <div id="modal_submaq" class="body-modalx">
            <h3 class="text-center"><i class="fa fa-cube"></i><br><span class="txt-destaque1" id="div_titulo">REGISTRO DE NUEVA SUBCATEGORIA</span><hr></h3>
		<p class="txt-modalx"> </p>
                    <form id="form_add_subcat" action="post">   
                        <div class="modal-body">                
                             <a>NOMBRE</a>
                                <input type="text" placeholder="INGRESE NOMBRE DE LA SUBCATEGORIA"  autocomplete="off"     name="subcat" id="subcat" required>            
                        </div>
                <div class="modal-footer">
                  <input type="submit" class="form-control btn btn-success"    value="REGISTRAR" >
                <br>
                <button class="modal_submaq_close  pull-right form-control btn btn-secondary" type="button"  >CANCELAR</button> 
                </div>
                <div id="div_grilla_subcat"></div>
                
                    </form> 
                <br>
		<button class="modal_submaq_close btn-close-modalx pull-right">CERRAR&nbsp;<i class="fa fa-times-circle"></i>
		</button>
		<br>
		<br>
		<br>
	</div>
           
                            
        <div id="modal_vinculacion" class="body-modalx">
            <h3 class="text-center"><i class="fa fa-cube"></i><br><span class="txt-destaque1"  > VINCULACION DE MAQUINAS Y PARTES DE MAQUINAS</span><hr></h3>
		<p class="txt-modalx"> </p>
                    <form id="form_add_vinculacion" action="post">   
                        <div class="modal-body">  
                            <input type="hidden" id="id_vinculaciones_subcat" name="id_vinculaciones_subcat">
                             <a>AREA</a>
                             <select class="form-control  " title="SELECCIONE AREA" id="cbox_origen" data-style="btn-dark" name="cbox_origen" required  onchange="filtro_maquina();" >
                                 <option value="" disabled selected>  SELECCIONE AREA</option>
                                    <%out.println(modelos.cargar_areas());%>                            
                            </select>
                            <a>MAQUINAS</a>
                            <select class="form-control  " title="SELECCIONE MAQUINA" id="cbox_maquina" data-style="btn-dark" name="cbox_maquina" required  data-live-search="true" onchange="ir_grilla_maquina_subcategoria($('#cbox_maquina').val())"  >
                            
                            </select>
                            
                             <a>PARTES</a>
                            <select class="form-control  " title="SELECCIONE PARTES DE LA MAQUINA" id="select_submaq_vinc" data-style="btn-dark" name="select_submaq_vinc" required  multiple data-live-search="true">
                            
                            </select>      
                        </div>
                        <div class="modal-footer">
                          <input type="submit" class="form-control btn btn-success"    value="REGISTRAR" >
                            <br>
                            <button class="modal_vinculacion_close  pull-right form-control btn btn-secondary" type="button"  >CANCELAR</button> 
                        </div>
                            <div id="grilla_maquinas_subcategorias">

                            </div>

                    </form> 
                    <br>
                    <button class="modal_vinculacion_close btn-close-modalx pull-right">CERRAR&nbsp;<i class="fa fa-times-circle"></i>
                    </button>
                    <br>
                    <br>
                    <br>
        </div>