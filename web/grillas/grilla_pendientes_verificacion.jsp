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
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    
 ResultSet rs = fuente.obtenerDato("SELECT * FROM v_mae_ot_pedidos_generados where id_estado=5 and id_usuario="+id_usuario+"");
      
%>
<table id="table_pendientes" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <th >CANCELAR</th>
        <th >ACCION</th>
        <th >NRO</th>   
        <th >CREADO POR</th>   
        <th >DESCRIPCION</th>   
        <th >RESOLUCION</th>   
        <th >AREA</th>   
        <th >DETALLE</th>   
        <th >MAQUINA</th>   
        <th >CATEGORIA</th>   
        <th >TIPO PROBLEMA</th>   
        <th >FECHA CREACION</th>   
        <th >TIPO DE PEDIDO</th>   
        <th >ESTADO PEDIDO</th>   
        <th >NOTA</th>   
    </thead>
    <tbody>
        <%
        while(rs.next()){ %>  
        <tr>
            <td><input  type="button" class="btn form-control bg-warning color_letra" value="CANCELAR" onclick="cancelar_ot('<%=rs.getString("nro_pedido")%>','3','grilla_pendientes_verificacion.jsp')"></td> 
            <td><input  type="button" class="btn form-control bg-success color_letra" value="APROBAR VERIFICACION " onclick="form_registrar_verificacion(<%=rs.getString("nro_pedido")%>);"></td> 
            <td><%=rs.getString("nro_pedido")%></td>
            <td><%=rs.getString("nombre_apellido")%></td>
            <td><%=rs.getString("descripcion")%></td>
            <td><%=rs.getString("resolucion")%></td>
            <td><%=rs.getString("desc_area")%></td>
            <td><%=rs.getString("detalle")%></td>
            <td><%=rs.getString("maquina")%></td>
            <td><%=rs.getString("subcategoria")%></td>
            <td><%=rs.getString("tipo_problema")%></td>
            <td><%=rs.getString("fecha_registro")%></td>  
            <td><%=rs.getString("tipo_pedido")%></td>
            <td><%=rs.getString("estado_pedido")%></td> 
            <td><textarea readonly  style="width:500px; height:100px" class="form - control"  > <%=rs.getString("notas_unificadas")%></textarea> </td> 
                </tr>
        <%}%>
    </tbody>
    
</table>
