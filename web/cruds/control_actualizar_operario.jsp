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
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();

    String id           = request.getParameter("txt_id_operario");
    String nombre     = request.getParameter("txt_nombre");
    String apellido     = request.getParameter("txt_apellido");
       
    String mensaje="";
    String areas="";
    int tipo_respuesta=0;    
    try 
    { 
        cn.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
                callableStatement = cn.prepareCall("{call [mae_ot_update_operarios](?,?,?,?,?)}");
                callableStatement .setInt(1,    Integer.parseInt(id) );
                callableStatement .setString(2,   nombre);
                callableStatement .setString(3,   apellido); 
        
                callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
                callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
                callableStatement.execute(); 
                tipo_respuesta = callableStatement.getInt("estado_registro");
                mensaje= callableStatement.getString("mensaje");
                if (tipo_respuesta==0)
                {
                    cn.rollback(); 
                }   
                else  
                {
                     //cn.rollback(); 
                    cn.commit();
                }    
                ob.put("mensaje", mensaje);
                ob.put("tipo_respuesta", tipo_respuesta);
           
         } catch (Exception e) 
            {           
                ob.put("mensaje", e.toString());
                ob.put("tipo_respuesta", "0");
            }
            out.print(ob); %>