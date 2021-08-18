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
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    
 ResultSet rs = fuente.obtenerDato("select * from v_mae_ot_pedidos_generados where id_usuario='"+id_usuario+"'");
      
%>
<a>PENDIENTES PEDIDOS GENERADOS</a>

<table id="table_generados" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >Nro</th>   
      <th >Descripcion</th>   
      <th >Detalle</th>   
      <th >Maquina</th>   
      <th >Categoria</th>   
      <th >Tipo problema</th>   
      <th >Fecha registro</th>   
      <th >Tercerizado</th>   
      <th >Tipo de pedido</th>   
      <th >Notas</th>   
      <th >Estado del pedido</th>   
     </thead>
    <tbody>
        <%
        while(rs.next()){ %>  
        <tr>  
            <td><%=rs.getString("nro_pedido")%></td>
            <td><%=rs.getString("descripcion")%></td>
            <td><%=rs.getString("detalle")%></td>
            <td><%=rs.getString("maquina")%></td>
            <td><%=rs.getString("subcategoria")%></td>
            <td><%=rs.getString("tipo_problema")%></td>
            <td><%=rs.getString("fecha_registro")%></td>  
            <td><%=rs.getString("tercerizado")%></td>
            <td><%=rs.getString("tipo_pedido")%></td>
            <td><textarea readonly  style="width:500px; height:75px" class="form - control"  > <%=rs.getString("notas_unificadas")%></textarea> </td> 
            <td><%=rs.getString("estado_pedido")%></td>
        </tr>
        <%}%>
    </tbody>
    
</table>
