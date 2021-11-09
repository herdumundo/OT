<%-- 
    Document   : consulta_maquinas
    Created on : 06/04/2021, 04:59:22 PM
    Author     : hvelazquez
--%>

 <%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>

<%     
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String fecha="";
    ResultSet rs;
     rs = fuente.obtenerDato("  select  convert(varchar,getdate(),103) as fecha  ");
       while(rs.next())
        {
           fecha=rs.getString("fecha");
        }
        ob.put("fecha",fecha);
        out.print(ob);  %>
 