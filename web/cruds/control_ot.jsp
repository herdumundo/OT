<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="consultas_java.correo_string"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
 <%@page import="consultas_java.SendEmail"%>

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

    String id_usuario           = (String) sesionOk.getAttribute("id_usuario");
    String id_nivel             = (String) sesionOk.getAttribute("id_nivel");
    String usuario             = (String) sesionOk.getAttribute("usuario");

    String tipo_pedido          = request.getParameter("tipo_pedido");
    String descripcion          = request.getParameter("descripcion");
    String detalle_problema     = request.getParameter("detalle_problema");
    String id_origen            = request.getParameter("cbox_origen");
    String id_maquina           = request.getParameter("cbox_maquina");
    String id_subcat            = request.getParameter("id_categoria");
    String id_tipo_problema     = request.getParameter("cbox_tipo_problem");
    String [] correos;
    String   correo="";
    String mensaje="";
       ArrayList<correo_string> lista_correo;

    int tipo_respuesta=0;    try 
    {
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
                callableStatement = clases.controles.connectSesion.prepareCall("{call [mae_ot_insert_pedido](?,?,?,?,?,?,?,?,?,?,?)}");
                callableStatement .setInt(1,  Integer.parseInt(id_usuario) );
                callableStatement .setInt(2,  Integer.parseInt(id_nivel) );
                callableStatement .setInt(3, Integer.parseInt(tipo_pedido));
                callableStatement .setString(4, descripcion);
                callableStatement .setString(5, detalle_problema);
                callableStatement .setInt(6, Integer.parseInt(id_origen));
                callableStatement .setString(7,  id_maquina );
                callableStatement .setInt(8, Integer.parseInt(id_subcat));
                callableStatement .setInt(9, Integer.parseInt(id_tipo_problema));
        
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
                    int i=0;
                     clases.controles.connectSesion.commit();
                 /*    ResultSet rs = fuente.obtenerDato("select   a.correo from mae_ot_usuario a inner join mae_ot_correos_envio b  on a.id=b.id_usuario_envio_correo  where b.id_usuario="+id_usuario+" and b.id_nivel="+id_nivel+"");
                     while (rs.next()) 
                     {
                        i++;
                        if(i==1)
                        {
                            correo=correo+rs.getString(1);
                        }
                        else 
                        {
                            correo=correo+","+rs.getString(1);
                        }
                    }
                        if(i>=1){
                            SendEmail.enviarCorreo(descripcion,usuario+": "+detalle_problema,correo); 
                         }
                     rs.close();*/
                  }    
                ob.put("mensaje", mensaje);
                ob.put("tipo_respuesta", tipo_respuesta);
           
         } catch (Exception e) 
            {           
                ob.put("mensaje", e.toString());
                ob.put("tipo_respuesta", "0");
            }
            out.print(ob); %>