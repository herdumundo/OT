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
<%   
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
  
    ResultSet rs = fuente.obtenerDato("select * from mae_ot_areas where id_estado=7");

  
 
 
%>
<table id="table_areas" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >ID</th>   
      <th >AREA</th>   
      <th >ACCION</th>   
    </thead>
    <tbody>
        <%
        while(rs.next()){  %>  
        <tr>  
            <td><%=rs.getString("id")%></td>
            <td><%=rs.getString("descripcion")%></td>
            <td><input  type="button" class="btn form-control bg-danger color_letra" value="INACTIVAR" onclick="eliminar_area_rol('<%=rs.getString("id")%>','1','modal_add_area');" > </td>
        </tr>
        <%}%>
    </tbody>
 </table>
