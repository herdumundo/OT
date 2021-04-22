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
  
    ResultSet rs = fuente.obtenerDato("select a.id,a.descripcion,id_estado,b.descripcion as estado "
            + "from "
            + "mae_ot_subcategorias a inner join mae_ot_estados b on a.id_estado=b.id where a.id_estado=7 ");

  
 
 
%>
<table id="table_subcat" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >ID</th>   
      <th >COMPONENTES MAQUINA</th>   
       <th >ACCION</th>   
       <th >ACCION</th>   
    </thead>
    <tbody>
        <%
        while(rs.next()){  %>  
        <tr id="<%=rs.getString("id")%>">  
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><input type="button" value="ELIMINAR" class="form-control btn-danger color_letra" onclick="eliminar_subcategoria(<%=rs.getString("id")%>)"></td>
            <td><input type="button" value="EDITAR" class="form-control btn-warning color_letra" onclick="editar_maquinas_submaq(<%=rs.getString("id")%>,'<%=rs.getString("descripcion")%>','modal_submaq','mae_ot_update_subcategorias','6')"></td>
          </tr>
        <%}%>
    </tbody>
 </table>
