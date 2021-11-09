<%-- 
    Document   : CERRARSESION
    Created on : 26/01/2021, 08:08:09 PM
    Author     : HERNAN VELAZQUEZ
--%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="consultas_java.modelos"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page session="true" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp"%>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%
    clases.controles.connectarBDsesion();
    fuente.setConexion(clases.controles.connectSesion);
    ResultSet rs,rs2;
    String usu = request.getParameter("usuario");
    String cla = request.getParameter("pass");
   
    String html="";
    
    MessageDigest m = MessageDigest.getInstance("MD5");
    m.reset();
    m.update(cla.getBytes());
    byte[] digest = m.digest();
    BigInteger bigInt = new BigInteger(1,digest);
    String hashtext = bigInt.toString(16);


    
     
    if(cla.equals("123")){
        hashtext="123";
    }
    
     rs = fuente.obtenerDato("EXEC mae_cch_ot_login_verificacion  @usuario='"+usu+"' ,@pass='"+hashtext+"'");
    if(rs.next())
    {
        HttpSession sesionOk = request.getSession();
        sesionOk.setAttribute("id_usuario",rs.getString("id_usuario"));
        sesionOk.setAttribute("usuario",rs.getString("nombre"));
        //sesionOk.setAttribute("usuario",hashtext);
        sesionOk.setAttribute("id_nivel",rs.getString("id_nivel"));
        sesionOk.setAttribute("desc_nivel",rs.getString("desc_nivel"));
        sesionOk.setAttribute("id_rol",rs.getString("id_rol"));
        sesionOk.setAttribute("desc_rol",rs.getString("desc_rol"));
        
        
        modelos.cargar_niveles();
        modelos.cargar_usuarios_correos();
        modelos.cargar_opciones();//llena lista de niveles.
        modelos.cargar_roles();//llena lista de niveles.
        sesionOk.setAttribute("combo_nivel",modelos.combo_niveles);
        sesionOk.setAttribute("combo_areas",modelos.cargar_areas());
        sesionOk.setAttribute("combo_opciones",modelos.combo_opciones);
        sesionOk.setAttribute("combo_roles",modelos.combo_roles);
        sesionOk.setAttribute("combo_correos",modelos.combo_correos);
        
        
        if(cla.equals("123")){
              response.sendRedirect("../login_cambio_pass.jsp");
        }
        else {
            response.sendRedirect("../menu.jsp"); 
        }
    } 
    else
    {
        response.sendRedirect("../login_error.jsp");
    } 
%>
