<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.CallableStatement"%>
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

    String id_usuario   = (String) sesionOk.getAttribute("id_usuario");
    String clave       = request.getParameter("pass");
   
    if(clave.equals("123")){
         response.sendRedirect("../login_cambio_pass.jsp");
    }
    else {
         MessageDigest m = MessageDigest.getInstance("MD5");
    m.reset();
    m.update(clave.getBytes());
    byte[] digest = m.digest();
    BigInteger bigInt = new BigInteger(1,digest);
    String clavehASH = bigInt.toString(16);

  
    
    
    String mensaje="";
    int tipo_respuesta=0;    
    try 
    {
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
                callableStatement = clases.controles.connectSesion.prepareCall("{call  mae_ot_cambiar_pass (?,?,?,? )}");
                callableStatement .setInt(1,  Integer.parseInt(id_usuario) );
                callableStatement .setString(2,  clavehASH );
                  
                callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
                callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
                callableStatement.execute(); 
                tipo_respuesta = callableStatement.getInt("estado_registro");
                mensaje= callableStatement.getString("mensaje");
                if (tipo_respuesta==0)
                {
                    clases.controles.connectSesion.rollback(); 
                }   
                else  
                {
                     //clases.controles.connectSesion.rollback(); 
                    clases.controles.connectSesion.commit();
                }    
                 response.sendRedirect("../index.html");
         } catch (Exception e) 
            {           
                ob.put("mensaje", e.toString());
                ob.put("tipo_respuesta", "0");
            } 
    }
    
   %>