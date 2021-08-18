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
    //Connection cn = conexion.crearConexion();
    fuente.setConexion(clases.controles.connectSesion);
  
    ResultSet rs = fuente.obtenerDato(" select * from v_mae_ot_maquinas where id_estado=7");

  
 
 
%>
<table id="table_maquinas" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >ID</th>   
      <th >MAQUINA</th>   
      <th >AREA</th>   
      <th >ACCION</th>   
      <th >ACCION</th>   
    </thead>
    <tbody>
        <%
        while(rs.next()){  %>  
        <tr id="<%=rs.getString("id_maquina")%>">  
            <td><%=rs.getString("id_maquina")%></td>
            <td><%=rs.getString("descripcion")%></td>
            <td><%=rs.getString("area")%></td>
            <td><input type="button" value="ELIMINAR" class="form-control btn-danger color_letra" onclick="eliminar_maquina(<%=rs.getString("id_maquina")%>)"></td>
            <td><input type="button" value="EDITAR" class="form-control btn-warning color_letra" onclick="editar_maquinas_submaq(<%=rs.getString("id_maquina")%>,'<%=rs.getString("descripcion")%>','modalx-flipOut' ,'mae_ot_update_maquinas','5')"></td>
         </tr>
        <%}%>
    </tbody>
 </table>
