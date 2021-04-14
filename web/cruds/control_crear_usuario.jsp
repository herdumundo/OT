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

    String nombre       = request.getParameter("nombre");
    String apellido     = request.getParameter("apellido");
    String usuario      = request.getParameter("usuario");
    String pass         = request.getParameter("pass");
    String correo       = request.getParameter("correo");
    String nivel        = request.getParameter("select_nivel_usuario");
    String rol          = request.getParameter("select_rol");
    String[] array_areas = request.getParameterValues("select_areas");
    String mensaje="";
    String areas="";
    int tipo_respuesta=0;    
    try 
    {
        for(int i=0; i<array_areas.length; i++)   
        {
            if (array_areas.length>1)
            {
                if(i==0)
                {
                    areas=array_areas[i];  
                }
                else 
                {
                    areas=areas+ ","+array_areas[i];  
                }
            }
            if (array_areas.length==1)
                {
                    areas=array_areas[i];  
                }
        }
        cn.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
                callableStatement = cn.prepareCall("{call [mae_ot_insert_usuarios](?,?,?,?,?,?,?,?,?,?)}");
                callableStatement .setString(1,   nombre );
                callableStatement .setString(2,   apellido);
                callableStatement .setString(3,  usuario);
                callableStatement .setString(4, pass);
                callableStatement .setString(5, correo);
                callableStatement .setInt(6, Integer.parseInt(nivel));
                callableStatement .setInt(7, Integer.parseInt(rol)  );
                callableStatement .setString(8, areas);
        
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