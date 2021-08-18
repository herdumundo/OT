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
<%  try {  
    //Connection cn = conexion.crearConexion();
    fuente.setConexion(clases.controles.connectSesion);
   
    ResultSet rs = fuente.obtenerDato("select  * from mae_ot_tercerizados  ");
    int id=1;

         
     
%>
<table id="table_proveedores" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <th>PROVEEDOR</th>   
        <th >DIRECCION</th>   
        <th >CIUDAD</th>   
        <th >ESTADO</th>   
        <th >EDITAR</th>   
       
     </thead>
    <tbody>
        <%
        while(rs.next()){
            id++; %>  
        <tr>  
            <td><%=rs.getString("cardname")%></td>
            <td><%=rs.getString("address")%></td>
            <td><%=rs.getString("city")%></td>
            <td><select id="estado<%=id%>"  class="form-control" onchange="actualizar_estado_proveedor('<%=rs.getString("id")%>',$('#estado<%=id%>').val());"> <option value="7">ACTIVO</option><option value="8">INACTIVO</option></select></td>
             <td><input  type="button" class="btn form-control bg-warning color_letra" value="EDITAR DATOS"  data-toggle="modal" data-target="#modal_upd_proveedor"  onclick="$('#txt_id_proveedor').val('<%=rs.getString("id")%>');$('#txt_nombre').val('<%=rs.getString("cardname")%>');$('#txt_direccion').val('<%=rs.getString("address")%>');$('#txt_ciudad').val('<%=rs.getString("city")%>');" > </td>
        </tr>
    <script>
         $("#estado"+<%=id%>).val('<%=rs.getString("id_estado")%>');
     </script><%
        
        

        
        }%>
    </tbody>
 </table>
    <%} 
catch (Exception e) {
String sa=e.toString();
     }%>

    