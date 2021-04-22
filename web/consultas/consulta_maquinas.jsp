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
    String id_area = request.getParameter("id_area");
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
    ResultSet rs,rs2;
     rs2 = fuente.obtenerDato(" select * from mae_ot_maquinas"
             + "                where  id_area='"+id_area+"' and id_estado=7");
       while(rs2.next())
        {
            html=html+"<OPTION  VALUE='"+ rs2.getString(3)+"'>"+ rs2.getString(2)+"</OPTION>";
        }
        ob.put("cbox_maquina","<OPTION value='' disabled selected='selected'>SELECCIONE MAQUINA</OPTION>"+html);
        out.print(ob);  %>
 