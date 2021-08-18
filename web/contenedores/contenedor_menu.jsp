<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%     
    String id_rol = (String) sesionOk.getAttribute("id_rol");
    
  
         clases.controles.VerificarConexion();
  // Asignar conexin al objeto manejador de datos
    fuente.setConexion(clases.controles.connectSesion);
    String html="";

    ResultSet rs,rs2;
     rs2 = fuente.obtenerDato("select   html  from mae_ot_opciones_app a inner join mae_ot_det_roles b on a.id=b.id_opcion  where b.id_rol =  "+id_rol+"");
       while(rs2.next())
        {
          html=html+  rs2.getString(1);
        }
         
      
    out.print(html);  
   
 
%>