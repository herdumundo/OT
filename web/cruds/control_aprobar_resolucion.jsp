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

    String id_usuario       = (String) sesionOk.getAttribute("id_usuario");
    String id_pedido        = request.getParameter("id");
    String txt_resolucion        = request.getParameter("txt_resolucion");
    String nota             = request.getParameter("nota");
 
    String mensaje="";
    int tipo_respuesta=0;    
    try 
    {
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
        callableStatement = clases.controles.connectSesion.prepareCall("{call [mae_ot_aprobar_resolucion](?,?,?,?,?,?)}");
        callableStatement .setInt(1,    Integer.parseInt(id_usuario) );
        callableStatement .setInt(2,    Integer.parseInt(id_pedido) );
        callableStatement .setString(3, txt_resolucion );
        callableStatement .setString(4, nota); 
                
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
        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
           
    } catch (Exception e) 
    {           
        ob.put("mensaje", e.toString());
        ob.put("tipo_respuesta", "0");
    }
    out.print(ob); %>