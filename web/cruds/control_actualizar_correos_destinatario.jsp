<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
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

    String id_usuario       = request.getParameter("id_usuario");
    String arr_id_usuario_envio            = request.getParameter("arr_id_usuario_envio");
    String id_nivel            = request.getParameter("id_nivel");
  
    String mensaje="";
    int tipo_respuesta=0;    try 
    {
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
                callableStatement = clases.controles.connectSesion.prepareCall("{call  mae_ot_update_correos_destinatarios (?,?,?,?,?)}");
                callableStatement .setInt(1,  Integer.parseInt(id_usuario) );
                callableStatement .setInt(2,  Integer.parseInt(id_nivel) );
                callableStatement .setString(3,   arr_id_usuario_envio   );
                 
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
                    //  cn.rollback(); 
                   clases.controles.connectSesion.commit();
                }    
                ob.put("mensaje", mensaje);
                ob.put("tipo_respuesta", tipo_respuesta);
           
         } catch (Exception e) 
            {           
                ob.put("mensaje", e.toString());
                ob.put("tipo_respuesta", "0");
            }
            out.print(ob); %>