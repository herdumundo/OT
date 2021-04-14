<%-- 
    Document   : CERRARSESION
    Created on : 26/01/2016, 08:08:09 PM
    Author     : HERNAN VELAZQUEZ
--%>
<%@page import="consultas_java.modelos"%>
 <%@page import="javax.swing.JOptionPane"%>
<%@ page session="true" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp"%>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%
  // Crear objeto de conexion al DB
  Connection cn = conexion.crearConexion();
  // Asignar conexin al objeto manejador de datos
  fuente.setConexion(cn);
    ResultSet rs,rs2;
    String usu = request.getParameter("usuario");
    String cla = request.getParameter("pass");
      rs = fuente.obtenerDato("EXEC mae_cch_ot_login_verificacion  @usuario='"+usu+"' ,@pass='"+cla+"'");
    String html="";
    if(rs.next())
    {
        HttpSession sesionOk = request.getSession();
        sesionOk.setAttribute("id_usuario",rs.getString("id_usuario"));
        sesionOk.setAttribute("usuario",rs.getString("nombre"));
        sesionOk.setAttribute("id_nivel",rs.getString("id_nivel"));
        sesionOk.setAttribute("desc_nivel",rs.getString("desc_nivel"));
        sesionOk.setAttribute("id_rol",rs.getString("id_rol"));
        sesionOk.setAttribute("desc_rol",rs.getString("desc_rol"));
        response.sendRedirect("../menu.jsp"); 
        modelos.cargar_areas();
        modelos.cargar_niveles();
        modelos.cargar_opciones();//llena lista de niveles.
        modelos.cargar_roles();//llena lista de niveles.
        sesionOk.setAttribute("combo_nivel",modelos.combo);
        sesionOk.setAttribute("combo_areas",modelos.combo_areas);
        sesionOk.setAttribute("combo_opciones",modelos.combo_opciones);
        sesionOk.setAttribute("combo_roles",modelos.combo_roles);

    } 
    else
    {
   response.sendRedirect("../login_error.jsp");
    } 
%>
