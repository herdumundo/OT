<%-- 
    Document   : consulta_maquinas
    Created on : 06/04/2021, 04:59:22 PM
    Author     : hvelazquez
--%>

 <%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>

<%     
    //Connection clases.controles.connectSesion = conexion.crearConexion();
    controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
    ResultSet rs,rs2;
    rs2 = fuente.obtenerDato("select * from mae_ot_usuario where id_nivel=4 ");
        while(rs2.next())
        {
            html=html+"<OPTION  VALUE='"+ rs2.getString(1)+"'>"+ rs2.getString(7)+" "+ rs2.getString(8)+"</OPTION>";
        }
        ob.put("cbox_operarios",html);
        out.print(ob);  %>
 