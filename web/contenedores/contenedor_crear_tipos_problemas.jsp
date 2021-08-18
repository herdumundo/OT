 <%@page import="consultas_java.modelos"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="/chequearsesion.jsp" %>

  
 
<input type="button" style="font-weight: bold;color:black;" value="CREAR NUEVO TIPO DE PROBLEMA" class="form-control bg-danger color_letra" onclick="form_registrar_tipo_problema();"  >
   <input type="hidden" id="txt_areas_asignadas" >
   
   <div id="grilla">
     
    </div>
    
       