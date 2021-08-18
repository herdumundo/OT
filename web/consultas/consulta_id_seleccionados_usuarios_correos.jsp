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
    String id_usuario = request.getParameter("id_usuario");
    String id_nivel = request.getParameter("id_nivel");
    //Connection clases.controles.connectSesion = conexion.crearConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
    ResultSet rs3;
    rs3=fuente.obtenerDato("SELECT   stuff(( select ','+  CONVERT(VARCHAR,id_usuario_envio_correo)   "
             + "from mae_ot_correos_envio with (nolock) where id_usuario = "+id_usuario+" and id_nivel="+id_nivel+"  for XML path('') ),1,1,'')as id_usuario");
            
            while(rs3.next())
            {
            
             html=rs3.getString(1);
            }
            if(html==null){
                html="0";
            }
        ob.put("cbox_seleccionados",html);
        out.print(ob);  %>
 