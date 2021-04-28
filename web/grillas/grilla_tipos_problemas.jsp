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
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
   // String combo_nivel = (String) sesionOk.getAttribute("combo_nivel");
    //String combo_areas = (String) sesionOk.getAttribute("combo_areas"); 
    ResultSet rs,rs2,rs3;
    rs = fuente.obtenerDato("select * from mae_ot_tipo_problema where id_estado=7");
    int id=1;

         
   
%>
<table id="table_tipo_problema" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <th >ID</th>   
        <th >DESCRIPCION</th>   
         
        <th >EDITAR</th>   
        <th >INACTIVAR</th>   
    </thead>
    <tbody>
        <%
        while(rs.next())
        {
            %>
            <tr>  
                <td><%=rs.getString("id")%></td>
                <td><%=rs.getString("descripcion")%></td>
                <td><input  type="button"   class="btn form-control bg-warning color_letra" value="EDITAR DATOS" onclick="editar_tipo_problema('<%=rs.getString("id")%>','<%=rs.getString("descripcion")%>')"  > </td>
                <td><input  type="button"   class="btn form-control bg-dark color_letra" value="ELIMINAR"    onclick="eliminar_tipo_problema('<%=rs.getString("id")%>')"  > </td>

            </tr>
           
                  
       <% }%>
    </tbody>
 </table>
    <%} 
catch (Exception e) {
String sa=e.toString();
     }%>

    