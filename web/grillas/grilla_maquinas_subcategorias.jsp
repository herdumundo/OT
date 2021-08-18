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
    String id_maquina       = request.getParameter("id_maquina");
   // Connection cn = conexion.crearConexion();
    fuente.setConexion(clases.controles.connectSesion); 
    ResultSet rs,rs2,rs3;
    rs = fuente.obtenerDato("select * from v_mae_ot_maquinas_subcat where id_estado=7 and id_maquina="+id_maquina+"");
    int id=1;

         
   
%>
<table id="table_maquina_subcategoria" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <th >ID</th>   
        <th >MAQUINA</th>   
        <th >SUBCATEGORIA</th>   
        <th >AREA</th>   
        <th >ACCION</th>   
         
    </thead>
    <tbody>
        <%
        while(rs.next())
        {
          %> 
          <tr id="<%=rs.getString("id_detalle")%>">  
                <td><%=rs.getString("id_detalle")%></td>
                <td><%=rs.getString("descripcion")%></td>
                <td><%=rs.getString("subcategoria")%></td>
                <td><%=rs.getString("area")%></td>
                <td><input type="button" value="DESVINCULAR" class="form-control btn-danger color_letra" onclick="eliminar_vinculacion_subcategoria(<%=rs.getString("id_detalle")%>)"></td>
            
        <%}%>
    </tbody>
 </table>
 

    