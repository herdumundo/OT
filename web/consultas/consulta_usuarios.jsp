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
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>

<%     
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
    ResultSet rs2;
    rs2 = fuente.obtenerDato("select * from  v_mae_ot_usuarios where correo <> '' ");
        while(rs2.next())
        {
            html=html+"<OPTION  VALUE='"+ rs2.getString(1)+"'>"+ rs2.getString(6)+"</OPTION>";
        }
    ob.put("cbox_usuario",html);
    out.print(ob);  %>
 