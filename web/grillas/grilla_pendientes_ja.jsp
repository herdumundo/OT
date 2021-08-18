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
    
 ResultSet rs = fuente.obtenerDato("select * from v_mae_ot_pedidos_generados where id_estado=1 and id_area in (select id_area from mae_ot_usuario a inner join mae_ot_det_areas b on a.id=b.id_usuario and a.id="+id_usuario+" )");
      
%>
<a>PENDIENTES DE JEFE DE AREA</a>

<table id="table_pendientes" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >NRO</th>   
      <th >CREADO POR</th>   
      <th >DESCRIPCION</th>   
      <th >AREA</th>   
      <th >DETALLE</th>   
      <th >MAQUINA</th>   
      <th >CATEGORIA</th>   
      <th >TIPO PROBLEMA</th>   
      <th >FECHA CREACION</th>   
      <th >TIPO DE PEDIDO</th>   
      <th >ESTADO PEDIDO</th>   
      <th >NOTAS</th>   
      <th >ACCION</th>   
      <th >ACCION</th>   
     </thead>
    <tbody>
        <%
        while(rs.next()){ %>  
        <tr>  
            <td><%=rs.getString("nro_pedido")%></td>
            <td><%=rs.getString("nombre_apellido")%></td>
            <td><%=rs.getString("descripcion")%></td>
            <td><%=rs.getString("desc_area")%></td>
            <td><%=rs.getString("detalle")%></td>
            <td><%=rs.getString("maquina")%></td>
            <td><%=rs.getString("subcategoria")%></td>
            <td><%=rs.getString("tipo_problema")%></td>
            <td><%=rs.getString("fecha_registro")%></td>  
             <td><%=rs.getString("tipo_pedido")%></td>
            <td><%=rs.getString("estado_pedido")%></td> 
            <td><textarea readonly  style="width:500px; height:100px" class="form - control"  > <%=rs.getString("notas_unificadas")%></textarea> </td> 
            <td><input  type="button" class="btn form-control bg-warning color_letra" value="CERRAR ORDEN" onclick="cancelar_ot('<%=rs.getString("nro_pedido")%>','1','grilla_pendientes_ja.jsp')"></td> 
            <td><input  type="button" class="btn form-control bg-success color_letra" value="APROBAR" onclick="aprobar_registro(<%=rs.getString("nro_pedido")%>)"></td> 
        </tr>
        <%}%>
    </tbody>
    
</table>
