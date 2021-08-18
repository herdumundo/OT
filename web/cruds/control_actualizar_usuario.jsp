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

    String id           = request.getParameter("txt_id_usuario");
    String nombre       = request.getParameter("txt_nombre");
    String apellido     = request.getParameter("txt_apellido");
    String txt_usuario  = request.getParameter("txt_usuario");
    String txt_correo   = request.getParameter("txt_correo");
    String mensaje      ="";
    String areas        ="";
    int tipo_respuesta=0;    
    try 
    { 
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
                callableStatement = clases.controles.connectSesion.prepareCall("{call [mae_ot_update_usuarios](?,?,?,?,?,?,?)}");
                callableStatement .setInt(1,    Integer.parseInt(id) );
                callableStatement .setString(2,   nombre);
                callableStatement .setString(3,   apellido);
                callableStatement .setString(4,  txt_usuario);
                callableStatement .setString(5, txt_correo);
               
        
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
                    consultas_java.modelos.cargar_usuarios_correos();
                }    
                ob.put("mensaje", mensaje);
                ob.put("tipo_respuesta", tipo_respuesta);
           
         } catch (Exception e) 
            {           
                ob.put("mensaje", e.toString());
                ob.put("tipo_respuesta", "0");
            }
            out.print(ob); %>