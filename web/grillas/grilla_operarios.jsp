<%-- 
    Document   : grilla_pedidos_generados
    Created on : 07/04/2021, 04:26:35 PM
    Author     : hvelazquez
--%>
<%@include  file="../chequearsesion.jsp" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  try 
{  
   // Connection cn = conexion.crearConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    String combo_nivel = (String) sesionOk.getAttribute("combo_nivel");
    String combo_areas = (String) sesionOk.getAttribute("combo_areas");    
    ResultSet rs = fuente.obtenerDato("select a.id as id_operario, concat(nombre,' ',apellido) as nombre_apellido,nombre,apellido,id_estado,descripcion "
            + "from mae_ot_operarios a inner join mae_ot_estados b on a.id_estado=b.id");
    int id=1;

         
     
%>
<table id="table_operarios" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >NOMBRE</th>   
      <th >ESTADO</th>   
        <th >EDITAR</th>   
       
     </thead>
    <tbody>
        <%
        while(rs.next()){
            id++; %>  
        <tr>  
            <td><%=rs.getString("nombre_apellido")%></td>
             <td><select id="estado<%=id%>"  class="form-control" onchange="actualizar_estado_operario('<%=rs.getString("id_operario")%>',$('#estado'+<%=id%>).val());"  > <option value="7">ACTIVO</option><option value="8">INACTIVO</option></select></td>
             <td><input  type="button" class="btn form-control bg-warning color_letra" value="EDITAR DATOS" data-toggle="modal" data-target="#modal_upd_operario" onclick="$('#txt_id_operario').val('<%=rs.getString("id_operario")%>');$('#txt_nombre').val('<%=rs.getString("nombre")%>');$('#txt_apellido').val('<%=rs.getString("apellido")%>')"> </td>
             
        </tr>
    <script>
         $("#estado<%=id%>").val('<%=rs.getString("id_estado")%>');
     </script><%
        
        

        
        }%>
    </tbody>
 </table>
    <%} 
catch (Exception e) {
String sa=e.toString();
     }%>

    