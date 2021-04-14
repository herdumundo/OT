<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="consultas_java.modelos"%>
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

    String rol       = request.getParameter("rol");
    String tipo       = request.getParameter("tipo");
   
    String mensaje="";
    String areas="";
    int tipo_respuesta=0;    
    try 
    {
        
        cn.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
        callableStatement = cn.prepareCall("{call [mae_ot_insert_rol](?,?,?,?)}");
        callableStatement .setString(1,   rol );
        callableStatement .setInt(2,   Integer.parseInt(tipo) );
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
            modelos.cargar_roles();
            sesionOk.setAttribute("combo_areas",modelos.combo_areas);

        }    
            ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", tipo_respuesta);
           
    } catch (Exception e) 
        {           
            ob.put("mensaje", e.toString());
            ob.put("tipo_respuesta", "0");
        }
            out.print(ob); %>