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
    String id_maquina = request.getParameter("id_maquina");
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String html2=""; 
    ResultSet rs,rs2;
    String sql="";
    if(id_maquina.equals("VINCULACION")){
        sql=" select "
             + "                    a.id as id_subcat,a.descripcion "
             + "                from "
             + "                    mae_ot_subcategorias a "
             + "                    inner join mae_ot_det_submaq b on a.id=b.id_subcategoria ";
    }
    else 
    {
        sql=" select "
             + "                    a.id as id_subcat,a.descripcion "
             + "                from "
             + "                    mae_ot_subcategorias a "
             + "                    inner join mae_ot_det_submaq b on a.id=b.id_subcategoria "
             + "                where "
             + "                    id_maquina='"+id_maquina+"'";
        html2= "<OPTION value='' disabled selected='selected'>SELECCIONE CATEGORIA</OPTION>";
    }
     rs2 = fuente.obtenerDato(sql);
       while(rs2.next())
        {
            html=html+"<OPTION  VALUE='"+ rs2.getString(1)+"'>"+ rs2.getString(2)+"</OPTION>";
        }
        ob.put("cbox_subcat",html2+html);
        out.print(ob);  %>
 